Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292514AbSBTVPk>; Wed, 20 Feb 2002 16:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292515AbSBTVPT>; Wed, 20 Feb 2002 16:15:19 -0500
Received: from ulima.unil.ch ([130.223.144.143]:1664 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S292514AbSBTVPG>;
	Wed, 20 Feb 2002 16:15:06 -0500
Date: Wed, 20 Feb 2002 22:15:04 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5 don't compile (ALSA rtctimer and irda)
Message-ID: <20020220211504.GA5456@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

if I let rtctimer as a module in alsa (haven't tried in non module
form):

ld -m elf_i386  -r -o snd-timer.o timer.o
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trig
raphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-s
tack-boundary=2 -march=i686 -DMODULE  -DKBUILD_BASENAME=rtctimer  -DEXPORT_SYMTAB -
c rtctimer.c
rtctimer.c:76: parse error before `rtc_task'
rtctimer.c:76: warning: type defaults to `int' in declaration of `rtc_task'
rtctimer.c:76: warning: data definition has no type or storage class
rtctimer.c: In function `rtctimer_start':
rtctimer.c:100: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:100: (Each undeclared identifier is reported only once
rtctimer.c:100: for each function it appears in.)
rtctimer.c:100: `rtc' undeclared (first use in this function)
rtctimer.c:100: invalid lvalue in assignment
rtctimer.c:102: warning: implicit declaration of function `rtc_control'
rtctimer.c: In function `rtctimer_stop':
rtctimer.c:111: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:111: `rtc' undeclared (first use in this function)
rtctimer.c:111: invalid lvalue in assignment
rtctimer.c: In function `rtctimer_interrupt':
rtctimer.c:124: warning: implicit declaration of function `tasklet_hi_schedule'
rtctimer.c: In function `rtctimer_private_free':
rtctimer.c:144: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:144: `rtc' undeclared (first use in this function)
rtctimer.c:144: invalid lvalue in assignment
rtctimer.c:146: warning: implicit declaration of function `rtc_unregister'
rtctimer.c: In function `rtctimer_init':
rtctimer.c:175: warning: implicit declaration of function `tasklet_init'

And stupidly I do a make menuconfig and lost the end of the output...

And after removing it, all compiled fine, but make modules_install:

make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux-2.5.5/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.5.5/arch/i386/lib'
cd /lib/modules/2.5.5; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.5; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.5/kernel/net/irda/irda.o
depmod:         virt_to_bus_not_defined_use_pci_map
make: *** [_modinst_post] Error 1
20.430u 1.980s 0:23.55 95.1%    0+0k 0+0io 57039pf+0w
Exit 2

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
