Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUA2KBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUA2KBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:01:37 -0500
Received: from genesis.westend.com ([212.117.67.2]:25334 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP id S264534AbUA2KBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:01:31 -0500
Subject: Where do the "Machine Check Exceptions" come from?
From: Kai Militzer <km@westend.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Jan 2004 11:01:34 +0100
Message-Id: <1075370497.775.89.camel@bart>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We have a Server runing here, with a very strange behavior.

It all started, that the machine crashed in two-day-intervalls with the
following message in log:

Jan  6 22:39:01 CPU 0: Machine Check Exception: 0000000000000004
Jan  6 22:39:01 Bank 4: b200000000040151
Jan  6 22:39:01 Kernel panic: CPU context corrupt

So we took the machine out of productivity and started to search for the
problem. We first thought it must be some Hardware error, so we did a
memtest86 for a long time (over 10 passes) without any errors there. We
then booted from a knoppix CD and did a burnMMX and burnP4. Nothing
happend, all ran smooth.

So we thought maybe it is some other system component, so we removed
everything not needed (network card, scsi-controller) and changed the
video-card. We then bootet again from knoppix and did a lot of kernel
compiles over night (on the harddisk, not on a ramdisk) --> all went
smooth.

We then bootet the original system (without all unneeded hardware),
started kernel compiling and it crashed after a day. This was strange.
So we looked in out changelog and then realized, that the crashing
started, when we changed the running kernel from a vanilla 2.4.19 to a
vanilla 2.4.23.

We thought it could be something in the new kernel. So we took a new
2.4.24 with the config from 2.4.23 (make oldconfig) and tested -->
system crashed after compiling kernels for a day.

So there must be something else. Next step was to take the config from
the 2.4.19 kernel and do a "make oldconfig" with the 2.4.24. The system
is now running for two days without a crash. So it must be something
that has changed between the two configs.

So I took the config from the faulty 2.4.23 kernel, and did a "make
oldconfig" with the running config from 2.4.19 on the 2.4.23 kernel.

I will attach what a "diff faulty_config running_config" showed at the
end of the mail.

Any ideas what option new option made the kernel crash? I will try the
three options directly compiled into the kernel (not as a module) the
next few days and will give an, if I can find out what causes this
behavior.

Best regards

Kai Militzer

++++output of diff+++++

153c153
< CONFIG_BLK_STATS=y
---
> # CONFIG_BLK_STATS is not set
194c194
< CONFIG_IP_NF_TFTP=m
---
> # CONFIG_IP_NF_TFTP is not set
200c200
< CONFIG_IP_NF_MATCH_PKTTYPE=m
---
> # CONFIG_IP_NF_MATCH_PKTTYPE is not set
204,206c204,206
< CONFIG_IP_NF_MATCH_RECENT=m
< CONFIG_IP_NF_MATCH_ECN=m
< CONFIG_IP_NF_MATCH_DSCP=m
---
> # CONFIG_IP_NF_MATCH_RECENT is not set
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_DSCP is not set
211c211
< CONFIG_IP_NF_MATCH_HELPER=m
---
> # CONFIG_IP_NF_MATCH_HELPER is not set
213c213
< CONFIG_IP_NF_MATCH_CONNTRACK=m
---
> # CONFIG_IP_NF_MATCH_CONNTRACK is not set
227d226
< CONFIG_IP_NF_NAT_TFTP=m
230,231c229,230
< CONFIG_IP_NF_TARGET_ECN=m
< CONFIG_IP_NF_TARGET_DSCP=m
---
> # CONFIG_IP_NF_TARGET_ECN is not set
> # CONFIG_IP_NF_TARGET_DSCP is not set
238c237
< CONFIG_IP_NF_ARP_MANGLE=m
---
> # CONFIG_IP_NF_ARP_MANGLE is not set
329c328
< CONFIG_BLK_DEV_GENERIC=y
---
> # CONFIG_BLK_DEV_GENERIC is not set
557c556
< CONFIG_B44=m
---
> # CONFIG_B44 is not set
565c564
< CONFIG_E100=m
---
> # CONFIG_E100 is not set
593,594c592
< CONFIG_E1000=m
< # CONFIG_E1000_NAPI is not set
---
> # CONFIG_E1000 is not set
599c597
< CONFIG_R8169=m
---
> # CONFIG_R8169 is not set
712c710
< CONFIG_HW_RANDOM=m
---
> # CONFIG_HW_RANDOM is not set
910c908
< CONFIG_DEBUG_STACKOVERFLOW=y
---
> # CONFIG_DEBUG_STACKOVERFLOW is not set
927c925
< CONFIG_CRC32=m
---
> # CONFIG_CRC32 is not set
929c927
< CONFIG_ZLIB_DEFLATE=m
---
> # CONFIG_ZLIB_DEFLATE is not set

+++++end output of diff++++

-- 
Kai Militzer                 WESTEND GmbH  |  Internet-Business-Provider
Technik                      CISCO Systems Partner - Authorized Reseller
                             Lütticher Straße 10      Tel 0241/701333-11
km@westend.com               D-52064 Aachen              Fax 0241/911879


