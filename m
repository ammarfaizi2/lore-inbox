Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266194AbRF3O5d>; Sat, 30 Jun 2001 10:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266195AbRF3O5X>; Sat, 30 Jun 2001 10:57:23 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:34185 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266194AbRF3O5O>; Sat, 30 Jun 2001 10:57:14 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 30 Jun 2001 07:57:10 -0700
Message-Id: <200106301457.HAA14801@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am following up my own message here.

>>> = Adam Richter
>>  = Alan Cox
>   = Adam Richter

>>> 	Argh!  I just accidentally sent and older version of my
>>> patch.  Here is the current version.  Sorry about that.

>>This just breaks stuff

>>> +for var in $(cat arch/*/config.in |
>>> +	     egrep -w -v '^[ 	]*int' |
>>> +             tr '   $"' '\n\n\n' |
>>> +	     egrep '^CONFIG_[A-Z0-9_]*$' |
>>> +	     sort -u) ; do
>>> +	define_bool "$var" "n"
>>> +done
>>> +set -f
>>>  

>>You've changed the entire semantics of dep_tristate by doing this

>	Please provide a real example.

	Although I am curious about what you had in mind about
dep_tristate, I no longer need to see this example to see a problem
with my patch.  My patch breaks detection of "new" variables in
arch/*/config.in by "make oldconfig."

	So, I guess something like Keith Owens's patch would be the
way to go, with some additional definitions (CONFIG_AGP, CONFIG_PCI,
CONFIG_ISA, CONFIG_EISA, CONFIG_PCMCIA, and possibly others).  I am
not sure which other conditionals might also be incorrectly ignored by
some instances of dep_xxx.  Below, I have included a list of the 52
CONFIG_* variables that are used as arguments to dep_xxx in 2.4.6-pre6
and appear in arch/*/config.in.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

CONFIG_ACPI
CONFIG_AGP
CONFIG_AMIGA
CONFIG_ARCH_ACORN
CONFIG_ARCH_ARCA5K
CONFIG_ARCH_CLPS711X
CONFIG_ARCH_FOOTBRIDGE
CONFIG_ARCH_NETWINDER
CONFIG_ARCH_SA1100
CONFIG_ATARI
CONFIG_ATM
CONFIG_BLK_DEV_IDE
CONFIG_BLK_DEV_LOOP
CONFIG_BLK_DEV_RAM
CONFIG_BUSMOUSE
CONFIG_CPU_26
CONFIG_CPU_32
CONFIG_DEBUG_LL
CONFIG_DEVFS_FS
CONFIG_DRM
CONFIG_EISA
CONFIG_EXPERIMENTAL
CONFIG_FOOTBRIDGE
CONFIG_GVPIOEXT
CONFIG_IDE
CONFIG_IEEE1394
CONFIG_IEEE1394_OHCI1394
CONFIG_INPUT
CONFIG_ISA
CONFIG_ISDN
CONFIG_MAC
CONFIG_MCA
CONFIG_MD
CONFIG_MODULES
CONFIG_NET
CONFIG_PARPORT
CONFIG_PCI
CONFIG_PCMCIA
CONFIG_PM
CONFIG_PPP
CONFIG_PROC_FS
CONFIG_SA1100_ASSABET
CONFIG_SBUS
CONFIG_SCSI
CONFIG_SERIAL
CONFIG_SGI
CONFIG_SOUND
CONFIG_SPARC64
CONFIG_UNIX98_PTYS
CONFIG_VIDEO_DEV
CONFIG_X86
CONFIG_ZORRO
