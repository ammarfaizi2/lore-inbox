Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbSKCTpZ>; Sun, 3 Nov 2002 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSKCTpZ>; Sun, 3 Nov 2002 14:45:25 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16656 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263356AbSKCTpX>; Sun, 3 Nov 2002 14:45:23 -0500
Message-Id: <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.5: troubles with piping make output
Date: Sun, 3 Nov 2002 22:38:13 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua> <20021103182805.GA1057@mars.ravnborg.org>
In-Reply-To: <20021103182805.GA1057@mars.ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 16:28, Sam Ravnborg wrote:
> On Sun, Nov 03, 2002 at 02:14:35PM -0200, Denis Vlasenko wrote:
> > My favorite way of running make is
> >
> > make "$@" 2>&1 | tee --append !make.log
> >
> > but in 2.5.45 it does not work. Removing '| tee ...'
> > part fixes it, but I'd like to retain the old way
> > for obvious reasons.
>
> Well, works for me, except that bash dislike '!'.

Okay, look here:

# cat mk.sh
#!/bin/sh

>>0make.log echo
>>0make.log echo "Date: `date`"
>>0make.log echo "Directory: `pwd`"
>>0make.log echo "Command: make $@"
>>0make.log echo "============="

CFLAGS=-std=gnu99 \
GCC_EXEC_PREFIX=/usr/app/gcc-3.2/lib/gcc-lib/ \
QTDIR=/usr/app/qt-3.0.3posix \
make "$@" 2>&1 | tee --append 0make.log

Ok, I untarred fresh 2.5.45, copied ~2.4.18 .config and ran:

# ./mk.sh oldconfig
   rm -f scripts/built-in.o; ar rcs scripts/built-in.o
  gcc -Wp,-MD,scripts/.fixdep.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -o scripts/fixdep scripts/fixdep.c
  gcc -Wp,-MD,scripts/.split-include.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -o scripts/split-include scripts/split-include.c
  gcc -Wp,-MD,scripts/.docproc.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -o scripts/docproc scripts/docproc.c
  gcc -Wp,-MD,scripts/.conmakehash.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -o scripts/conmakehash scripts/conmakehash.c
  cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/conf.o scripts/kconfig/conf.c
sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
  gcc -Wp,-MD,scripts/kconfig/.kconfig_load.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/kconfig_load.o scripts/kconfig/kconfig_load.c
  gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/mconf.o scripts/kconfig/mconf.c
  cat scripts/kconfig/zconf.tab.c_shipped > scripts/kconfig/zconf.tab.c
  cat scripts/kconfig/lex.zconf.c_shipped > scripts/kconfig/lex.zconf.c
  gcc -Wp,-MD,scripts/kconfig/.zconf.tab.o.d -fPIC -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -Iscripts/kconfig -c -o scripts/kconfig/zconf.tab.o scripts/kconfig/zconf.tab.c
  gcc  -shared -o scripts/kconfig/libkconfig.so scripts/kconfig/zconf.tab.o
  gcc  -o scripts/kconfig/conf scripts/kconfig/conf.o scripts/kconfig/libkconfig.so
./scripts/kconfig/conf -o arch/i386/Kconfig
.config:24: trying to assign nonexistent symbol LOLAT
.config:25: trying to assign nonexistent symbol LOLAT_SYSCTL
.config:172: trying to assign nonexistent symbol BLK_DEV_LVM
.config:258: trying to assign nonexistent symbol BLK_DEV_IDETAPE
.config:307: trying to assign nonexistent symbol BLK_DEV_ATARAID
.config:308: trying to assign nonexistent symbol BLK_DEV_ATARAID_PDC
.config:309: trying to assign nonexistent symbol BLK_DEV_ATARAID_HPT
.config:320: trying to assign nonexistent symbol SD_EXTRA_DEVS
.config:331: trying to assign nonexistent symbol SCSI_DEBUG_QUEUES
.config:579: trying to assign nonexistent symbol INPUT_KEYBDEV
.config:591: trying to assign nonexistent symbol SERIAL
.config:609: trying to assign nonexistent symbol ATIXL_BUSMOUSE
.config:610: trying to assign nonexistent symbol LOGIBUSMOUSE
.config:611: trying to assign nonexistent symbol MS_BUSMOUSE
.config:612: trying to assign nonexistent symbol MOUSE
.config:613: trying to assign nonexistent symbol PSMOUSE
.config:614: trying to assign nonexistent symbol 82C710_MOUSE
.config:615: trying to assign nonexistent symbol PC110_PAD
.config:765: trying to assign nonexistent symbol ZLIB_FS_INFLATE

as it seem to hang here.

Ok, let's do it without mk.sh:

# CFLAGS=-std=gnu99 GCC_EXEC_PREFIX=/usr/app/gcc-3.2/lib/gcc-lib/ QTDIR=/usr/app/qt-3.0.3posix make oldconfig   cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/conf.o scripts/kconfig/conf.c
sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
  gcc -Wp,-MD,scripts/kconfig/.kconfig_load.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/kconfig_load.o scripts/kconfig/kconfig_load.c
  gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/mconf.o scripts/kconfig/mconf.c
  cat scripts/kconfig/zconf.tab.c_shipped > scripts/kconfig/zconf.tab.c
  cat scripts/kconfig/lex.zconf.c_shipped > scripts/kconfig/lex.zconf.c
  gcc -Wp,-MD,scripts/kconfig/.zconf.tab.o.d -fPIC -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -Iscripts/kconfig -c -o scripts/kconfig/zconf.tab.o scripts/kconfig/zconf.tab.c
  gcc  -shared -o scripts/kconfig/libkconfig.so scripts/kconfig/zconf.tab.o
  gcc  -o scripts/kconfig/conf scripts/kconfig/conf.o scripts/kconfig/libkconfig.so
./scripts/kconfig/conf -o arch/i386/Kconfig
#
# using defaults found in .config
#
.config:24: trying to assign nonexistent symbol LOLAT
.config:25: trying to assign nonexistent symbol LOLAT_SYSCTL
.config:172: trying to assign nonexistent symbol BLK_DEV_LVM
.config:258: trying to assign nonexistent symbol BLK_DEV_IDETAPE
.config:307: trying to assign nonexistent symbol BLK_DEV_ATARAID
.config:308: trying to assign nonexistent symbol BLK_DEV_ATARAID_PDC
.config:309: trying to assign nonexistent symbol BLK_DEV_ATARAID_HPT
.config:320: trying to assign nonexistent symbol SD_EXTRA_DEVS
.config:331: trying to assign nonexistent symbol SCSI_DEBUG_QUEUES
.config:579: trying to assign nonexistent symbol INPUT_KEYBDEV
.config:591: trying to assign nonexistent symbol SERIAL
.config:609: trying to assign nonexistent symbol ATIXL_BUSMOUSE
.config:610: trying to assign nonexistent symbol LOGIBUSMOUSE
.config:611: trying to assign nonexistent symbol MS_BUSMOUSE
.config:612: trying to assign nonexistent symbol MOUSE
.config:613: trying to assign nonexistent symbol PSMOUSE
.config:614: trying to assign nonexistent symbol 82C710_MOUSE
.config:615: trying to assign nonexistent symbol PC110_PAD
.config:765: trying to assign nonexistent symbol ZLIB_FS_INFLATE
*
* Linux Kernel Configuration
*
*
* Code maturity level options
*
Prompt for development and/or incomplete code/drivers (EXPERIMENTAL) [Y/n/?] y
*
* General setup
*
Networking support (NET) [Y/n/?] y
System V IPC (SYSVIPC) [Y/n/?] y
BSD Process Accounting (BSD_PROCESS_ACCT) [Y/n/?] y
Sysctl support (SYSCTL) [Y/n/?] y
*
* Loadable module support
*
Enable loadable module support (MODULES) [Y/n/?] y
  Set version information on all module symbols (MODVERSIONS) [Y/n/?] y
  Kernel module loader (KMOD) [Y/n/?] y
*
* Processor type and features
*
Processor family (386, 486, 586/K5/5x86/6x86/6x86MX, Pentium-Classic, Pentium-MMX, Pentium-Pro/Celeron/Pentium-II, Pentium-III/Celeron(Coppermine), Pentium-4, K6/K6-II/K6-III, Athlon/Duron/K7, Elan, Crusoe, Winchip-C6, Winchip-2, Winchip-2A/Winchip-3, CyrixIII/VIA-C3) [386] (NEW)

and it politely waits for my input.

Looks like fflush() got forgotten somewhere ;)
--
vda
