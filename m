Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWIKGIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWIKGIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 02:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWIKGIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 02:08:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34027 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964907AbWIKGIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 02:08:06 -0400
Date: Mon, 11 Sep 2006 02:07:55 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Split multi-line printk in oops output.
Message-ID: <20060911060755.GA8271@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060911030721.GA4733@redhat.com> <200609110744.15450.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609110744.15450.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 07:44:15AM +0200, Andi Kleen wrote:
 > 
 > >  	print_modules();
 > > -	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
 > > -			"EFLAGS: %08lx   (%s %.*s) \n",
 > > -		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
 > > -		print_tainted(), regs->eflags, system_utsname.release,
 > > +	printk(KERN_EMERG "CPU:    %d\n", smp_processor_id());
 > > +	printk(KERN_EMERG "EIP:    %04x:[<%08lx>]    %s VLI\n",
 > > +		0xffff & regs->xcs, regs->eip, print_tainted());
 > > +	printk(KERN_EMERG "EFLAGS: %08lx   (%s %.*s)\n",
 > 
 > Still only using a single printk would be slightly safer

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 7e9edaf..b30fc9e 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -291,8 +291,9 @@ void show_registers(struct pt_regs *regs
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
-	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
-			"EFLAGS: %08lx   (%s %.*s) \n",
+	printk(KERN_EMERG "CPU:    %d\n"
+		KERN_EMERG "EIP:    %04x:[<%08lx>]    %s VLI\n"
+		KERN_EMERG "EFLAGS: %08lx   (%s %.*s)\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
 		print_tainted(), regs->eflags, system_utsname.release,
 		(int)strcspn(system_utsname.version, " "),


-- 
http://www.codemonkey.org.uk
