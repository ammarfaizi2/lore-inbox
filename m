Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWGCUya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWGCUya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWGCUya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:54:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932115AbWGCUy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:54:29 -0400
Date: Mon, 3 Jul 2006 13:54:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060703135419.7c58f318.akpm@osdl.org>
In-Reply-To: <200607032136.55259.s0348365@sms.ed.ac.uk>
References: <20060703030355.420c7155.akpm@osdl.org>
	<200607032056.28556.s0348365@sms.ed.ac.uk>
	<20060703131752.9eaf6c9b.akpm@osdl.org>
	<200607032136.55259.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 21:36:55 +0100
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> On Monday 03 July 2006 21:17, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 20:56:28 +0100
> >
> > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > On Monday 03 July 2006 20:39, Andrew Morton wrote:
> > > > On Mon, 3 Jul 2006 20:27:21 +0100
> > > >
> > > > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > > On Monday 03 July 2006 11:03, Andrew Morton wrote:
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> > > > > >7/2. 6.17 -mm6/
> > > > >
> > > > > Doesn't boot reliably as an x86-64 kernel on my X2 system, 3/4 times
> > > > > it oopses horribly. Is there some way to supress an oops flood so I
> > > > > can get a decent picture of it with vga=extended? Right now I get two
> > > > > useless oopses after the first (probably useful) one.
> > > >
> > > > Try adding `pause_on_oops=100000' to the kernel boot command line.
> > >
> > > (Trimmed Nathan)
> > >
> > > Helped somewhat, but I'm still missing a bit at the top.
> > >
> > > http://devzero.co.uk/~alistair/oops-20060703/
> >
> > That is irritating.  This should get us more info:
> 
> Indeed, thanks.
> 
> Try the same URL again, I've uploaded 3,4,5 from a couple of reboots. I still 
> think I'm missing something at the top, but 3 is the earliest I could snap.
> 

Getting better.

It would kinda help if pause_on_oops() was actually implemented on x86_64..

--- a/arch/x86_64/kernel/traps.c~x86_64-wire-up-oops_enter-oops_exit
+++ a/arch/x86_64/kernel/traps.c
@@ -551,11 +551,14 @@ void __kprobes __die(const char * str, s
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
-	unsigned long flags = oops_begin();
+	unsigned long flags;
 
+	oops_enter();
+	flags = oops_begin();
 	handle_BUG(regs);
 	__die(str, regs, err);
 	oops_end(flags);
+	oops_exit();
 	do_exit(SIGSEGV); 
 }
 
_

