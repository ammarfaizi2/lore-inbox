Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWHaTKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWHaTKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 15:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWHaTKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 15:10:38 -0400
Received: from gw.goop.org ([64.81.55.164]:1704 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932308AbWHaTKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 15:10:37 -0400
Message-ID: <44F73429.9060101@goop.org>
Date: Thu, 31 Aug 2006 12:10:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@XenSource.com>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/8] Implement smp_processor_id() with the PDA.
References: <20060830235201.106319215@goop.org>	 <20060831000515.338336117@goop.org> <1157027758.12949.327.camel@localhost.localdomain>
In-Reply-To: <1157027758.12949.327.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> smp_processor_id() is defined for !SMP in include/linux/smp.h, I don't
> know if it would be appropriate to add early_smp_processor_id() there
> since it seems i386 specific. asm/smp.h isn't included by linux/smp.h
> when !SMP but you could add an explicit include to common.c I suppose.
>   
The simple solution is to just define a !SMP version of 
early_smp_processor_id().  It's i386 specific, but that's the only arch 
that uses it:

diff -r 8a89489b3734 include/asm-i386/smp.h
--- a/include/asm-i386/smp.h    Thu Aug 31 12:06:44 2006 -0700
+++ b/include/asm-i386/smp.h    Thu Aug 31 12:07:48 2006 -0700
@@ -98,6 +98,7 @@ extern unsigned int num_processors;
 #else /* CONFIG_SMP */
 
 #define safe_smp_processor_id()                0
+#define early_smp_processor_id()       0
 #define cpu_physical_id(cpu)           boot_cpu_physical_apicid
 
 #define NO_PROC_ID             0xFF            /* No processor magic marker */

    J
