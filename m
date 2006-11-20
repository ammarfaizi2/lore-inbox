Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934112AbWKTMRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934112AbWKTMRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934113AbWKTMRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:17:12 -0500
Received: from c2bthomr09.btconnect.com ([194.73.73.225]:38990 "EHLO
	c2bthomr09.btconnect.com") by vger.kernel.org with ESMTP
	id S934112AbWKTMRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:17:11 -0500
Message-Id: <200611201214.kAKCErcU005240@imap.elan.private>
From: Tony Olech <tony.olech@elandigitalsystems.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux kernel development <linux-kernel@vger.kernel.org>
Cc: PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>
Cc: David Hinds <dahinds@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@suse.cz>
Cc: Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: [PATCH] PCMCIA identification strings for cards manufactured by Elan
Date: Mon, 20 Nov 2006 11:17:15 +0000
Elan-checked-message-originator: tony.olech@elandigitalsystems.com == tony-olech
Elan-message-recipient: linux@dominikbrodowski.net
Elan-message-recipient: linux-pcmcia@lists.infradead.org
Elan-message-recipient: perex@suse.cz
Elan-message-recipient: dahinds@users.sourceforge.net
Elan-message-recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch against linux kernel 2.6.18 to add PCMCIA identification strings
From: Tony Olech <tony.olech@elandigitalsystems.com>

In older versions of the linux kernel it was sufficient for the
16-bit PCMCIA card manufacturer to distribute or make available
a text configuration file along with the physical cards. Such a
file with an extension of ".conf" and placed in the /etc/pcmcia
very easily enabled new hardware without rebuilding the kernel,
however with the new scheme of things, having found no userland
solution to the problem of new 16bit pcmcia card identification
this patch enumerates Elan Digital Systems strings.

In addition, for the ID strings to result in the correct module
being loaded, the too wide matching criterion of the PDaudioCF
card needs to have the MANF_ID/CARD_ID numbers replaced by the
more specific PROD_ID1 and PROD_ID2 strings. It is unfortunate
that otherwise the pdaudiocf module is loaded whenever an ELAN
pcmcia card is inserted, resulting in various random lockups

*** linux-2.6.18/sound/pcmcia/pdaudiocf/pdaudiocf.c.orig	2006-11-20 10:24:23.000000000 +0000
--- linux-2.6.18/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-11-20 10:33:46.000000000 +0000
***************
*** 298,306 ****
  /*
   * Module entry points
   */
  static struct pcmcia_device_id snd_pdacf_ids[] = {
! 	PCMCIA_DEVICE_MANF_CARD(0x015d, 0x4c45),
  	PCMCIA_DEVICE_NULL
  };
  MODULE_DEVICE_TABLE(pcmcia, snd_pdacf_ids);
  
--- 298,307 ----
  /*
   * Module entry points
   */
  static struct pcmcia_device_id snd_pdacf_ids[] = {
! 	/* this is too general PCMCIA_DEVICE_MANF_CARD(0x015d, 0x4c45), */
! 	PCMCIA_DEVICE_PROD_ID12("Core Sound","PDAudio-CF",0x396d19d2,0x71717b49),
  	PCMCIA_DEVICE_NULL
  };
  MODULE_DEVICE_TABLE(pcmcia, snd_pdacf_ids);
  
*** linux-2.6.18/drivers/serial/serial_cs.c.orig	2006-11-17 10:59:10.000000000 +0000
--- linux-2.6.18/drivers/serial/serial_cs.c	2006-11-17 10:59:54.000000000 +0000
***************
*** 786,793 ****
--- 786,817 ----
  	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4", 0x96913a85, 0xcec8f102, "COMpad4.cis"),
  	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
  	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "RS-COM-2P.cis"),
  	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "GLOBETROTTER.cis"),
+ 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100  1.00.",0x19ca78af,0xf964f42b),
+ 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100",0x19ca78af,0x71d98e83),
+ 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232  1.00.",0x19ca78af,0x69fb7490),
+ 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232",0x19ca78af,0xb6bc0235),
+ 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232",0x63f2e0bd,0xb9e175d3),
+ 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232-5",0x63f2e0bd,0xfce33442),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232",0x3beb8cf2,0x171e7190),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232-5",0x3beb8cf2,0x20da4262),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF428",0x3beb8cf2,0xea5dd57d),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF500",0x3beb8cf2,0xd77255fa),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: IC232",0x3beb8cf2,0x6a709903),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: SL232",0x3beb8cf2,0x18430676),
+ 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: XL232",0x3beb8cf2,0x6f933767),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
  	/* too generic */
  	/* PCMCIA_MFC_DEVICE_MANF_CARD(0, 0x0160, 0x0002), */
  	/* PCMCIA_MFC_DEVICE_MANF_CARD(1, 0x0160, 0x0002), */
  	PCMCIA_DEVICE_FUNC_ID(2),
*** linux-2.6.18/drivers/parport/parport_cs.c.orig	2006-11-17 10:57:55.000000000 +0000
--- linux-2.6.18/drivers/parport/parport_cs.c	2006-11-17 10:58:52.000000000 +0000
***************
*** 262,269 ****
--- 262,270 ----
  
  
  static struct pcmcia_device_id parport_ids[] = {
  	PCMCIA_DEVICE_FUNC_ID(3),
+ 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
  	PCMCIA_DEVICE_MANF_CARD(0x0137, 0x0003),
  	PCMCIA_DEVICE_NULL
  };
  MODULE_DEVICE_TABLE(pcmcia, parport_ids);

