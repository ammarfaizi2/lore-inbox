Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVDEJJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVDEJJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDEJJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:09:27 -0400
Received: from black.click.cz ([62.141.0.10]:49367 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261634AbVDEJJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:09:08 -0400
From: Michal Rokos <michal@rokos.info>
To: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [IrDA] Oops with NULL deref in irda_device_set_media_busy
Date: Tue, 5 Apr 2005 11:02:26 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051102.27533.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've problems with IrDA - when debug is off, I'm getting oops for obvious 
reason...
(I don't have a log, this is just rewrite from screen:
EIP: irda_device_set_media_busy+0x15/0x40 [irda]
ali_ircc_sir_receive+0x4a/0x70
ali_ircc_sir_interrupt+0x66/0x70
ali_ircc_interrupt+0x5e/0x80
.....
)
When I turn debug on, I get just
Assertion failed! net/irda/irda_device.c:irda_device_set_media_busy:128 
self != NULL

The obvious reason is that I don't have irlap module in that inits 
dev->atalk_ptr, so I'm getting assertion exception in irda_device.c:489.

A few info that could be handy:

$ uname -a # It's yesterday bk snapshot
Linux csas 2.6.12-rc1-mr #14 Mon Apr 4 13:42:14 CEST 2005 i686 GNU/Linux

$ lsmod | grep ir
ircomm_tty             39176  3
ircomm                 22404  1 ircomm_tty
ali_ircc               26032  0
irda                  192316  3 ircomm_tty,ircomm,ali_ircc
crc_ccitt               2176  2 ppp_async,irda

$ grep IR .config
CONFIG_IRDA=m
# CONFIG_IRLAN is not set
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y
# SIR device drivers
# CONFIG_IRTTY_SIR is not set
# Old SIR device drivers
# CONFIG_IRPORT_SIR is not set
# FIR device drivers
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
CONFIG_ALI_FIR=m
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
# CONFIG_USB_SERIAL_IR is not set

 Michal
