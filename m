Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCDF37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUCDF37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:29:59 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:8648 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261468AbUCDF35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:29:57 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb support in vanilla 2.6.2
Date: Thu, 4 Mar 2004 10:59:43 +0530
User-Agent: KMail/1.5
Cc: ak@suse.de, george@mvista.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200403041036.58827.amitkale@emsyssoft.com> <20040303211850.05d44b4a.akpm@osdl.org>
In-Reply-To: <20040303211850.05d44b4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403041059.43439.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2004 10:48 am, Andrew Morton wrote:
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > Flashing keyboard lights is easy on x86 and x86_64 platforms.
>
> Please, no keyboards.  Some people want to be able to use kgdboe
> to find out why machine number 324 down the corridor just died.
>
> How about just doing
>
>
> char *why_i_crashed;
>
>
> {
> 	...
> 	if (expr1)
> 		why_i_crashed = "hit a BUG";
> 	else if (expr2)
> 		why_i_crashed = "divide by zero";
> 	else ...
> }
>
> then provide a gdb macro which prints out the string at *why_i_crashed?

If we can afford to do this (in terms of actions that can be done with the 
machine being unstable) we can certainly print a console message through gdb.

A stub is free to send console messages to gdb at any time. We can send a 
"'O'hex(Page fault at 0x1234)" packet to gdb regardless of whether 
CONFIG_KGDB_CONSOLE is configured in. This way kgdb will send this packet to 
gdb and then immediately report a segfault/trap. To a user it'll appear as a 
message printed from gdb "Page fault at 0x1234" followed by gdb showing a 
SIGSEGV etc. The gdb console message should print information other than a 
signal number.

-Amit

