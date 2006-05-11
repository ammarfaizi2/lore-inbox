Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWEKMLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWEKMLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 08:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWEKMLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 08:11:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:5073 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751556AbWEKMLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 08:11:22 -0400
Message-ID: <44632A62.2020505@suse.de>
Date: Thu, 11 May 2006 14:13:22 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] SMP alternatives: skip with UP kernels.
References: <4461341B.7050602@keyaccess.nl> <4461B24A.7050805@suse.de> <4461D16A.3000301@keyaccess.nl>
In-Reply-To: <4461D16A.3000301@keyaccess.nl>
Content-Type: multipart/mixed;
 boundary="------------030006070904080907010209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030006070904080907010209
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

> Okay, thanks. Yes, I agree such would make sense.

Patch below.  It simply returns in case the tables are empty and nothing
is do to, thus avoids printing the confusing message.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg

--------------030006070904080907010209
Content-Type: text/plain;
 name="ifdef-smp-alts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ifdef-smp-alts"

Index: vanilla-2.6.17-rc3-mm1/arch/i386/kernel/alternative.c
===================================================================
--- vanilla-2.6.17-rc3-mm1.orig/arch/i386/kernel/alternative.c	2006-05-10 12:25:39.000000000 +0200
+++ vanilla-2.6.17-rc3-mm1/arch/i386/kernel/alternative.c	2006-05-10 15:00:10.000000000 +0200
@@ -349,6 +349,9 @@ void __init alternative_instructions(voi
 	smp_alt_once = 1;
 #endif
 
+	if (0 == (__smp_alt_end - __smp_alt_begin))
+		return; /* no tables, nothing to patch (UP kernel) */
+
 	if (smp_alt_once) {
 		if (1 == num_possible_cpus()) {
 			printk(KERN_INFO "SMP alternatives: switching to UP code\n");

--------------030006070904080907010209--
