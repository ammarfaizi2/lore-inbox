Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWH2OhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWH2OhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWH2OhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:37:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47527 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964998AbWH2OhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:37:02 -0400
From: Andi Kleen <ak@suse.de>
To: petkov@math.uni-muenster.de
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Tue, 29 Aug 2006 16:36:56 +0200
User-Agent: KMail/1.9.3
Cc: Jan Beulich <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org> <200608291316.22327.ak@suse.de> <20060829130050.GA12773@gollum.tnic>
In-Reply-To: <20060829130050.GA12773@gollum.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291636.56673.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 15:00, Borislav Petkov wrote:
> On Tue, Aug 29, 2006 at 01:16:22PM +0200, Andi Kleen wrote:
> > 
> > > 
> > > Without a hex dump of stack contents there's very little I can do.
> > 
> > Borislav, if you can reproduce the crash please boot with kstack=2048 and send output
> > of that.
> Yeah, 
>     that's a no-go, same output:

Can you please try it with this debug patch?

-Andi

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -106,7 +106,7 @@ static inline void preempt_conditional_c
 	preempt_enable_no_resched();
 }
 
-static int kstack_depth_to_print = 12;
+static int kstack_depth_to_print = 2048;
 #ifdef CONFIG_STACK_UNWIND
 static int call_trace = 1;
 #else
@@ -418,7 +418,7 @@ void show_stack(struct task_struct *tsk,
 void dump_stack(void)
 {
 	unsigned long dummy;
-	show_trace(NULL, NULL, &dummy);
+	_show_stack(NULL, NULL, &dummy);
 }
 
 EXPORT_SYMBOL(dump_stack);
