Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVCVBYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVCVBYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVCVBQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:16:11 -0500
Received: from smtpout.mac.com ([17.250.248.44]:15612 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262293AbVCVBOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:14:52 -0500
In-Reply-To: <20050321161925.76c37a7f.akpm@osdl.org>
References: <9e47339105030909031486744f@mail.gmail.com> <20050321154131.30616ed0.akpm@osdl.org> <9e473391050321155735fc506d@mail.gmail.com> <20050321161925.76c37a7f.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5dab45539e663d50b9e3e5d05fc11336@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>, Jon Smirl <jonsmirl@gmail.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: current linus bk, error mounting root
Date: Mon, 21 Mar 2005 20:14:29 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 21, 2005, at 19:19, Andrew Morton wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
>> Jens is right that this is a user space issue, but how many people are
>> going to find this out the hard way when their root drives stop
>> mounting. Since no one is complaining I have to assume that most
>> kernel developers have their root device drivers built into the
>> kernel. I was loading mine as a module since for a long time Redhat
>> was not shipping kernels with SATA built in.
>
> I don't agree that this is a userspace issue.  It's just not sane for a
> driver to be in an unusable state for an arbitrary length of time after
> modprobe returns.

What about if I'm booting from a USB drive?  In that case, because of 
the
asynchrony of USB probing, it may take 1 or 2 seconds for my attached 
hub
to power on, wake up, boot its embedded microprocessor, etc before it 
will
respond to signals.  In such a case, as far as the root hub can tell,
there are _no_ external devices for a couple seconds, and that's 
ignoring
that my external USB bootdrive may _also_ need time to "boot" before it
will be accessible, and that's only once its parent hub has become
available.

I think that the kernel needs some kind of wait-for-device API that is
accessible from kernel-space for the simple boot sequence, perhaps just
waiting for a specific kobject to be detected and complete 
initialization.

For an initrd/initramfs in userspace, dnotify on sysfs (For the static
/dev case), or dnotify on /dev (For the udev case) should allow it to
detect when the device is available.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


