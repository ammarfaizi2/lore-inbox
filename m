Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWEPRFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWEPRFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWEPRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:05:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44689 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932147AbWEPRFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:05:17 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 2/3] reliable stack trace support (x86-64)
Date: Tue, 16 May 2006 19:05:11 +0200
User-Agent: KMail/1.9.1
Cc: "Jan Beulich" <jbeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4469FC22.76E4.0078.0@novell.com> <200605161713.39575.ak@suse.de> <446A14B7.76E4.0078.0@novell.com>
In-Reply-To: <446A14B7.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161905.11907.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 18:06, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 16.05.06 17:13 >>>
> On Tuesday 16 May 2006 16:21, Jan Beulich wrote:
> >> These are the x86_64-specific pieces to enable reliable stack traces. The
> >> only restriction with this is that it currently cannot unwind across the
> >> interrupt->normal stack boundary, as that transition is lacking proper
> >> annotation.
> >
> >It would be nice if you could submit a patch to fix that.
> 
> But I don't know how to fix it. See my other mail 
which mail?


> - I have no experience with expressions, nor have I ever seen them in 
> use.

I remember Jim Houston used a hack of just loading the old stack into a register
and defining that as a base register in CFI. I guess i would be willing 
to trade a few moves for that (should be pretty much free on a OOO CPU anyways) 
You think that trick would work?
 
> >> +#define UNW_PC(frame) (frame)->regs.rip
> >> +#define UNW_SP(frame) (frame)->regs.rsp
> >
> >I think we alreay have instruction_pointer(). Better add a stack_pointer() 
> >in ptrace.h too.
> 
> I could do that, but the macros will have to remain, as they don't access pt_regs directly, so I guess it'd be
> pointless to change it.

UNW_PC() is instruction_pointer(&frame->regs), isn't it?

-Andi
