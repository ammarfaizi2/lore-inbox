Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVFITpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVFITpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVFITpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 15:45:21 -0400
Received: from dvhart.com ([64.146.134.43]:59048 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262454AbVFITpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 15:45:12 -0400
Date: Thu, 09 Jun 2005 12:45:08 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.12?
Message-ID: <1084620000.1118346308@flay>
In-Reply-To: <563780000.1118292280@[10.10.2.4]>
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org> <394120000.1117895039@[10.10.2.4]> <20050604151120.46b51901.akpm@osdl.org> <418760000.1117983740@[10.10.2.4]> <971250000.1118168167@flay> <20050607122422.612759e4.akpm@osdl.org> <20050608125637.GL1683@muc.de> <549770000.1118260074@[10.10.2.4]> <1046820000.1118271896@flay> <563780000.1118292280@[10.10.2.4]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now what's REALLY, REALLY wierd is that this fixes my hang problem
> whilst trying to run kernbench:
> 
> http://mbligh.org/abat/no_hang
> 
> which is just reverting:
> 
> x86_64-use-a-common-function-to-find-code-segment-bases-fix.patch
> 
> But the patch is tiny, and it makes NO sense at all for this to fix
> anything. All it does is:


Strangely, -git3 works, which has the boot fix applied, but not the
hang fix bit. Something odd is afoot.
 
> diff -purN -X /home/mbligh/.diff.exclude 2.6.12-rc2-mm2/include/asm-x86_64/ptrace.h 2.6.12-rc2-mm2-no_hang/include/asm-x86_64/ptrace.h
> --- 2.6.12-rc2-mm2/include/asm-x86_64/ptrace.h	2005-04-08 23:41:41.000000000 -0700
> +++ 2.6.12-rc2-mm2-no_hang/include/asm-x86_64/ptrace.h	2005-06-08 16:25:01.000000000 -0700
> @@ -86,8 +86,6 @@ struct pt_regs {
>  extern unsigned long profile_pc(struct pt_regs *regs);
>  void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
>  
> -struct task_struct;
> -
>  extern unsigned long
>  convert_rip_to_linear(struct task_struct *child, struct pt_regs *regs);
> 
> 
> How the hell can that possibly fix it? Boggle. But it does. I checked.
> I ran a whole damned sequence of patches from your tree against the box,
> then extracted the one where the failover started and retested it with
> just that and the no_hole one. There's even a little green box to 
> prove it about 4 down on the left here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> 
> My brain is now a small piece of silly-putty smushed against the far
> wall of my study. Anything you can do to help me scrape up the remains
> would be splendid. I can only speculate it's some wierd side-effect,
> because I have no other explaination at all.
> 
> Humpf.
> 
> M.


