Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290620AbSA3V0i>; Wed, 30 Jan 2002 16:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290622AbSA3V0b>; Wed, 30 Jan 2002 16:26:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42502 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290620AbSA3V0W>;
	Wed, 30 Jan 2002 16:26:22 -0500
Message-ID: <3C586355.A396525B@zip.com.au>
Date: Wed, 30 Jan 2002 13:19:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> A kernel fix to do proper SMP shutdown so that you can kexec on a SMP kernel

Oh man, you rock.  I spent about ten hours last weekend
trying to teach 2-kernel-monte to do this.  But the damn
XT clock refused to deliver interrupts to the secondary
kernel when the primary had local APCI enabled :(

On uniprocessor, you can type `sudo monte /boot/bzImage'
and get to `decompressing linux' in two seconds flat. (Having
journalling filesystems rather helps with this trick). It's
lovely.


> The biggest issue I have had is
> with the kernel not properly shutting down devices.

Monte just disables all busmastering on the PCI devices...

> In the short term shutting down devices is trivially handled by
> umounting filesystems, downing ethernet devices, and calling the
> reboot notifier chain.  Long term I need to call the module_exit
> routines but they need a little sorting out before I can use them
> during reboot.  In particular calling any module_exit routing that clears
> pm_power_off is a no-no.

module_exit() routines for statically-linked drivers often
don't exist - they're in .text.exit.  I guess you can just
move .text.exit out of the /DISCARD/ section in vmlinux.lds.
Also, take a look at user-mode-linux's do_exitcalls()
implementation - there's no clear reason why that shouldn't
be mainstreamed.


It would be convenient to be able to directly boot a bzImage,
but I guess elf is workable.

Great work, and thanks!  I look forward to 2-second SMP
reboots.

-
