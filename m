Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTAXOsw>; Fri, 24 Jan 2003 09:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTAXOsw>; Fri, 24 Jan 2003 09:48:52 -0500
Received: from mail.spylog.com ([194.67.35.220]:62166 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id <S267658AbTAXOsv>;
	Fri, 24 Jan 2003 09:48:51 -0500
Date: Fri, 24 Jan 2003 17:57:55 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Michael Fu <michael.fu@linux.co.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] e100 driver fails to initialize the hardware after kernel bootup through kexec
Message-ID: <20030124145754.GA1116@an.local>
Mail-Followup-To: Andrey Nekrasov <andy@spylog.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Michael Fu <michael.fu@linux.co.intel.com>,
	linux-kernel@vger.kernel.org
References: <1042450072.1744.75.camel@aminoacin.sh.intel.com> <1043390954.892.10.camel@aminoacin.sh.intel.com> <m18yxaeje3.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <m18yxaeje3.fsf@frodo.biederman.org>
Organization: SpyLOG ltd.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric W. Biederman,

Once you wrote about "Re: [BUG] e100 driver fails to initialize the hardware after kernel bootup through kexec":
> Michael Fu <michael.fu@linux.co.intel.com> writes:
> 
> > After kernel was bootup through kexec command, the NIC failed to
> > initialize. The 2.5.52 kernel was patched with kexec and kexec-hwfix
> > patch.
> 
> Interesting...  The patch goes cleanly onto newer kernels so feel
> free to play with them.  You are running a single cpu system
> so the kexec-hwfix patch should not make a difference at this point.
> 
> Your interrupt routing is via ACPI interesting...
> 
> > 
> > the following was is the dmesg output:
> 
> [snip]
> > Intel(R) PRO/100 Network Driver - version 2.1.24-k2
> > Copyright (c) 2002 Intel Corporation
> > 
> > 
> > 
> > 
> > 
> > 
> > PCI: Enabling device 02:09.0 (0000 -> 0003)
> > PCI: Setting latency timer of device 02:09.0 to 64
> > e100: selftest timeout
> > e100: Failed to initialize, instance #0

use NIC EEPro100+ on INTEL STL2 motherboard, with "eepro100" driver - all work ok.

or "e100" driver and with patch:


--- drivers/net/e100/e100.h-    Wed Dec  4 15:16:08 2002 
+++ drivers/net/e100/e100.h     Wed Dec  4 15:16:20 2002 
@@ -100,7 +100,7 @@
 
 #define E100_MAX_NIC 16
 
-#define E100_MAX_SCB_WAIT      100     /* Max udelays in wait_scb */ 
+#define E100_MAX_SCB_WAIT      5000    /* Max udelays in wait_scb */ 
 #define E100_MAX_CU_IDLE_WAIT  50      /* Max udelays in wait_cus_idle */
 
 /* HWI feature related constant */

all work ok.

