Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWAEP2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWAEP2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWAEP2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:28:05 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:4549 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932075AbWAEP2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:28:04 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Thu, 5 Jan 2006 15:25:05 +0000
User-Agent: KMail/1.9
Cc: Greg KH <greg@kroah.com>, Nick Warne <nick@linicks.net>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
References: <200601041710.37648.nick@linicks.net> <200601042249.12116.s0348365@sms.ed.ac.uk> <43BC636D.3070109@zytor.com>
In-Reply-To: <43BC636D.3070109@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051525.05613.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 00:08, H. Peter Anvin wrote:
> Alistair John Strachan wrote:
> > Re-read the thread. The confusion here is about "going back" to 2.6.14
> > before patching 2.6.15. This has nothing to do with "rc kernels". We have
> > this documented explicitly in the kernel but not on the kernel.org FAQ.
>
> If you can send me some suggested verbiage I'll put it in the FAQ.  We
> can also make a page that's directly linked from the "stable release",
> kind of like we have info links for -mm patches etc.

I hope somebody else here can minimise my logic; I think the verbosity is 
necessary to completely explain the "patch nightmare" to everybody concerned.

I'm getting warnings about "Reversed (or previously applied) patch detected!" 
when I attempt to patch to an -rc, -mm or -stable kernel. How should this be 
done?

*Terms*

A Linus mainline "release" kernel is given an x.y.z version number (e.g. 
2.6.14). A -stable kernel is given an x.y.z.a version number (e.g., 
2.6.14.3).

*Patching*

New -stable or -rc patches are to be applied to Linus's mainline "release" 
kernels, not -stable, -rc or -mm kernel versions.

New -mm patches are to be applied either to the "release" kernel, or the 
applicable -rc kernel (whichever is newer), which are given an x.y.z-rcN 
version number (e.g. 2.6.15-rc2).

-	If you are on a -stable kernel, you need to revert the -stable patch before
	applying either an -rc, a new -stable, or new Linus "release" patch.

-	If you are on an -rc kernel, you need to revert the -rc patch if you want to
	apply another -rc patch, a -stable patch, or a new Linus "release" patch.

-	If you are on an -mm kernel, you need to revert the -mm patch and the -rc
	patch (if applicable), before applying either an -rc, -stable or new Linus 
	"release" patch.

*Patch Process*

For example, to patch to 2.6.14-rc3-mm3, when you were previously on 2.6.13.4, 
you would need to:

-	Download the full Linux 2.6.13 "release" tarball, or reverse the 2.6.13.4
	-stable patch.

	tar jxvf linux-2.6.13.tar.bz2				OR
	bzip2 -cd ../patch-2.6.13.4.bz2 | patch -Rp1	(whilst in linux directory).

-	Apply the 2.6.14-rc3 patch.

	bzip2 -cd ../patch-2.6.14-rc3.bz2 | patch -Np1 (whilst in linux directory).

-	Apply the 2.6.14-rc3-mm3 patch.

	bzip2 -cd ../2.6.14-rc3-mm3.bz2 | patch -Np1 (whilst in linux directory).

Most users will be confused by running a -stable kernel, and not being able to 
patch to the latest Linus "release" kernel. If you are on 2.6.13.4, and you 
want to go to 2.6.14, all you need to do is:

-	Download the full Linux 2.6.14 "release" tarball. Done.

	tar jxvf linux-2.6.14.tar.bz2

-	OR, Reverse the 2.6.13.4 patch from your existing tree. This will return you
	to Linus "release" 2.6.13.

	bzip2 -cd ../patch-2.6.13.4.bz2 | patch -Rp1 (whilst in linux directory).

-	Apply the 2.6.14 patch.

	bzip2 -cd ../patch-2.6.14.bz2 | patch -Np1 (whilst in linux directory).

Alternatively, if the above is too much for you, check out Matt Mackall's 
ketchup utility. This will automate the above process.

http://www.selenic.com/ketchup/


.. Okay, after writing that maybe Greg was correct. This will easily become 
the largest FAQ entry, even if it is a complete description of the issue at 
hand.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
