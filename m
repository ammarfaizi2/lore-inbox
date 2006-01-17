Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWAQTgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWAQTgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWAQTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:36:17 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50831 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932224AbWAQTgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:36:16 -0500
Date: Tue, 17 Jan 2006 20:36:04 +0100
From: Olaf Hering <olh@suse.de>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
Message-ID: <20060117193604.GA25724@suse.de>
References: <20060116233143.GB23097@flint.arm.linux.org.uk> <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 16, Kumar Gala wrote:

> > Mea Culpa - should've spotted that - that patch is actually rather
> > broken.  platform_driver_register() can't be moved from where it
> > initially was.
> 
> This seems to fix my issue on arch/powerpc and arch/ppc, please push to 
> Linus ASAP.

This fixes also my pseries, p270. Too bad, the 8250 depends on
CONFIG_ISA now which is not selectable for CONFIG_PPC_PSERIES. 
Is this patch the way to go for ppc64?

Index: linux-2.6.15/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.15.orig/arch/powerpc/Kconfig
+++ linux-2.6.15/arch/powerpc/Kconfig
@@ -712,7 +712,7 @@ menu "Bus options"

 config ISA
        bool "Support for ISA-bus hardware"
-       depends on PPC_PREP || PPC_CHRP
+       depends on PPC_PREP || PPC_CHRP || PPC_PSERIES
        select PPC_I8259
        help
          Find out whether you have ISA slots on your motherboard.  ISA is the


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
