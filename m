Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTFHFHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 01:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFHFHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 01:07:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39883 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264499AbTFHFHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 01:07:18 -0400
Subject: Re: [RFC] machine_reboot and friends
From: Dave Hansen <haveblue@us.ibm.com>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030606215159.GB10721@h55p111.delphi.afb.lu.se>
References: <20030606215159.GB10721@h55p111.delphi.afb.lu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1055049528.18387.7.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jun 2003 22:18:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 14:51, Anders Gustafsson wrote:
> What if machine_restart/machine_halt/machine_power_off were made
> functionpointers instead? And let the architectures assign to them
> instead of defining the functions? Some architectures are already
> doing this.

We don't usually abstract out architecture features with function
pointers.  The more standard way is with definitions in
architecture-specific files.  Also, the 

               if(machine_restart)
                       machine_restart(NULL);

stuff is fairly messy, and it would probably be preferable to do
something like this instead:

void machine_restart(void)
{
               if(arch_machine_restart)
                       arch_machine_restart(NULL);
}

Then, let the architectures define arch_machine_restart(), and keep tons
of duplicate if()s from being scattered around.

> A bit orthogonal: Different architechtures do different things if the action
> fails (or is unimplemented), some panic, some return, some do "for(;;);",
> isn't it about time someone defined the semantics for these functions?

Not really.  It's architecture specific :)  Some machines simply don't
have a recourse when something that low-level fails.  Is there a case
when something happens that you don't expect?  The three architecures
that I compile for work happily, and as I expect.

-- 
Dave Hansen
haveblue@us.ibm.com

