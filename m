Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRCTP37>; Tue, 20 Mar 2001 10:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCTP3u>; Tue, 20 Mar 2001 10:29:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50067 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130454AbRCTP3j>;
	Tue, 20 Mar 2001 10:29:39 -0500
Message-ID: <3AB7771A.56577F95@mandrakesoft.com>
Date: Tue, 20 Mar 2001 10:28:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Juergen Rose,K17,0331-9772437,030-2425483" <rose@rz.uni-potsdam.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modules_install does not install acpi with linux-2.4.2
In-Reply-To: <3AB77397.6050902@rz.uni-potsdam.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Juergen Rose,K17,0331-9772437,030-2425483" wrote:
> if I try 'make modules_install' with linux-2.4.2 I get:
> ...
> mkdir -p /lib/modules/2.4.2/kernel/drivers/acpi/
> cp common.o dispatcher.o events.o hardware.o interpreter.o namespace.o
> parser.o resources.o tables.o os.o acpi_ksyms.o driver.o cmbatt.o cpu.o
> ec.o acpi_ksyms.o sys.o table.o power.o
> /lib/modules/2.4.2/kernel/drivers/acpi/
> cp: common.o: No such file or directory
...
> cp: tables.o: No such file or directory
> make[2]: *** [_modinst__] Error 1
> make[2]: Leaving directory `/usr/src_laptop450/linux-2.4.2/drivers/acpi'

> In .config I find with respect to ACPI only
> CONFIG_ACPI=m
> 
> Who can help me?

Doctor says:  don't do that.  :)  I don't know how you managed
CONFIG_ACPI=m, because the configuration system doesn't allow it. 
"dep_bool" means only Y or N, and we see the CONFIG_ACPI entry in
arch/i386/config.in is correct:

[jgarzik@rum linux_2_4]$ egrep -rw 'CONFIG_PM|CONFIG_ACPI' arch
[...edited output...]
arch/arm/config.in:   bool 'Power Management support' CONFIG_PM
arch/i386/config.in:bool 'Power Management support' CONFIG_PM
arch/i386/config.in:   dep_bool '  ACPI support' CONFIG_ACPI $CONFIG_PM
arch/i386/defconfig:CONFIG_PM=y
arch/ia64/config.in:      define_bool CONFIG_PM y
arch/ia64/config.in:      define_bool CONFIG_ACPI y

So the solution is not build ACPI as a module, because it shouldn't have
allowed you to do so in the first place :)

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
