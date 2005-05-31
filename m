Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVEaObD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVEaObD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEaObC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:31:02 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:18659 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261723AbVEaOa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:30:56 -0400
Date: Tue, 31 May 2005 08:34:28 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
cc: jayush luniya <jayu_11@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: HOTPLUG CPU Support for SMT
In-Reply-To: <20050531051730.GA5845@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0505310832380.12903@montezuma.fsmlabs.com>
References: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com>
 <Pine.LNX.4.61.0505301050141.12903@montezuma.fsmlabs.com>
 <20050531051730.GA5845@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, Srivatsa Vaddagiri wrote:

> On Mon, May 30, 2005 at 04:50:27PM +0000, Zwane Mwaikambo wrote:
> > Yes, older 2.6-mm kernel (2.6.10-mm) trees have the "toy" i386 hotplug 
> > cpu implementation which does what you want.
> 
> AFAIK in the i386 "toy" implementation, when a CPU is offlined, it stops
> taking interrupts and stops running tasks, but it _still_ executes a while
> loop in the context of its idle task (with IRQs disabled). The loop
> is exited when we have to bring online the CPU again. What this means is 
> I don't think by offlining the CPU, we are removing any activity associated
> with the corresponding h/w thread. 
> 
> Maybe the toy implementation could be modified to take care of it? Something
> like lowering the priority of the h/w thread so that it consumes minimal 
> CPU resources to execute its while loop.

A cpu_relax() there would help greatly and essentially "drops" the 
priority of the processor executing it (since 'pause' is a hint that that 
logical processor would like to yield execution resources), although there 
would still be traffic due to accessing get_cpu_var, which should be minimal as 
it'll be at most 1 non shared cacheline so you could account for it in the 
statement of errors. I used to have a personal implementation for one of 
the systems i use which does a hlt in that loop and i wake up the 
procsesor via IPI. So perhaps some kernel hacking might be required 
(albeit minimal) ;)

	Zwane

