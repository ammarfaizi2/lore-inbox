Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbQKNXUz>; Tue, 14 Nov 2000 18:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131649AbQKNXUp>; Tue, 14 Nov 2000 18:20:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:30735 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131579AbQKNXUa>;
	Tue, 14 Nov 2000 18:20:30 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@freya.yggdrasil.com>
cc: linux-kernel@vger.kernel.org, vendor-sec@lst.de
Subject: Re: Local root exploit with kmod and modutils > 2.1.121 
In-Reply-To: Your message of "Tue, 14 Nov 2000 12:31:41 -0800."
             <200011142031.MAA07179@freya.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Nov 2000 09:50:16 +1100
Message-ID: <11108.974242216@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000 12:31:41 -0800, 
"Adam J. Richter" <adam@freya.yggdrasil.com> wrote:
>>The only secure fix I can see is to add SAFEMODE=1 to modprobe's
>>environment and change exec_modprobe.
>
>	SAFEMODE may mean other things to other programs, so that

MOD_SAFEMODE.

>	It would be much better to just add a command line option
>to modprobe that request_module() would cause it treat the following

Changing the command line is not an option.  Kernel 2.2 still runs with
modutils 2.1.121, changing the request_module command line would break
people using modutils 2.1.121 and force them to upgrade, AC would kill
me.  I needed a mechanism that would work with modutils 2.3 but have no
effect on modutils 2.1.121, remember that 2.1.121 does not have this
security exposure.  It also had to work on 2.2 kernels because many
people are using moditils 2.3 on 2.2 kernels.  SGI ship a 2.2 kernel
with devfs for their big machines, that needs modutils 2.3.

>	Another possible approach would be to create a separate
>/sbin/safe_modprobe.  modprobe already behaves differently
>based on whether argv[0] ends in "modprobe", "insmod", "depmod",
>or "rmmod".  So this would be in keeping with that convention.
>It would also be trivial to retrofit old systems.  Just have
>some system boot script do:
>
>		echo /sbin/safe_modprobe > /proc/sys/kernel/modprobe

I thought about that but it assumes that users will add that line to
their scripts - not guaranteed.  The fix needed a change that would
automatically detect that safe mode was required and not rely on manual
intervention.  Especially with 30+ Linux distributions out there.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
