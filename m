Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVEYS7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVEYS7C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVEYS6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:58:14 -0400
Received: from mail.tyan.com ([66.122.195.4]:9736 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262383AbVEYSxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:53:43 -0400
Message-ID: <3174569B9743D511922F00A0C943142309F815CF@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor
	e du al way
Date: Wed, 25 May 2005 11:54:10 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try rc5 in amd dual core dual opteron MB with acpi disabled? 

You need to make AMD64 work at least.

YH

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Wednesday, May 25, 2005 11:51 AM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron 
> MB/with dual core du al way
> 
> On Wed, May 25, 2005 at 11:45:47AM -0700, YhLu wrote:
> > Andi,
> > 
> > following patch solve the problem.
> > 
> > YH
> > 
> >  --- smpboot.o.c 2005-05-25 12:36:20.793913936 -0700
> > +++ smpboot.c   2005-05-25 12:36:31.569275832 -0700
> > @@ -764,7 +764,7 @@
> >                 int i;
> >                 if (smp_num_siblings > 1) {
> >                         for_each_online_cpu (i) {
> > -                               if (cpu_core_id[cpu] == 
> cpu_core_id[i]) {
> > +                               if (cpu_to_node[cpu] == 
> > + cpu_to_node[i]) {
> 
> This is not correct though, it doesnt make any sense on non 
> NUMA systems like Intel ones.
> 
> -Andi
> 
> >                                         siblings++;
> >                                         cpu_set(i, 
> cpu_sibling_map[cpu]);
> >                                 }
> > 
> > > -----Original Message-----
> > > From: YhLu
> > > Sent: Wednesday, May 25, 2005 11:10 AM
> > > To: 'Andi Kleen'
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: RE: RT patch acceptance
> > > 
> > > Andi,
> > > 
> > > the 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB.
> > > 
> > > the Core id seems to be right now.
> > > 
> > > the core 0 of node 1 can not be started and hang there.
> > > 
> > > YH
> > > 
> > > CPU 0(2) -> Node 0 -> Core 0
> > > enabled ExtINT on CPU#0
> > > ENABLING IO-APIC IRQs
> > > Using IO-APIC 4
> > > ...changing IO-APIC physical APIC ID to 4 ... ok.
> > > Using IO-APIC 5
> > > ...changing IO-APIC physical APIC ID to 5 ... ok.
> > > Using IO-APIC 6
> > > ...changing IO-APIC physical APIC ID to 6 ... ok.
> > > Using IO-APIC 7
> > > ...changing IO-APIC physical APIC ID to 7 ... ok.
> > > Synchronizing Arb IDs.
> > > testing the IO APIC.......................
> > > 
> > > 
> > > 
> > > 
> > > .................................... done.
> > > Using local APIC timer interrupts.
> > > Detected 12.564 MHz APIC timer.
> > > Booting processor 1/1 rip 6000 rsp ffff81007ff07f58 Initializing 
> > > CPU#1 masked ExtINT on CPU#1
> > > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > > CPU: L2 Cache: 1024K (64 bytes/line) CPU 1(2) -> Node 0 
> -> Core 1  
> > > stepping 00 CPU 1: Syncing TSC to CPU 0.
> > > Booting processor 2/2 rip 6000 rsp ffff81013ff11f58 Initializing 
> > > CPU#2 masked ExtINT on CPU#2
> 
