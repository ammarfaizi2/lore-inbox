Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVD3X6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVD3X6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVD3X6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 19:58:43 -0400
Received: from mail.shareable.org ([81.29.64.88]:5292 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261468AbVD3X6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 19:58:36 -0400
Date: Sun, 1 May 2005 00:58:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Olivier Galibert <galibert@pobox.com>, Miklos Szeredi <miklos@szeredi.hu>,
       hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430235829.GB11494@mail.shareable.org>
References: <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu> <20050430164258.GA6498@mail.shareable.org> <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu> <20050430182016.GA41358@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430182016.GA41358@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> > > "mount --bind /proc/self/fd/N mount_point" works, try it.
> > 
> > What do people think about that?
> 
> To me it looks like an atrocious hack that works only because of the
> way the implementation is done and not really by design.

>From fs/namespace.c:do_loopback, the function which does bind mounts:

	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {

check_mnt() verifies that a mountpoint is in the same namespace as the
current process.  recurse is set for --rbind mounts, but not --bind mounts.

Notice how old_nd.mnt is explicitly _not_ checked for being in the current
namespace when doing --bind?

That says to me that Al thought about this case, and coded for it...

(I'm still not clear why the check_mnt() calls are needed at all, though).

-- Jamie
