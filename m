Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269839AbRHDJWZ>; Sat, 4 Aug 2001 05:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269841AbRHDJWP>; Sat, 4 Aug 2001 05:22:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269839AbRHDJWI>; Sat, 4 Aug 2001 05:22:08 -0400
Subject: Re: Linux C2-Style Audit Capability
To: redph0enix@hotmail.com (Red Phoenix)
Date: Sat, 4 Aug 2001 10:23:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <LAW2-F31DgC81TbdkSm00013be0@hotmail.com> from "Red Phoenix" at Aug 04, 2001 07:03:52 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Sxf5-0004pT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> System calls are overridden by pointing sys_call_table[system call] to a 
> replacement function which saves off the data for auditing purposes, then 
> calls the original system call.

Ugly but that bit probably ties in with all the other folks trying to put
together a unified security hook set for 2.5

> audit events are turned on (eg: open()), the user-space audit daemon cannot 
> keep up with the kernel, and therefore my ring buffer fills. As such, we 
> lose events.
> 
>                 if(!write_io((io_class *)event))
>                 {
>                         // Couldnt write it out.
>                         // No space available in the ring buffer.
>                         signal=0;
>                         lost_events++;
>                 }

So why don't you block ? Obviously you must never block logging events
caused by the logging daemon itself but in the other cases since you are 
logging before (and maybe after) a syscall rather than logging during the
syscall where locks may be held I dont see the problem
