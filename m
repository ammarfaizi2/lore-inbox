Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWEPPPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWEPPPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEPPPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:15:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:132 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932086AbWEPPPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:15:21 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 2/3] reliable stack trace support (x86-64)
Date: Tue, 16 May 2006 17:13:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <4469FC22.76E4.0078.0@novell.com>
In-Reply-To: <4469FC22.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161713.39575.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 16:21, Jan Beulich wrote:
> These are the x86_64-specific pieces to enable reliable stack traces. The
> only restriction with this is that it currently cannot unwind across the
> interrupt->normal stack boundary, as that transition is lacking proper
> annotation.

It would be nice if you could submit a patch to fix that.


>  
> +#ifdef CONFIG_STACK_UNWIND
> +  . = ALIGN(8);
> +  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
> +	__start_unwind = .;
> +  	*(.eh_frame)
> +	__end_unwind = .;
> +  }
> +#endif

Ah ok - it's there. Ignore my earlier question then.



> +#define UNW_PC(frame) (frame)->regs.rip
> +#define UNW_SP(frame) (frame)->regs.rsp

I think we alreay have instruction_pointer(). Better add a stack_pointer() 
in ptrace.h too.

-Andi
