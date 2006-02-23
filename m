Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWBWEWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWBWEWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBWEWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:22:12 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:5217 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750785AbWBWEWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:22:11 -0500
In-Reply-To: <200602222129.31700.mbuesch@freenet.de>
References: <200602222129.31700.mbuesch@freenet.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A04DCF5-C5CF-46E2-A133-A7743BD83B17@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Buesch <mbuesch@freenet.de>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC: Sleeping function called from invalid context at emulate_instruction()
Date: Wed, 22 Feb 2006 22:22:17 -0600
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 22, 2006, at 2:29 PM, Michael Buesch wrote:

> Hi,
>
> On a powerPC 32bit, I got the following debugging assertion failure:
>
> [  733.209827] Debug: sleeping function called from invalid context  
> at arch/powerpc/kernel/traps.c:697
> [  733.210682] in_atomic():0, irqs_disabled():1
> [  733.211347] Call Trace:
> [  733.211969] [D6023EB0] [C0007F84] show_stack+0x58/0x174  
> (unreliable)
> [  733.212765] [D6023EE0] [C0022C34] __might_sleep+0xbc/0xd0
> [  733.213523] [D6023EF0] [C000D158] program_check_exception 
> +0x1d8/0x4fc
> [  733.214309] [D6023F40] [C000E744] ret_from_except_full+0x0/0x4c
> [  733.215076] --- Exception: 700 at 0x102a7100
> [  733.215785]     LR = 0xdb9ef04
>
> It is caused by the line
> if (get_user(instword, (u32 __user *)(regs->nip)))
> in arch/powerpc/kernel/traps.c:emulate_instruction()
>
> I am not sure, if this is an indication for a bug, or just false  
> alarm.
> In case of false alarm, the debugging message should be made quiet
> somehow, though.

Paul,

Last time this was brought up we left it wondering why you had made  
program_check_exception() run with interrupts disabled.  Any further  
ideas on that one?

- kumar
