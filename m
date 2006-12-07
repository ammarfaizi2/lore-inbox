Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937998AbWLGPyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937998AbWLGPyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938000AbWLGPyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:54:38 -0500
Received: from mail2.utc.com ([192.249.46.191]:53659 "EHLO mail2.utc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937998AbWLGPyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:54:37 -0500
Message-ID: <4578391E.40001@cybsft.com>
Date: Thu, 07 Dec 2006 09:54:06 -0600
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
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com> <20061207121344.GA19749@elte.hu>
In-Reply-To: <20061207121344.GA19749@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------060301030306070509030806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060301030306070509030806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

The attached patch is necessary to build 2.6.19-rt8 without KEXEC
enabled. Without KEXEC enabled crash.c doesn't get included. I believe
this is correct.

-- 
   kr

--------------060301030306070509030806
Content-Type: text/x-patch;
 name="nmifix1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmifix1.patch"

--- linux-2.6.19/arch/i386/kernel/nmi.c.orig	2006-12-07 09:35:22.000000000 -0600
+++ linux-2.6.19/arch/i386/kernel/nmi.c	2006-12-07 09:36:04.000000000 -0600
@@ -935,7 +935,9 @@ void nmi_show_all_regs(void)
 	for_each_online_cpu(i)
 		nmi_show_regs[i] = 1;
 
+#ifdef CONFIG_KEXEC
 	smp_send_nmi_allbutself();
+#endif
 
 	for_each_online_cpu(i) {
 		while (nmi_show_regs[i] == 1)

--------------060301030306070509030806--
