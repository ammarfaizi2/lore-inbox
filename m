Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSKGQbb>; Thu, 7 Nov 2002 11:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSKGQbb>; Thu, 7 Nov 2002 11:31:31 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:28169
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261427AbSKGQb3>; Thu, 7 Nov 2002 11:31:29 -0500
Date: Thu, 7 Nov 2002 11:38:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Corey Minyard <cminyard@mvista.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: Re: NMI handling rework
In-Reply-To: <3DCA99F4.4090703@mvista.com>
Message-ID: <Pine.LNX.4.44.0211071134190.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Corey Minyard wrote:

> NMIs cannot be masked, they are by definition non-maskable :-).  You can 
> get an NMI while executing an NMI.

"After an NMI interrupt is recognized by the P6 family, Pentium, Intel486, 
Intel386, and Intel 286 processors, the NMI interrupt is masked until the 
first IRET instruction is executed, unlike the 8086 processor."

- 18.22.2 NMI Interrupts, Intel IA32 System Developer's Manual vol3

> An NMI-based timer?  I can see the use if you REALLY need accurate 
> intervals, but you can't do much in an NMI, no spinlocks, even.

You don't have to worry about protection in the handler, just make sure 
external references (non NMI) mask that handler. Alternatively you can do 
a spin_trylock if you really need to and consider it a lost NMI if you 
can't acquire.

	Zwane
-- 
function.linuxpower.ca

