Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbTC0UD2>; Thu, 27 Mar 2003 15:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbTC0UD2>; Thu, 27 Mar 2003 15:03:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39851 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261366AbTC0UD1>;
	Thu, 27 Mar 2003 15:03:27 -0500
Date: Thu, 27 Mar 2003 20:14:39 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PROPOSAL] MODULE_VERSION macro
Message-ID: <20030327201439.GA1586@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A common question one needs to ask is "What version of that driver are
you using?".  It's not always immediately obvious where to find that
information, even if you have the source in front of you.  Some examples..

drivers/net/tulip/tulip_core.c:18:#define DRV_VERSION      "1.1.13"
drivers/net/e100/e100_main.c:140:char e100_driver_version[]="2.1.29-k4";
drivers/scsi/sym53c8xx.c:88:#define SCSI_NCR_DRIVER_NAME "sym53c8xx-1.7.3c-20010512"
drivers/scsi/aic7xxx_old.c:256:#define AIC7XXX_C_VERSION  "5.2.6"
drivers/serial/8250.c:2159:MODULE_DESCRIPTION("Generic 8250/16x50 serial driver $Revision: 1.90 $");

And I'm sure there are worse examples.  My proposal is simple:

#define MODULE_VERSION(version) \
	static const char __module_version[] \
		__attribute__((section(".init.version"), unused)) = version

and add the .init.version section to vmlinux.lds in the `freed after
init' section.

The tools can catch up to use this kind of thing later; we need to
standardise the source code to use this first.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
