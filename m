Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUIMIJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUIMIJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIMIJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:09:23 -0400
Received: from ns1.equation.fr ([213.56.79.161]:44003 "EHLO sol.equation.fr")
	by vger.kernel.org with ESMTP id S266349AbUIMIJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:09:16 -0400
Mime-Version: 1.0 (Apple Message framework v619)
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-Id: <0879F90A-055C-11D9-855B-000A95BDFB08@equation.fr>
Content-Type: multipart/mixed; boundary=Apple-Mail-10-791565210
Cc: toojays@toojays.net, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Kernel 2.6 PowerBook3,3 patch
From: Alain RICHARD <alain.richard@equation.fr>
Date: Mon, 13 Sep 2004 10:08:02 +0200
X-Mailer: Apple Mail (2.619)
X-Spam-Score: (0) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-10-791565210
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi,

I have the following patch to add to arch/ppc/platforms/pmac_cpufreq.c 
under kernel 2.6. it enables the PowerBook3,3 plateform to dynamically 
change the cpu speed. Without it, my Titanium 2 powerbook 550 MHz have 
always its fan at full speed and crashes in various ways. The 
PowerBook3,3 plateform are the titanium powerbooks at 550 and 667 MHz 
what were introducted at the end of 2001.

I hope this patch will be included in the standard kernel as it is the 
only blocking problem I was experiencing using a fedora-2/3 ppc 
distribution.

The patch is against the standard kernel 2.6.8.1 from kernel.org. I 
know the file has changed under the various bk kernels, but it must 
also apply (as this plateform PowerBook3,3 is not taken into account in 
them also).

Regards,


--Apple-Mail-10-791565210
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="pmac_cpufreq.patch"
Content-Disposition: attachment;
	filename=pmac_cpufreq.patch

--- arch/ppc/platforms/pmac_cpufreq.c	2004-08-14 07:37:14.000000000 +0200
+++ arch/ppc/platforms/pmac_cpufreq.c	2004-09-11 19:11:00.509192072 +0200
@@ -553,6 +553,12 @@
 		low_freq = 300000;
 		set_speed_proc = pmu_set_cpu_speed;
 	}
+	/* Else check for TiPb 550 & 667 */
+	else if (machine_is_compatible("PowerBook3,3")) {
+		hi_freq = cur_freq;
+		low_freq = 300000;
+		set_speed_proc = pmu_set_cpu_speed;
+	}
 	/* Else check for 750FX */
 	else if (PVR_VER(mfspr(PVR)) == 0x7000) {
 		if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)

--Apple-Mail-10-791565210
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed



-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ing=E9nierie r=E9seau et Linux=

--Apple-Mail-10-791565210--

