Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWARIo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWARIo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWARIo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:44:57 -0500
Received: from ihug-mail.icp-qv1-irony5.iinet.net.au ([203.59.1.199]:35467
	"EHLO mail-ihug.icp-qv1-irony5.iinet.net.au") by vger.kernel.org
	with ESMTP id S1030191AbWARIo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:44:56 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <43CDFFFE.3050907@eyal.emu.id.au>
Date: Wed, 18 Jan 2006 19:44:46 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org>
In-Reply-To: <20060117232701.GA7606@mars.ravnborg.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------030401000000030209010901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401000000030209010901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sam Ravnborg wrote:
> On Wed, Jan 18, 2006 at 08:54:54AM +1100, Eyal Lebedinsky wrote:
> 
>>Linus Torvalds wrote:
>>
>>>Ok, it's two weeks since 2.6.15, and the merge window is closed.
>>
>>I am looking at a problem where the build seems to remove /dev/null,
>>which is then created as a regular file (naturally). This did not
>>happen before.
>>
>># ls -l /dev/null
>>crw-rw-rw-  1 root root 1, 3 Jan 18 08:42 /dev/null
>># make distclean
>>  CLEAN   scripts/basic
>>  CLEAN   scripts/kconfig
>>  CLEAN   include/config
>>  CLEAN   .config .config.old include/asm include/linux/autoconf.h include/linux/version.h .kernelrelease
>># ls -l /dev/null
>>-rwxr-xr-x  1 root root 47 Jan 18 08:42 /dev/null
> 
> 
> Strange.
> I have tried to reproduce without luck...
> Can you please do above steps again with V=1 added like this:
> ls -l /dev/null
> make distclean V=1
> ls -l /dev/null

I added some lines to scripts/Makefile.clean:
        @ls -l /dev/null

I see some unusual statements at the end of the log:
	rm -rf
	rm -f
which should be safe but unusual.

But /dev/null seems to disappear earlier:

crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/kconfig
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/kconfig/lxdialog
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null

And /dev/null contains one line:

cat: .kernelrelease: No such file or directory

But I expect it was overwritten a few times though.


In scripts/kconfig/lxdialog/check-lxdialog.sh I see lines like
	echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
and I will not be surprised if gcc removed its output at
some point (on failure?).


kconfig/lxdialog is a new directory...

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat

--------------030401000000030209010901
Content-Type: text/plain;
 name="xxx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xxx"

crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/boot
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/boot/compressed
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=/data2/no-backup/kernels/linux-2.6-pre
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/crypto
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel/acpi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu/cpufreq
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu/mcheck
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu/mtrr
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/kernel/timers
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/lib
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/mach-default
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/mach-es7000
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/math-emu
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/mm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/oprofile
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/pci
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=arch/i386/power
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=block
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=crypto
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/dispatcher
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/events
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/executer
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/hardware
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/namespace
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/parser
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/resources
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/sleep
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/tables
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/acpi/utilities
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/amba
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/atm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/base
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/base/power
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/block
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/block/aoe
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/block/paride
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/bluetooth
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/cdrom
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/agp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/drm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/ftape
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/ftape/compressor
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/ftape/lowlevel
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/ftape/zftape
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/ipmi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/mwave
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/pcmcia
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/rio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/tpm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/char/watchdog
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/connector
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/cpufreq
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/crypto
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/dio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/eisa
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/fc4
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/firmware
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/hwmon
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/i2c
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/i2c/algos
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/i2c/busses
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/i2c/chips
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ide
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ide/arm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ide/cris
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ide/legacy
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ide/mips
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ide/pci
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/ieee1394
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/infiniband
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/infiniband/core
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/infiniband/hw/mthca
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/infiniband/ulp/ipoib
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/infiniband/ulp/srp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/joystick
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/joystick/iforce
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/keyboard
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/misc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/mouse
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/touchscreen
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/gameport
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/input/serio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/act2000
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/capi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/divert
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/hardware
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/hardware/avm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/hardware/eicon
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/hisax
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/hysdn
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/i4l
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/icn
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/isdnloop
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/pcbit
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/isdn/sc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/macintosh
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mca
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/md
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/common
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/b2c2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/bt8xx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/cinergyT2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/dvb-core
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/dvb-usb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/frontends
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/pluto2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/ttpci
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/ttusb-budget
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/dvb/ttusb-dec
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/radio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/video
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/video/cx25840
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/video/cx88
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/video/em28xx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/video/ovcamchip
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/media/video/saa7134
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/message
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/message/fusion
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/message/i2o
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mfd
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/misc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/misc/hdpuftrs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/misc/ibmasm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mmc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mtd
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mtd/chips
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mtd/devices
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mtd/maps
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mtd/nand
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/mtd/onenand
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/appletalk
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/arcnet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/arm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/bonding
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/chelsio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/cris
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/e1000
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/fec_8xx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/fs_enet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/hamradio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/ibm_emac
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/irda
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/ixgb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/ixp2000
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/pcmcia
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/phy
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/sk98lin
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/skfp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/tokenring
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/tulip
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/wan
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/wan/lmc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/wireless
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/wireless/hostap
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/net/wireless/prism54
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/nubus
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/parisc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/parport
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pci
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pci/hotplug
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pci/pcie
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pcmcia
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pnp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pnp/isapnp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pnp/pnpacpi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/pnp/pnpbios
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/rapidio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/rapidio/switches
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/sbus
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/sbus/char
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/aacraid
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/aic7xxx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/aic7xxx/aicasm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/arm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/ibmvscsi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/lpfc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/megaraid
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/pcmcia
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/qla2xxx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/scsi/sym53c8xx_2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/serial
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/serial/cpm_uart
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/serial/jsm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/sh
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/sh/superhyway
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/sn
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/spi
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/tc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/telephony
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/atm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/class
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/core
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/host
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/image
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/input
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/media
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/media/pwc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/misc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/misc/sisusbvga
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/mon
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/net
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/serial
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/storage
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/usb/gadget
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/aty
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/backlight
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/console
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/geode
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/kyro
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/logo
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/matrox
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/nvidia
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/riva
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/savage
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/sis
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/i810
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/video/intelfb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/w1
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=drivers/zorro
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/9p
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/adfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/affs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/afs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/autofs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/autofs4
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/befs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/bfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/cifs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/coda
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/configfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/cramfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/debugfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/devfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/devpts
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/efs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/exportfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ext2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ext3
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/fat
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/freevxfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/fuse
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/hfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/hfsplus
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/hostfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/hpfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/hppfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/hugetlbfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/isofs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/jbd
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/jffs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/jffs2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/jfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/lockd
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/minix
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/msdos
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ncpfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/nfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/nfs_common
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/nfsd
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/nls
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ntfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ocfs2
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ocfs2/cluster
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ocfs2/dlm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/openpromfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/partitions
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/proc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/qnx4
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ramfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/reiserfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/relayfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/romfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/smbfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/sysfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/sysv
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/udf
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/ufs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/vfat
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=fs/xfs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=init
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=ipc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=kernel
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=kernel/irq
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=kernel/power
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=lib
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=lib/reed_solomon
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=lib/zlib_deflate
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=lib/zlib_inflate
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=mm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/802
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/8021q
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/appletalk
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/atm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ax25
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bluetooth
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bluetooth/bnep
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bluetooth/cmtp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bluetooth/hidp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bluetooth/rfcomm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bridge
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/bridge/netfilter
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/core
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/dccp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/dccp/ccids
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/dccp/ccids/lib
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/decnet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/decnet/netfilter
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/econet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ethernet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ieee80211
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ipv4
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ipv4/ipvs
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ipv4/netfilter
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/ipx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/irda
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/irda/ircomm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/irda/irlan
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/irda/irnet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/key
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/lapb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/llc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/netfilter
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/netlink
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/netrom
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/packet
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/rose
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/rxrpc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/sched
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/sctp
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/sunrpc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/sunrpc/auth_gss
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/tipc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/unix
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/wanrouter
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/x25
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=net/xfrm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=security
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=security/keys
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=security/selinux
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=security/selinux/ss
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/arm
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/core
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/core/oss
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/core/seq
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/core/seq/instr
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/drivers
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/drivers/mpu401
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/drivers/opl3
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/drivers/opl4
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/drivers/vx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/i2c
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/i2c/other
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/ad1816a
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/ad1848
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/cs423x
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/es1688
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/gus
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/opti9xx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/sb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/isa/wavefront
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/mips
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/oss
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/oss/cs4281
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/oss/dmasound
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/oss/emu10k1
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/parisc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/ac97
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/ali5451
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/au88x0
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/ca0106
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/cs46xx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/cs5535audio
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/emu10k1
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/hda
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/ice1712
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/korg1212
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/mixart
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/nm256
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/pcxhr
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/rme9652
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/trident
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/vx222
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pci/ymfpci
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pcmcia
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pcmcia/pdaudiocf
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/pcmcia/vx
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/ppc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/sparc
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/synth
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/synth/emux
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/usb
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=sound/usb/usx2y
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=usr
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
  rm -rf .tmp_versions
  rm -f arch/i386/boot/fdimage arch/i386/boot/mtools.conf vmlinux System.map .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
make -f scripts/Makefile.clean obj=Documentation/DocBook
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=Documentation/DocBook/man/
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/basic
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/genksyms
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/kconfig
crw-rw-rw-  1 root root 1, 3 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/kconfig/lxdialog
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/mod
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
make -f scripts/Makefile.clean obj=scripts/package
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
-rwxr-xr-x  1 root root 11650 Jan 18 19:31 /dev/null
  rm -rf 
  rm -f 
-rwxr-xr-x  1 root root 47 Jan 18 19:31 /dev/null

--------------030401000000030209010901--
