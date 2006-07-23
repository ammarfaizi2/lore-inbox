Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWGWVtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWGWVtw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWGWVtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:49:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:58066 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751337AbWGWVtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:49:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=sw0pqWUYptmLQJ5Ax8nwO8mLR/UEpPUL7ExfaqZKVmlS/nXjncIyjFnpo8mrv61YIphA32ww2hD4M/l7hvn+YiS00dQWGKklxfR+r1VWSLTdjET72IlEu+SNVhDowaaQduPu0+B84X0ON+1lMs/KAthk8f+B+q5bhfY3eh6hY+g=
Date: Sun, 23 Jul 2006 23:48:34 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent usage of uninitialized variable in transmeta cpu driver
Message-ID: <20060723214834.GA1484@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch fixes a gcc-`uninitialized' warning in
arch/i386/kernel/cpu/transmeta.c.

Signed-off-by: Johannes Weiner <hnazfoo@gmail.com>

---

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="transmeta-suppress-warning.patch"

diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
index 7214c9b..5b71071 100644
--- a/arch/i386/kernel/cpu/transmeta.c
+++ b/arch/i386/kernel/cpu/transmeta.c
@@ -17,9 +17,9 @@ static void __init init_transmeta(struct
 
 	/* Print CMS and CPU revision */
 	max = cpuid_eax(0x80860000);
-	cpu_rev = 0;
+	cpu_rev = cpu_freq = 0;
 	if ( max >= 0x80860001 ) {
-		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags); 
+		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags);
 		if (cpu_rev != 0x02000000) {
 			printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u, %u MHz\n",
 				(cpu_rev >> 24) & 0xff,
@@ -72,7 +72,7 @@ static void __init init_transmeta(struct
 	wrmsr(0x80860004, ~0, uk);
 	c->x86_capability[0] = cpuid_edx(0x00000001);
 	wrmsr(0x80860004, cap_mask, uk);
-	
+
 	/* If we can run i686 user-space code, call us an i686 */
 #define USER686 (X86_FEATURE_TSC|X86_FEATURE_CX8|X86_FEATURE_CMOV)
         if ( c->x86 == 5 && (c->x86_capability[0] & USER686) == USER686 )

--k1lZvvs/B4yU6o8G--
