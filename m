Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbTFMT06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265496AbTFMT06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:26:58 -0400
Received: from solen.ce.chalmers.se ([129.16.20.244]:2280 "EHLO
	solen.ce.chalmers.se") by vger.kernel.org with ESMTP
	id S265495AbTFMT0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:26:55 -0400
Message-ID: <16106.10391.41706.339@solen.ce.chalmers.se>
Date: Fri, 13 Jun 2003 21:40:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Florian-Daniel Otel <otel@ce.chalmers.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc8-laptop1 problems
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Reply-To: Florian-Daniel Otel <otel@ce.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[Sorry if this should go to other list, e.g. "laptopkernel", "acpi" or
whatever, I've lost touch w/ kernel devel years ago. Thanks for
understanding and for any redirects to a better resource, if needed] 


Hello there,

Kernel: 

2.4.21-rc8 (presently 2.4.21) w/  ..-laptop1 "patch" (*cough*)

Intended use:  

Fujitsu LifeBook P2120, which doesn't get USB to
bootstrap OK (I got to do a "First boot to WinXP with attached USB
kbd/mouse  then warm boot to Linux then it works" voodoo magic in order to
get USB kbd/mouse to be found, even if the modules load OK
otherwise. Apparently my black magic ball says is the ACPI initializ. to blame.
I would happily appreciate any pointers/ideas/second oppinions. Detailed
"p2120 kernel: PCI: No IRQ known for interrupt pin A of device
00:09.0" messages avail. on request :)).

In addition to that, I want swsusp to work as wonderfully as it does
now (2.4.20 + alim15x3 DMA patch + swsusp-beta17 patch+script). 

And world peace, thank you ;)


Problems when compiling 2.4.21-pre8-laptop1:

Problem 1)  AGP / agpgart:

If, in my .config:

[....]
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
[...]

the compilation breaks with:

gcc -D__KERNEL__ -I/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0 -g  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_fe  -c -o agpgart_fe.o agpgart_fe.c
gcc -D__KERNEL__ -I/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0 -g  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c:5108: `PCI_DEVICE_ID_VIA_8375' undeclared here (not in a function)
agpgart_be.c:5108: initializer element is not constant
agpgart_be.c:5108: (near initialization for `agp_bridge_info[55].device_id')
agpgart_be.c:5126: `PCI_DEVICE_ID_VIA_P4M266' undeclared here (not in a function)
agpgart_be.c:5126: initializer element is not constant
agpgart_be.c:5126: (near initialization for `agp_bridge_info[58].device_id')
gmake[4]: *** [agpgart_be.o] Error 1
gmake[4]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers/char/agp'
gmake[3]: *** [first_rule] Error 2
gmake[3]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers/char/agp'
gmake[2]: *** [_subdir_agp] Error 2
gmake[2]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers/char'
gmake[1]: *** [_subdir_char] Error 2
gmake[1]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers'
gmake: *** [_dir_drivers] Error 2



Well, I can get around this by saying "N" to
"CONFIG_AGP_[INTEL,I810,VIA,AMD,SiS]"  since it's only AGP_ALI I'm
intrested in. Or shouldn't I be ? 


Problem 2 and much more serious)  ACPI (!!!!) 


gcc -D__KERNEL__ -I/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0 -DMODULE -DMODVERSIONS -include /nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=acpiphp_glue  -c -o acpiphp_glue.o acpiphp_glue.c
acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:815: warning: passing arg 2 of `acpi_get_object_info_R4d2dc830' from incompatible pointer type
acpiphp_glue.c:821: subscripted value is neither array nor pointer
acpiphp_glue.c:826: incompatible type for argument 1 of `strcmp'
gmake[2]: *** [acpiphp_glue.o] Error 1
gmake[2]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers/hotplug'
gmake[1]: *** [_modsubdir_hotplug] Error 2
gmake[1]: Leaving directory `/nfs/__No_NFS/playground/linux-2.4.21-pre8-laptop1/drivers'
gmake: *** [_mod_drivers] Error 2


The relevant (?) parts from the .config: 

[...]

CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
CONFIG_I82092=y
CONFIG_I82365=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_ACPI=m

[....]



The compilation was done on a P4/Knoppix v3.2 (Debian unstable and egcs-2.95):

gcc -v 
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)



Any ideas ? How far behind is the acpi in 2.4.21 w.r.t. latest acpi patch ?


TIA,


Florian


P.S. Pls Cc: me on the replies, I'm not on this list.


