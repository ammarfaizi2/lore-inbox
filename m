Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRF3FVy>; Sat, 30 Jun 2001 01:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264847AbRF3FVo>; Sat, 30 Jun 2001 01:21:44 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:43512 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264846AbRF3FVg>; Sat, 30 Jun 2001 01:21:36 -0400
Message-ID: <3B3D61D3.CEDACC4D@uow.edu.au>
Date: Sat, 30 Jun 2001 15:21:23 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dylan Griffiths <Dylan_G@bigfoot.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <3B3D4A96.A81A13AD@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dylan Griffiths wrote:
> 
>         Hi.  While doing some file tranfers to our new server (a Compaq Proliant
> 8way XEON 500 with 4gb ram and an EEPro100 NIC), the box socked solid (no
> oops, no response via network, no response via console).  The other hardware
> in the system was a Compaq Smart Array 9SMART2 driver).  It's running
> Slackware 7.1.  The other system was a dual P3 450 running Redhat 7.1 (Linux
> velocity.kuro5hin.org 2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686
> unknown) w/ 3c59x NIC.  The Redhat machine experienced no problems.
>         In Uni processor mode, the system is totally stable.  But only using 1/8th
> of its power :-/  We had to roll back to 2.2.19 with a bigmem patch, but
> we'd like to have a stable 2.4 kernel to use (since it's so much better SMP
> wise, throughput wise, etc).

Some things to try:

1: Include `magic sysrq' support in the kernel and use ALT-SYSRQ-T and S
   when it has locked up.   If you get some traces then please feed them
   into `ksymoops -m System.map' and report back.

2: If the above doesn't work, add `nmi_watchdog=1' to the kernel boot
   options.  That may catch the lockup.

3: Replace the NIC with another eepro100.  If the problem goes away then
   chuck the old one.

4: Replace the NIC with one of a different type (ie: swap with the other
   machine). If that fixes it we look at the ethernet driver.  Otherwise
   we look at, umm, the rest of the kernel.

-
