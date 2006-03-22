Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWCVOrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWCVOrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWCVOrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:47:39 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:38371 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbWCVOri convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:47:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dLQSYo2g/R4/VW9IMkuh80Js0TH5L2T59PK4yTCbA0a+AuPyUONxvG7I9GThSRcz9kCC85YFTx1h8vesiYz5M8BvDXUDZ8Tg6ic1wwxP6+DgL47maMDo5NlXVZyj/6enYE/IpHP4IHJuHw/ZORIeI9+FT2lW/KDP0mAQXycFq3w=
Message-ID: <69304d110603220647o3b91140audfcd5e211e7b0b71@mail.gmail.com>
Date: Wed, 22 Mar 2006 15:47:34 +0100
From: "Antonio Vargas" <windenntw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Merge strategy for klibc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dvq5km$o0g$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <441F0859.2010703@zytor.com>
	 <Pine.LNX.4.64.0603202228441.17704@scrub.home>
	 <dvq5km$o0g$1@terminus.zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Followup to:  <Pine.LNX.4.64.0603202228441.17704@scrub.home>
> By author:    Roman Zippel <zippel@linux-m68k.org>
> In newsgroup: linux.dev.kernel
> >
> > You forgot to provide any information (at least a summary) about what this
> > is and how this will work. Please don't assume everyone is familiar with
> > it.
> >
> > There is one major question: how will this interface to distributions?
> >
> > How can distributions add their own initializations and configurations or
> > are they going to put an initrd on top of the kernel initrd? If this will
> > have a kernel and a distribution part, it poses the question whether klibc
> > has to be distributed with the kernel at all (a libc has a standard API
> > after all) and the kernel just provides the kernel specific parts to
> > whatever the distribution provides.
> >
>
> Okay... quick summary (again)...
>
> klibc is a small libc, small enough that it provides negible (or even
> negative) overhead to bundle it inside the kernel binary.
>
> The kernel tree part is there so that we can rip out in-kernel code
> without breaking compatibility, or requiring a distribution-provided
> initramfs.  In the future, we could consider retaining certain
> binaries in the rootfs and have "on-demand userspace" by the kernel,
> e.g. to do partition enumeration in userspace in a
> backwards-compatible manner.
>
> The default build provides a single binary called kinit, which is
> (modulo any bugs) equivalent to the in-kernel root-mounting code, with
> all its variants (initrd, nfsroot, load ramdisk from floppy, yadda
> yadda.)  The existence of kinit allows the in-kernel code to be
> removed without actually removing a feature.  Hence, the reason to put
> this in the kernel tree is to make sure there is zero impact on
> distributions.
>
> If the distribution uses initramfs directly, kinit goes unused.  The
> klibc code is also available as a standalone distribution, which at
> least Ubuntu is currently using to build a custom initramfs.  Because
> the kinit code is still userspace, it can share considerable amounts
> of code with the standalone klibc utilities collection; in fact most
> of the kinit pieces are available as standalone binaries which can be
> weaved together by scripts or other C code.
>
> The advantages of moving this code to userspace, thus is:
>
>  - Simpler programming model (harder to screw up)
>  - Easier to share code with distribution-customized setups
>  - Code can be tested as standalone userspace binaries at runtime
>
> A lot of the benefit is lost if, like now, there is a piece of code
> which has to be written for kernel-mode programming, separate from
> anything else and not testable except through a tedious kernel boot
> cycle.
>
>         -hpa

ISTM that we are (finally? ;) moving piece by piece to a mixed
monolothic+microkenel, or rather that many of the things that were
first implemented in-kernel (on linux or other unixes) are being
slowly jettisoned to a kernel-provided userspace. All in all this is a
good step forward :)

Regarding helping test/develop this, is there any small distro already
using klibc for such purposes? Maybe you, hpa, could share you klibc
testing rig? This looks ripe for a qemu-based testing at the moment,
not being performance critical like many other current developments...

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
