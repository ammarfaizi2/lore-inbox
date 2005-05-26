Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVEZBHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVEZBHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 21:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVEZBHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 21:07:16 -0400
Received: from fmr23.intel.com ([143.183.121.15]:5576 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261640AbVEZBHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 21:07:05 -0400
Date: Wed, 25 May 2005 18:06:52 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: "Alan D. Brunelle" <Alan.Brunelle@hp.com>,
       "Lynch, Rusty" <rusty.lynch@intel.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>, akpm@osdl.org,
       "Luck,     Tony" <tony.luck@intel.com>,
       "Seth, Rohit" <rohit.seth@intel.com>, prasanna@in.ibm.com,
       ananth@in.ibm.com, systemtap@sources.redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] Kprobes support for IA64
Message-ID: <20050525180652.B10277@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <429484F2.8080401@hp.com> <12169.1117068542@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12169.1117068542@ocs3.ocs.com.au>; from kaos@sgi.com on Thu, May 26, 2005 at 10:49:02AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 10:49:02AM +1000, Keith Owens wrote:
> On Wed, 25 May 2005 10:00:18 -0400,
> "Alan D. Brunelle" <Alan.Brunelle@hp.com> wrote:
> >Isn't the real issue here that if kprobes attempts to put in a 'break
> >0x80200' into a B-slot that it instead becomes a 'break.b 0' -- as the
> >break.b does not accept an immediate value?
> 
> break.b is a B9 type instruction, which does take an imm21 value.  It
> is the hardware that does not store imm21 in CR.IIM when break.b is
> issued.
> 
> >Kprobes does have the two cases covered in traps.c (case 0 - when a
> >B-slot break is used, and case 0x80200 for a non-B-slot break). But this
> >doesn't seem very clean. (If it was decided that one should not overload
> >the break 0 case, and instead use a uniquely defined break number, then
> >it fails on a B-slot probe. If it is OK to overload the break 0 case,
> >why have another break number at all?)
> 
> Mainly for documentation when looking at the assembler code.  break 0
> is used for BUG(), coding a different value in the break instruction
> for the debugger helps the person debugging the debugger :(.  I have no
> problem with coding two cases in ia64_bad_break() in order to work
> around the hardware "feature".

I agree with Keith, when a person taking a instructin dump, a 
different value will help uniquely identify that this
is a kprobe break instruction which is a replaced instrucion
of the original instruction. So we will leave with what we have
now, i.e handle the same with two cases.


> 
> Also consider the case where your debugger allows users to code a
> deliberate entry to the debugger, like KDB_ENTER().  That case always
> requires a separate break imm21 value, because the break point is not
> known to the debugger until the code is executed.
> 
