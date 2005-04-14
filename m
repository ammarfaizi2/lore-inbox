Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVDNUge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDNUge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVDNUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:36:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37815 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261520AbVDNUgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:36:15 -0400
Date: Thu, 14 Apr 2005 22:35:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: juerg@paldo.org, len.brown@intel.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix reloading GDT on ACPI S3 wakeup (fwd)
Message-ID: <20050414203557.GE2801@elf.ucw.cz>
References: <20050414192240.GB2728@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414192240.GB2728@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch - based on
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110055503031009&w=2 -
> makes ACPI S3 wakeup work for me on a ThinkPad T40p laptop with a SMP
> kernel. Without it only UP kernels work. I've been using the patch for
> three months now without any issues.
> 
> The ACPI resume code currently uses a real-mode 16-bit lgdt instruction
> to reload the GDT.  This only restores the lower 24 bits of the GDT base
> address.  In recent SMP kernels, the GDT seems to have moved out of the
> lower 16 megs, thereby causing the ACPI resume to fail -- an invalid GDT
> was being loaded.
> 

Actually x86-64 needs this, too. Any testers?
									Pavel

--- clean/arch/x86_64/kernel/acpi/wakeup.S	2005-01-22 21:24:51.000000000 +0100
+++ linux/arch/x86_64/kernel/acpi/wakeup.S	2005-04-14 22:34:18.000000000 +0200
@@ -67,7 +67,7 @@
 	shll	$4, %eax
 	addl	$(gdta - wakeup_code), %eax
 	movl	%eax, gdt_48a +2 - wakeup_code
-	lgdt	%ds:gdt_48a - wakeup_code		# load gdt with whatever is
+	lgdtl	%ds:gdt_48a - wakeup_code	# load gdt with whatever is
 						# appropriate
 
 	movl	$1, %eax			# protected mode (PE) bit


-- 
Boycott Kodak -- for their patent abuse against Java.
