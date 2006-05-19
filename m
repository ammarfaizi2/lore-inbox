Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWESDt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWESDt1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWESDt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:49:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50213 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932211AbWESDt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:49:26 -0400
Date: Thu, 18 May 2006 23:49:25 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]   Compile warning because of an uninitialized variable
To: linux-kernel@vger.kernel.org
Message-id: <446D4045.9090304@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_yqrfr5NbbRmFe7sfF+gkoQ)"
User-Agent: Thunderbird 1.5 (X11/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_yqrfr5NbbRmFe7sfF+gkoQ)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    gcc generates a warning because of an uninitialized variable in arch/i386/kernel/cpu/transmeta.c.
The variable "cpu_freq" is initialized by a call to cpuid(). The following patch fixes the warning.

Regards,

Stephane.

--Boundary_(ID_yqrfr5NbbRmFe7sfF+gkoQ)
Content-type: text/x-patch; CHARSET=US-ASCII; name=transmetta.c.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=transmetta.c.patch

--- linux-2.6.16.16/arch/i386/kernel/cpu/transmeta.c	2006-05-04 20:03:45.000000000 -0400
+++ linux-2.6.16.16-fixed/arch/i386/kernel/cpu/transmeta.c	2006-05-18 15:19:52.000000000 -0400
@@ -18,6 +18,7 @@
 	/* Print CMS and CPU revision */
 	max = cpuid_eax(0x80860000);
 	cpu_rev = 0;
+	cpu_freq = 0;
 	if ( max >= 0x80860001 ) {
 		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags); 
 		if (cpu_rev != 0x02000000) {

--Boundary_(ID_yqrfr5NbbRmFe7sfF+gkoQ)--
