Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVI0Qsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVI0Qsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVI0Qsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:48:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26846 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965006AbVI0Qsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:48:42 -0400
Date: Tue, 27 Sep 2005 18:48:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, Christopher Friesen <cfriesen@nortel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, george@mvista.com,
       johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127682122.15115.97.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509271839140.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home>  <1127342485.24044.600.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
  <Pine.LNX.4.61.0509230151080.3743@scrub.home>  <1127458197.24044.726.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509240443440.3728@scrub.home>  <20050924051643.GB29052@elte.hu>
  <Pine.LNX.4.61.0509241212170.3728@scrub.home>  <1127570212.15115.77.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509250052390.3728@scrub.home> <1127682122.15115.97.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Sep 2005, Thomas Gleixner wrote:

> On Sun, 2005-09-25 at 01:45 +0200, Roman Zippel wrote:
> 
> > The multiply is not necessarly cheap, if the arch has no 32x32->64 
> > instruction, gcc will generate a call to __muldi3().
> 
> Can you please point out which architectures do not have a 32x32->64
> instruction ?

I have no complete overview. I know that Motorola actually removed that 
instruction in the M68060 (it causes an emulation trap) and it's still not 
back in newer ColdFire cpus. For arm it's an optional instruction in 
earlier versions (v3). For ppc it's splitted into two instructions.

For the rest you might want to check <asm/div64.h>, if div64 has to be 
emulated, there are good chances this instruction has to be emulated as 
well (especially in smaller embedded archs).

bye, Roman
