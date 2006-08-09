Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWHIPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWHIPWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWHIPWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:22:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:39764 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750987AbWHIPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:22:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hs4KqMDitaAr0BFvYWBZpd3CJN8amQXNMmMzXOR0569OPNhdOfUkwyCkev16CVyGjjElZuFQfy9xcldr6Z/OX6jlfItYJLrDd04mCNaNSYBsqQ7+VTLUCSRLib2OvFNmU09FYBkpQbyoxpN/1hMdC96pM8fEItftzx0e3/3+yzg=
Message-ID: <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
Date: Wed, 9 Aug 2006 17:22:28 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
In-Reply-To: <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> Molle Bestefich wrote:
> > I have a ~1TB filesystem that fails to mount, the message is:
> >
> > EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
>                   ^^^^^^^^^^^_________
>
> It seems as though you have a LOT of RAM if you can make a 1TB
> filesystem on the loopback device!

Why is that?
loop0 is backed by a MD device.

> Seriously, what are you doing, attempting to mount a big file-system
> through the loop-back device

Yes, and it has worked for...  well... many years now.

> or is this a copied-down message message
> you got during boot when initrd tried to mount a RAM disk?

No.

> > group 2338 not in group (block 1607003381)!
> > EXT3-fs: group descriptors corrupted !
>
> Ordinary disk repair involves running fsck on an UNMOUNTED file-system.

It _is_ unmounted.

(I've learned that lesson years ago.  Probably after seeing fsck
complaining loudly when I tried to run it on a mounted filesystem, if
I had to guess ;-).)

> > A day before, it worked flawlessly.
> >
> > What could have happened, and what's the best course of action?
>
> Any bad RAM, any shutdown without a proper unmount, any device hardware
> error like DMA not completing properly, can cause file-system corruption.
> That's why there are tools to fix it.

The hardware works flawlessly.
The shutdown was a regular shutdown -h.

Messages on the console indicated that Linux actually tried to
shutdown the filesystem before shutting down Samba, which is just
plain Real-F......-Stupid.  Is there no intelligent ordering of
shutdown events in Linux at all?

Samba was serving files to remote computers and had no desire to let
go of the filesystem while still running.  After 5 seconds or so,
Linux just shutdown the MD device with the filesystem still mounted.

That's what happened on a user-visible level, but what could have
happened internally in the filesystem?
