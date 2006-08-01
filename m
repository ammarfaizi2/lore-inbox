Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWHAF6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWHAF6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWHAF6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:58:03 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:53434 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751577AbWHAF6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:58:01 -0400
Date: Tue, 1 Aug 2006 01:52:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: ptrace bugs and related problems
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: "Roland Dreier" <roland@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Andi Kleen" <ak@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linus Torvalds" <torvalds@osdl.org>
Message-ID: <200608010154_MC3-1-C6A9-2892@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <787b0d920607311730s5a951a5cv38eea7db03c759c8@mail.gmail.com>

On Mon, 31 Jul 2006 20:30:07 -0400, Albert Cahalan wrote:
> 
> > > There is also no check
> > > for failure, as when the popf or iret takes an alignment exception
> > > or hits an unmapped page.
> >
> > Can that happen?
> 
> You're at a popf that can not complete.
> You single-step.
> The kernel sets TF.
> The kernel notes the popf.
> The kernel assumes that TF will be determined by the popf.
> The kernel tries to run the popf.
> The popf faults, leaving TF unmodified.
> The kernel fails to clear TF.

That can be fixed, but it won't be easy.

> > > There is the pushf problem. Single-stepping this simple code
> > > does not work:   pushf ; popf
> >
> > The debugger needs to mask TF in the pushed flags.  Read the comment
> > in is_at_popf().
> 
> I think the term is "known bug".

Well at least it's known. :)

> > > The is_at_popf function on x86-64 fails to account for instruction
> > > set differences. Many prefixes are only valid in 32-bit mode, and
> > > many others are only valid in 64-bit mode.
> 
> There is a problem with instruction length though.
> The buffer is 16 bytes long, but should be only 15.

OK.

> The 0xf0 (lock) prefix is not valid for popf or iret.

I think it is OK on really old processors (maybe only 386?)  If we fix
the above problem with faulting instructions then the fault this would
cause on newer CPUs should not be a problem.
-- 
Chuck

