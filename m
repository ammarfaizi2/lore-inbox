Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTGRXdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270432AbTGRXdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:33:46 -0400
Received: from 207-5-214-182.metrocast.net ([207.5.214.182]:35844 "EHLO
	207-5-214-182.metrocast.net") by vger.kernel.org with ESMTP
	id S270430AbTGRXdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:33:44 -0400
Date: Fri, 18 Jul 2003 19:48:31 -0400
From: root@207-5-214-182.metrocast.net
Message-Id: <200307182348.h6INmVSV001349@207-5-214-182.metrocast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G and the GPL
Reply-To: bugnet@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[FYI: Please cc: me; I'm not on lkml, thanks.]
                                                                               
On Sat, Jun 07, 2003 at 10:41:23PM -0400, Andrew Miklas wrote:
> However, I have gone through all the available information on the Linksys
> website, and can find no reference to the GPL, Linux (as it relates to
> this product), or the firmware source code. Also, the firmware binary
> (see below) is freely available from their website. There is no link
> from the download page to the source, or any mention of Linux or the GPL.

[snip]

> few of the newer 802.11b and (nearly?) all 802.11g chips. Incidentally,
> Linux has excellent support for at least one manufacturer's wireless family.
> The following Broadcom chips all appear to be supported under Linux -- if you
> happen to be running Linux on a MIPS processor in a Linksys router:
>
> Broadcom BCM4301 Wireless 802.11b Controller
> Broadcom BCM4307 Wireless 802.11b Controller
> Broadcom BCM4309 Wireless 802.11a Controller
> Broadcom BCM4309 Wireless 802.11b Controller
> Broadcom BCM4309 Wireless 802.11 Multiband Controller
> Broadcom BCM4310 Wireless 802.11b Controller
> Broadcom BCM4306 Wireless 802.11b/g Controller
> Broadcom BCM4306 Wireless 802.11a Controller                                 
> Broadcom BCM4306 Wireless 802.11 Multiband Controller
>
> This list was produced by running strings on:
> lib/modules/2.4.5/kernel/drivers/net/wl/wl.o
>

[much discussion]

On Maw, 2003-07-08 at 12:30, Matthew Hall wrote:
> Hi lkml,
> I don't know if anyone's noticed, but Linksys have opened up and
> released their code.
> 
> http://www.linksys.com/support/gpl.asp

Remember the reason we were poking around inside the Linksys firmware? --
for Broadcom 11g support! Well, I've searched the WRT54G firmware 1.30.1
package kernel-2.4.5.tgz (linked at the above URL) and this is what I found:

<begin terminal output>
$ head -267 linux/arch/mips/Makefile | tail -11
                                                                               
#
# Broadcom BCM93725 variants
#
ifdef CONFIG_BCM93725
LIBS          += arch/mips/brcm-boards/bcm93725/bcm93725.o arch/mips/brcm-boards/generic/brcm.o
SUBDIRS       += arch/mips/brcm-boards/generic arch/mips/brcm-boards/bcm93725
LOADADDR      += 0x80000000
TEXTADDR      += 0x80001000
endif

$ find linux/ /fw_cramfs -ipath "*bcm9*" -o -ipath "*brcm-*" -o -name "diag.*" -o -name "et.*" -o -name "il.*" -o -name "*writemac*" -o -name "*wl.*"
/fw_cramfs/lib/modules/2.4.5/kernel/drivers/net/diag/diag.o
/fw_cramfs/lib/modules/2.4.5/kernel/drivers/net/et/et.o
/fw_cramfs/lib/modules/2.4.5/kernel/drivers/net/mac/writemac.o
/fw_cramfs/lib/modules/2.4.5/kernel/drivers/net/wl/wl.o
<end>

The Linksys kernel source tree seems to omit code for the Broadcom drivers,
the libraries which the build links against, and the resulting modules! Is
this allowed by the GPL? It seems Linksys has omitted (at least) one crucial   
part of their kernel source....

True, Linksys deserves much credit for releasing their GPL-derived
source -- but can someone legally write a module or kernel library for a
GPL kernel and provide its recipient with neither the source nor library?

 -- Michael English

