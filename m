Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbUKLAHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbUKLAHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUKLAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:06:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:9670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262415AbUKLACY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:02:24 -0500
Date: Thu, 11 Nov 2004 16:01:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
In-Reply-To: <1100215538.5876.779.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411111552030.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>  <4192A9BF.2080606@conectiva.com.br>
 <4192ADF4.1050907@conectiva.com.br>  <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
  <1100211749.5510.753.camel@d845pe>  <Pine.LNX.4.58.0411111427050.2301@ppc970.osdl.org>
 <1100215538.5876.779.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Nov 2004, Len Brown wrote:
> 
> The _gsi in platform_rename_gsi was consistent with the surrounding use
> in the ACPI case.  I decided to re-use the same funtion for the MPS case
> for simplicity, even though io_apic.c uses _irq.  If you like, I can add
> a synonym using an inline for _irq, but I thought we were moving away
> from using _irq, not towards it.

We _definitely_ prefer "irq" over something else that means the same 
thing.

If GSI means some _specific_ interrupt, and thus has additional meaning 
over "irq", then by all means, use it, but spell it out. "Global System 
Interrupt" means _nothing_ to me. What makes it "global"? What makes it 
"system"?

The _only_ thing that uses "gsi" is the MP table stuff, and that's 
apparently just from the documentation.

In other words, if it's a normal interrupt, it's "irq" or "interrupt". The 
same way a "disk" is a "disk" - it's not a DASD. 

Stupid acronyms that don't actually mean anything more than the standard 
name are nothing but stupid.

Interrupts are interrupts. We call them something else only if they are 
_specific_ interrupts (ie a "NMI" clearly has a very _specific_ meaning, 
as has "SCI", although the latter is already obscure enough that it's 
probably a good idea to spell it out a bit if it is ever used outside of a 
context where use is obvious).

		Linus
