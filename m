Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbTE1UES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbTE1UES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:04:18 -0400
Received: from ppp5.jh-inst.cas.cz ([147.231.28.150]:25582 "EHLO
	jp.jh-inst.cas.cz") by vger.kernel.org with ESMTP id S264852AbTE1UEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:04:13 -0400
Date: Wed, 28 May 2003 22:17:21 +0200
From: Jiri Pittner <jiri.pittner@jh-inst.cas.cz>
Message-Id: <200305282017.h4SKHLnI020821@jp.jh-inst.cas.cz>
To: linux-kernel@vger.kernel.org
Subject: suspect bug in 2.4.20 pcnet32.c driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel developers,

I would like to report a suspect bug, newly introduced into 2.4.20 with respect
to correct 2.4.18.

Summary: errorneous netstat -i report about pcnet32 ethernet interface
Description: under 2.4.20 kernel with pcnet32 ethernet driver netstat -i reports 
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
eth0   1500   0     138      0      0      0      0     155      0      0 BMRU
(all TX packets errorneous), but the network actually works most the time normally,
sometimes irreproducibly irregularly it hangs.

Kernel versions: Linux version 2.4.20-4GB (root@jp) (gcc version 3.2) #15 Mon May 26 22:56:39 CEST 2003
The source has been taken from SuSE 8.2 distribution
2.4.18.SUSE kernel works fine

I have tried to take just the drivers/net/pcnet32.c file from 2.4.18.SuSE
and use it instead of the newer pcnet32.c from the 2.4.20 (compiled and loaded as a module).
This works fine, pcnet32.o module from 2.4.18 sources compiled within  the 2.4.20 kernel and loaded as a module to the new kernel works!
So I am pretty sure the problem must be in the changes made between
2.4.18 and 2.4.20 versions of pcnet32.c

My hardware: notebook UMAX 770
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 701.600
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1399.19

lshw:
        *-network
             description: Ethernet controller
             product: 79c970 [PCnet LANCE]
             vendor: Advanced Micro Devices [AMD]
             version: 44
             clock: 33MHz
             capabilities: bus_master cap_list
             configuration: driver=pcnet32 irq=9
(I have noticed same irq reported also  for 
        *-bridge:1 UNCLAIMED
             description: Bridge
             product: 82371AB/EB/MB PIIX4 ACPI
             vendor: Intel Corp.
             version: 03
             clock: 33MHz
             configuration: irq=9
)


pcnet32.c from 2.4.18.SuSE is 
#define DRV_NAME        "pcnet32"
#define DRV_VERSION     "1.27a"
#define DRV_RELDATE     "10.02.2002"
#define PFX             DRV_NAME ": "


and from 2.4.20.SuSE is 
#define DRV_NAME        "pcnet32"
#define DRV_VERSION     "1.27b"
#define DRV_RELDATE     "01.10.2002"
#define PFX             DRV_NAME ": "



With best regards,

Jiri Pittner
