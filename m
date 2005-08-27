Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVH0DMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVH0DMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 23:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVH0DMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 23:12:38 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:53434 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1030288AbVH0DMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 23:12:38 -0400
Date: Sat, 27 Aug 2005 03:21:27 +0000
From: Kent Robotti <dwilson24@nyc.rr.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050827032127.GA4736@Linux.nyc.rr.com>
Reply-To: dwilson24@nyc.rr.com
References: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com> <20050826190647.GA12296@taniwha.stupidest.org> <20050826200851.GA851@Linux.nyc.rr.com> <20050826202226.GA13807@taniwha.stupidest.org> <20050826211231.GA957@Linux.nyc.rr.com> <20050827004045.GA17686@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050827004045.GA17686@taniwha.stupidest.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 05:40:45PM -0700, Chris Wedgwood wrote:
> On Fri, Aug 26, 2005 at 09:12:31PM +0000, Kent Robotti wrote:
> 
> > Ideally, I don't know why you would want to overmount unless the
> > kernel detects an initramfs.
> 
> because the rootfs doesn't work the way you think it does.  there are
> a number of complex and sublte issues
> 
> if you look at the patch it does quite a lot of work because of this

The purpose of the patch is to overmount ramfs/rootfs with tmpfs before
the compressed cpio archive is unpacked and /init is run.

If there's no compressed cpio archive there's no need to overmount
with tmpfs, because we're not doing initramfs.

That's my understanding of it.

> > I know the patch is just a quick and simple way to use tmpfs for
> > initramfs, and it seems to work.
> 
> as previously mentioned, there are a number of subtle issues to
> consider that are non-obvious
> 
> people are free to do their own patches but the rootfs does not always
> work the way you expect it to
> 
> > But, it would be nice if were cleaned up for that less than one
> > percent.
> 
> given most people don't need/want this i don't see that happening.
> once klibc is merged i might go over this again but until then it
> doesn't seem useful

Even as it is I find it useful.

But, it's only needed because the current initramfs implementation doesn't
offer tmpfs as an option.

If you had the option of using tmpfs as the initramfs you wouldn't need
to do pivot-root or mount-move etc., because you would already be where
you wanted.

/init could just be a symbolic link to /sbin/init, or it could be
some other executable (shell script etc.), but there would be no need
to pivot or move root.
