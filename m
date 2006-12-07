Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938007AbWLGTks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938007AbWLGTks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938009AbWLGTks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:40:48 -0500
Received: from mail1.utc.com ([192.249.46.190]:43682 "EHLO mail1.utc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938006AbWLGTkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:40:47 -0500
Message-ID: <45786E32.3010201@cybsft.com>
Date: Thu, 07 Dec 2006 13:40:34 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com> <20061207121344.GA19749@elte.hu> <4578391E.40001@cybsft.com> <20061207165751.GA2720@elte.hu>
In-Reply-To: <20061207165751.GA2720@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090709080209010705000209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090709080209010705000209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> Ingo Molnar wrote:
>>
>> The attached patch is necessary to build 2.6.19-rt8 without KEXEC 
>> enabled. Without KEXEC enabled crash.c doesn't get included. I believe 
>> this is correct.
> 
> ah, indeed. I went for a slightly different approach - see the patch 
> below. Sending an NMI to all CPUs is not something that is tied to 
> KEXEC, it belongs into nmi.c.
> 
> 	Ingo

Much better I think. It still requires the patch below, which includes
mach_ipi.h, to build here.


-- 
   kr

--------------090709080209010705000209
Content-Type: text/x-patch;
 name="nmifix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmifix2.patch"

--- linux-2.6.19/arch/i386/kernel/nmi.c.orig	2006-12-07 13:03:12.000000000 -0600
+++ linux-2.6.19/arch/i386/kernel/nmi.c	2006-12-07 13:03:21.000000000 -0600
@@ -30,6 +30,7 @@
 #include <asm/intel_arch_perfmon.h>
 
 #include "mach_traps.h"
+#include <mach_ipi.h>
 
 int unknown_nmi_panic;
 int nmi_watchdog_enabled;

--------------090709080209010705000209--
