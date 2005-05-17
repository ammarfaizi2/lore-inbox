Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVEQLSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVEQLSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEQLSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:18:34 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:51981 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261367AbVEQKlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:41:46 -0400
Message-ID: <4289CA67.60405@sw.ru>
Date: Tue, 17 May 2005 14:41:43 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mbligh@mbligh.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
References: <42822B5F.8040901@sw.ru>	<768860000.1116282855@flay>	<42899797.2090702@sw.ru> <20050517001542.40e6c6b7.akpm@osdl.org>
In-Reply-To: <20050517001542.40e6c6b7.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050900040206030800000406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050900040206030800000406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Kirill Korotaev <dev@sw.ru> wrote:
> 
>>BTW, why NMI watchdog is disabled by default?
> 
> 
> There was a significantly large string of reports of dying PCs in the
> 2.4.early timeframe.  These machines would mysteriously lock up after
> considerable periods of time and the problem was cured by disabling the NMI
> watchdog.  Nobody was ever able to solve it, so we changed it to default to
> off.
Hmm, it is strange, since we used 2.4 kernels with watchdog for years 
(starting from 2.4.1)...

> So much has changed in there that we might have fixed it by accident, and I
> do recall a couple of fundamental and subtle NMI bugs being fixed.  So
> yeah, it might be worth enabling it by default again.  Care to send a patch
> which does that?
I attached the patch which turns NMI watchdog on by default on i386.

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>

Kirill

--------------050900040206030800000406
Content-Type: text/plain;
 name="diff-ms-nmiwd-20050517"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-nmiwd-20050517"

--- linux-2.6.12-rc4/arch/i386/kernel/nmi.c.nmiwd	2005-05-07 09:20:31.000000000 +0400
+++ linux-2.6.12-rc4/arch/i386/kernel/nmi.c	2005-05-17 13:47:38.000000000 +0400
@@ -34,7 +34,7 @@
 
 #include "mach_traps.h"
 
-unsigned int nmi_watchdog = NMI_NONE;
+unsigned int nmi_watchdog = NMI_IO_APIC;
 extern int unknown_nmi_panic;
 static unsigned int nmi_hz = HZ;
 static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */

--------------050900040206030800000406--

