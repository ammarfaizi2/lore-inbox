Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVEACkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVEACkA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 22:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVEACkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 22:40:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50819 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261516AbVEACjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 22:39:54 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Olivier Galibert <galibert@pobox.com>, Miklos Szeredi <miklos@szeredi.hu>,
       hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050430235829.GB11494@mail.shareable.org>
References: <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu>
	 <20050430083516.GC23253@infradead.org>
	 <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu>
	 <20050430094218.GA32679@mail.shareable.org>
	 <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu>
	 <20050430143609.GA4362@mail.shareable.org>
	 <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu>
	 <20050430164258.GA6498@mail.shareable.org>
	 <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
	 <20050430182016.GA41358@dspnet.fr.eu.org>
	 <20050430235829.GB11494@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114915182.4180.2110.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 30 Apr 2005 19:39:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-30 at 16:58, Jamie Lokier wrote:
> Olivier Galibert wrote:
> > > > "mount --bind /proc/self/fd/N mount_point" works, try it.
> > > 
> > > What do people think about that?
> > 
> > To me it looks like an atrocious hack that works only because of the
> > way the implementation is done and not really by design.
> 
> >From fs/namespace.c:do_loopback, the function which does bind mounts:
> 
> 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
> 
> check_mnt() verifies that a mountpoint is in the same namespace as the
> current process.  recurse is set for --rbind mounts, but not --bind mounts.
> 
> Notice how old_nd.mnt is explicitly _not_ checked for being in the current
> namespace when doing --bind?

> That says to me that Al thought about this case, and coded for it...
> 
> (I'm still not clear why the check_mnt() calls are needed at all, though).
> 
Making a wild guess.

What if some filesystem allowed access to vfsmount in other namespace?
Just like the proc filesystem having the ability to do so, but
marginally stops it through the check in proc_check_root().

However the check you mentioned above where-a-bind-mount-across-
namespace is allowed, implies that there is some legal way of getting
access to vfsmounts in other namespace.  Or maybe a remote possibility
that its a bug?

RP


> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

