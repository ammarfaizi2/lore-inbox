Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752009AbWCNHy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWCNHy6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWCNHy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:54:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:4257 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1752009AbWCNHy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:54:56 -0500
X-ASG-Debug-ID: 1142322891-6754-12-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 13 Mar 2006 23:59:09 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zachary Amsden <zach@vmware.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: VMI Interface Proposal Documentation for I386, Part 5
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
In-Reply-To: <4415CE76.9030006@vmware.com>
Message-ID: <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com>
References: <4415CE76.9030006@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9728
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Zachary Amsden wrote:

>   PROCESSOR STATE CALLS
> 
>    This set of calls controls the online status of the processor.  It
>    include interrupt control, reboot, halt, and shutdown functionality.
>    Future expansions may include deep sleep and hotplug CPU capabilities.
> 
>    VMI_DisableInterrupts
> 
>       VMICALL void VMI_DisableInterrupts(void);
> 
>       Disable maskable interrupts on the processor.
> 
>       Inputs:      None
>       Outputs:     None
>       Clobbers:    Flags only
>       Segments:    As this is both performance critical and likely to
>          be called from low level interrupt code, this call does not
>          require flat DS/ES segments, but uses the stack segment for
>          data access.  Therefore only CS/SS must be well defined.
> 
>    VMI_EnableInterrupts
> 
>       VMICALL void VMI_EnableInterrupts(void);
> 
>       Enable maskable interrupts on the processor.  Note that the
>       current implementation always will deliver any pending interrupts
>       on a call which enables interrupts, for compatibility with kernel
>       code which expects this behavior.  Whether this should be required
>       is open for debate.

Mind if i push this debate slightly forward? If we were to move the 
dispatch of pending interrupts elsewhere, where would that be? In 
particular, for a device which won't issue any more interrupts until it's 
previous interrupt is serviced. Perhaps injection at arbitrary points 
during runtime when interrupts are enabled?

	Zwane

