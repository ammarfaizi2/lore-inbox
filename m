Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTEGSXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbTEGSXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:23:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56453 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264152AbTEGSXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:23:37 -0400
Date: Wed, 07 May 2003 09:20:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Jonathan Lundell <linux@lundell-bros.com>
cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <15160000.1052324417@[10.10.2.4]>
In-Reply-To: <20030507175531.GF19324@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <20030507175531.GF19324@wohnheim.fh-wedel.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does 2.5 use a separate interrupt stack? (Excuse my ignorance; I 
>> haven't been paying attention.) Total stack-page usage in the 2.4 
>> model, at any rate, is the sum of the task struct, the usage of any 
>> task-level thread (system calls, pretty much), any softirq (including 
>> the network protocol & routing handlers, and any netfilter modules), 
>> and some number of possibly-nested hard interrupts.
> 
> Depends on the architecture. s390 does, ppc didn't as of 2.4.2, the
> rest I'm not sure about. But this is another requirement for stack
> reduction to 4k for most platforms, if not all.

There are patches to make i386 do this (and use 4K stacks as a config option) 
from Dave Hansen and Ben LaHaise in 2.5-mjb tree. 
 
>> One thing that would help (aside from separate interrupt stacks) 
>> would be a guard page below the stack. That wouldn't require any 
>> physical memory to be reserved, and would provide positive indication 
>> of stack overflow without significant runtime overhead.
> 
> Yes, that should work. It needs some additional code in the page fault
> handler to detect this case, but that shouldn't slow the system down
> too much.

There's stack overflow detection in there as well.

M.

