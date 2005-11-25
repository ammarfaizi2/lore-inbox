Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbVKYEcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbVKYEcX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 23:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVKYEcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 23:32:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60300 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161098AbVKYEcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 23:32:23 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH 4/7]: changes notifier head of diechains and add notify_chain_unregister 
In-reply-to: Your message of "Thu, 24 Nov 2005 00:57:28 BST."
             <20051123235728.GB31722@brahms.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Nov 2005 15:31:51 +1100
Message-ID: <7306.1132893111@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005 00:57:28 +0100, 
Andi Kleen <ak@suse.de> wrote:
>> Index: l2615-rc1-notifiers/include/asm-x86_64/kdebug.h
>> ===================================================================
>> --- l2615-rc1-notifiers.orig/include/asm-x86_64/kdebug.h
>> +++ l2615-rc1-notifiers/include/asm-x86_64/kdebug.h
>> @@ -5,21 +5,20 @@
>>  
>>  struct pt_regs;
>>  
>> -struct die_args { 
>> +struct die_args {
>
>etc. lots more occurrences.
>
>Can you please repost the patch without arbitary white space changes
>everywhere?

Not everywhere, only include/asm-x86_64/kdebug.h has trailing white
space and there was not enough white space changes to justify splitting
its change into two patches.  But since you insist ...

White space changes first.

Index: linux/include/asm-x86_64/kdebug.h
===================================================================
--- linux.orig/include/asm-x86_64/kdebug.h	2005-11-25 15:29:33.303590496 +1100
+++ linux/include/asm-x86_64/kdebug.h	2005-11-25 15:29:51.278657263 +1100
@@ -5,13 +5,13 @@
 
 struct pt_regs;
 
-struct die_args { 
+struct die_args {
 	struct pt_regs *regs;
 	const char *str;
-	long err; 
+	long err;
 	int trapnr;
 	int signr;
-}; 
+};
 
 /* Note - you should never unregister because that can race with NMIs.
    If you really want to do it first unregister - then synchronize_sched - then free.
@@ -19,7 +19,7 @@ struct die_args { 
 int register_die_notifier(struct notifier_block *nb);
 extern struct notifier_block *die_chain;
 /* Grossly misnamed. */
-enum die_val { 
+enum die_val {
 	DIE_OOPS = 1,
 	DIE_INT3,
 	DIE_DEBUG,
@@ -33,13 +33,13 @@ enum die_val { 
 	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
-}; 
-	
+};
+
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
-{ 
-	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig }; 
-	return notifier_call_chain(&die_chain, val, &args); 
-} 
+{
+	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
+	return notifier_call_chain(&die_chain, val, &args);
+}
 
 extern int printk_address(unsigned long address);
 extern void die(const char *,struct pt_regs *,long);

This is what is really changed in include/asm-x86_64/kdebug.h, the same
basic change as in i386.

Index: linux/include/asm-x86_64/kdebug.h
===================================================================
--- linux.orig/include/asm-x86_64/kdebug.h	2005-10-28 10:02:08.000000000 +1000
+++ linux/include/asm-x86_64/kdebug.h	2005-11-25 15:20:16.553007734 +1100
@@ -13,11 +13,10 @@ struct die_args {
 	int signr;
 };
 
-/* Note - you should never unregister because that can race with NMIs.
-   If you really want to do it first unregister - then synchronize_sched - then free.
-  */
-int register_die_notifier(struct notifier_block *nb);
-extern struct notifier_block *die_chain;
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
+extern struct notifier_head die_chain;
+
 /* Grossly misnamed. */
 enum die_val {
 	DIE_OOPS = 1,

