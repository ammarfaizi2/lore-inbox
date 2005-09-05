Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVIEI6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVIEI6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVIEI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:58:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:29639 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932294AbVIEI6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:58:10 -0400
Date: Mon, 5 Sep 2005 10:58:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Teigland <teigland@redhat.com>
Cc: Greg KH <greg@kroah.com>, arjan@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905085808.GA22802@wohnheim.fh-wedel.de>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org> <20050902094403.GD16595@redhat.com> <20050903052821.GA23711@kroah.com> <20050905034739.GA11337@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050905034739.GA11337@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 September 2005 11:47:39 +0800, David Teigland wrote:
> 
> Joern already suggested moving this out of line and into a function (as it
> was before) to avoid repeating string constants.  In that case the
> function, file and line from BUG aren't useful.  We now have this, does it
> look ok?

Ok wrt. my concerns, but not with Greg's.  BUG() still gives you
everything that you need, except:
o fsid

Notice how this list is just one entry long? ;)

So how about


#define gfs2_assert(sdp, assertion) do {			\
	if (unlikely(!(assertion))) {				\
	printk(KERN_ERR "GFS2: fsid=\n", (sdp)->sd_fsname);	\
	BUG();							\
} while (0)


Or, to move the constant out of line again


void __gfs2_assert(struct gfs2_sbd *sdp) {
	printk(KERN_ERR "GFS2: fsid=\n", sdp->sd_fsname);
}

#define gfs2_assert(sdp, assertion) do {\
	if (unlikely(!(assertion))) {	\
	__gfs2_assert(sdp);		\
	BUG();				\
} while (0)


Jörn

-- 
Admonish your friends privately, but praise them openly.
-- Publilius Syrus 
