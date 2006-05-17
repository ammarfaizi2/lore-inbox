Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWEQQVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWEQQVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWEQQVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:21:16 -0400
Received: from xenotime.net ([66.160.160.81]:44987 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750810AbWEQQVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:21:16 -0400
Date: Wed, 17 May 2006 09:23:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, benh@kernel.crashing.org,
       rmk@arm.linux.org.uk, akpm@osdl.org, hch@infradead.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch 15/50] genirq: doc: add design documentation
Message-Id: <20060517092342.f6076d27.rdunlap@xenotime.net>
In-Reply-To: <20060517001623.GP12877@elte.hu>
References: <20060517001623.GP12877@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 02:16:23 +0200 Ingo Molnar wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add docbook file - includes API documentation.

Thanks. :)

> Index: linux-genirq.q/Documentation/DocBook/genericirq.tmpl
> ===================================================================
> --- /dev/null
> +++ linux-genirq.q/Documentation/DocBook/genericirq.tmpl
> @@ -0,0 +1,453 @@

> +  <chapter id="rationale">
> +    <title>Rationale</title>
> +	<para>
> +	The original implementation of interrupt handling in Linux is using
> +	the __do_IRQ() super-handler, which is able to deal with every
> +	type of interrupt logic.
> +	</para>
> +	<para>
> +	Originally, Russell King identified different types of handlers to
> +	build a quite universal set for the ARM interrupt handler
> +	implementation in Linux 2.5/2.6. He distiguished between:
distinguished

> +	<para>
> +	The original general IRQ implementation used hw_interrupt_type
> +	structures and their ->ack(), ->end() [etc.] callbcks to
> +	differentiate the flow control in the super-handler. This leads to
> +	a mix of flow logic and lowlevel hardware logic, and it also leads
> +	to unnecessary code duplication: for example in i386, there is a
> +	ioapic_level_irq and a ioapic_edge_irq irq-type which share many
> +	of the lowlevel details but have different flow handling.
> +	</para>
> +	<para>
> +	A more natural abstraction is the clean seperation of the
separation (multiple locations)
(or as my wife says, "there's 'a rat' in separate.")

> +	'irq flow' and the 'chip details'.
> +	</para>
> +	<para>
> +	Analysing a couple of architecture's IRQ subsystem implementations
> +	reveals that most of them can use a generic set of 'irq flow'
> +	methods and only need to add the chip level specific code.
> +	The seperation is also valuable for (sub)architectures
> +	which need specific quirks in the irq flow itself but not in the
> +	chip-details - and thus provides a more transparent IRQ subsystem
> +	design.
> +	</para>
> +	<para>
> +	Each interrupt descriptor has assigned its own highlevel flow
s/has/is/

> +	handler, which is normally one of the generic
> +	implementations. (This highlevel flow handler implementation also
> +	makes it simple to provide demultiplexing handlers which can be
> +	found in embedded platforms on various architectures.)
> +	</para>
> +	<para>
> +	The seperation makes the generic interrupt handling layer more
> +	flexible and extensible. For example, an (sub)architecture can
> +	use a generic irq-flow implementation for 'level type' interrupts
> +	and add a (sub)architecture specific 'edge type' implementation.
> +	</para>
> +	<para>
> +	To make the transition to the new model easier and prevent the
> +	breakage of existing implementations the __do_IRQ() super-handler
add comma after "implementations"

> +	is still available. This leads to a kind of duality for the time
> +	being. Over time the new model should be used in more and more
> +	architectures, as it enables smaller and cleaner IRQ subsystems.
> +	</para>
> +  </chapter>
> +  <chapter id="bugs">
> +    <title>Known Bugs And Assumptions</title>
> +    <para>
> +	None (knock on wood).
> +    </para>
> +  </chapter>
> +

> +	<sect2>
> +	<title>Default flow implementations</title>
> +	    <sect3>
> +	 	<title>Helper functions</title>
> +		<para>
> +		The helper functions call the chip primitives and
> +		are used by the default flow implementations.
> +		Following helper functions are implemented (simplified excerpt):
The following ... (multiple locations)


> +	    <sect3>
> +	 	<title>Default Edge IRQ flow handler</title>
> +		<para>
> +		handle_edge_irq provides a generic implementation
> +		for edge interrupts.
edge-triggered interrupts. (IMO)

> +  <chapter id="doirq">
> +     <title>__do_IRQ entry point</title>
> +     <para>
> + 	The original implementation __do_IRQ() is an alternative entry
> +	point for all types of interrupts.
> +     </para>
> +     <para>
> +	This handler turned out to be not suitable for all
> +	interrupt hardware and was therefor reimplemented with split
therefore

> +	functionality for egde/level/simple/percpu interrupts. This is not
> +	only a functional optimization. It also shortenes code pathes for
shortens code paths

> +	interrupts.

HTH.
---
~Randy
