Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVIBLqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVIBLqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 07:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVIBLqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 07:46:33 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:40075 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751215AbVIBLqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 07:46:32 -0400
Date: Fri, 2 Sep 2005 13:46:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Teigland <teigland@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050902114609.GA11059@wohnheim.fh-wedel.de>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org> <20050902094403.GD16595@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050902094403.GD16595@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 September 2005 17:44:03 +0800, David Teigland wrote:
> On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:
> 
> > +	gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0,);
> 
> > what is gfs2_assert() about anyway? please just use BUG_ON directly
> > everywhere
> 
> When a machine has many gfs file systems mounted at once it can be useful
> to know which one failed.  Does the following look ok?
> 
> #define gfs2_assert(sdp, assertion)                                       \
> do {                                                                      \
>         if (unlikely(!(assertion))) {                                     \
>                 printk(KERN_ERR                                           \
>                         "GFS2: fsid=%s: fatal: assertion \"%s\" failed\n" \
>                         "GFS2: fsid=%s:   function = %s\n"                \
>                         "GFS2: fsid=%s:   file = %s, line = %u\n"         \
>                         "GFS2: fsid=%s:   time = %lu\n",                  \
>                         sdp->sd_fsname, # assertion,                      \
>                         sdp->sd_fsname,  __FUNCTION__,                    \
>                         sdp->sd_fsname, __FILE__, __LINE__,               \
>                         sdp->sd_fsname, get_seconds());                   \
>                 BUG();                                                    \
>         }                                                                 \
> } while (0)

That's a lot of string constants.  I'm not sure how smart current
versions of gcc are, but older ones created a new constant for each
invocation of such a macro, iirc.  So you might want to move the code
out of line.

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
