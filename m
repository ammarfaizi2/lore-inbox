Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293462AbSCASLx>; Fri, 1 Mar 2002 13:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293463AbSCASLn>; Fri, 1 Mar 2002 13:11:43 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:45329
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S293462AbSCASLa>; Fri, 1 Mar 2002 13:11:30 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200203011741.g21Hf4b30628@www.hockin.org>
Subject: Re: [Patch] ALi M7101 watchdog
To: steve@navaho.co.uk (Steve Hill)
Date: Fri, 1 Mar 2002 09:41:03 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0203011427520.9334-200000@sorbus.navaho> from "Steve Hill" at Mar 01, 2002 02:43:07 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It takes notice of the CONFIG_WDT_NOWAYOUT option and will kick the 
> watchdog timer when the system goes down for a reboot so it pulls the 
> reset (as far as I can tell this is the only way to reboot Cobalt 
> machines?)
> 
> I have done preliminary testing on a Cobalt Raq 4 and it seems good - 
> please CC any comments / questions to me.

The WDT in the 7101 is almost USELESS from user-space.  It has a MAXIMUM 1
second timeout, and is tied straight to RESET.  If you miss ONE feeding,
you reboot.  In our kernel we have a 1/4 second timer to feed the watchdog,
and we still have to hack into some stuff to ensure that it gets met.
There are places where (drivers mostly) think it is OK to spin for multiple
seconds with interrupts off.  If you put the responsibility for feeding the
WDT into user-space, I'll bet dollars to dimes you'll start experiencing
random reboots.  If I was allowed to, I would have used the WDT for reboot
ONLY, and had it off otherwise - it is WAAAAY finicky.

Tim

