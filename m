Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVIIGur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVIIGur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVIIGur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:50:47 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:11721
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751412AbVIIGuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:50:46 -0400
Message-Id: <43214D2D02000078000247B5@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 08:51:57 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 CFI annotations
References: <432070850200007800024465@emea1-mh.id2.novell.com>  <20050908154645.GN3966@smtp.west.cox.net>  <43207BA30200007800024502@emea1-mh.id2.novell.com> <20050908161334.GP3966@smtp.west.cox.net>
In-Reply-To: <20050908161334.GP3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Tom Rini <trini@kernel.crashing.org> 08.09.05 18:13:34 >>>
>On Thu, Sep 08, 2005 at 05:57:55PM +0200, Jan Beulich wrote:
>
>> >> +	CFI_ADJUST_CFA_OFFSET 4;\
>> >> +	/*CFI_REL_OFFSET es, 0;*/\
>> >>  	pushl %ds; \
>> >> +	CFI_ADJUST_CFA_OFFSET 4;\
>> >> +	/*CFI_REL_OFFSET ds, 0;*/\
>> >
>> >Adding new commented out code never wins new friends. :)
>> 
>> I know. But how would you indicate functionality belonging there
but
>> just not provided by the translating utilities. If that's really a
>> problem, then I would need to teach the respective macros to ignore
>> certain operands.
>
>Not provided by binutils or ?

Not provided for even by the spec; if it was just binutils missing them
I'd have added this already.

>> >> diff -Npru 2.6.13/include/asm-i386/dwarf2.h
>> >[snip]
>> >> +#ifdef CONFIG_UNWIND_INFO
>> >[snip]
>> >> +#else
>> >[snip]
>> >> +#define CFI_STARTPROC	ignore
>> >
>> >Why not just empty defines?
>> 
>> Because they aren't function-like macros, but can have arguments
>> (assembler syntax style); these arguments would then remain
standalone
>> on the line, and the assembly would fail.
>
>Take a look at
>http://marc.theaimsgroup.com/?l=linux-kernel&m=112267822014301&w=2 
>
>I think we have slightly different approaches to the same problem, but
I
>found doing the cfi macros as cpp macros instead of gas macros was
>cleaner & easier in the end.

I don't like this better, I actually started from the x86-64 approach.
Specifically, if working around the above mentioned commented-out-code
problem should be necessary, then using assembler macros is likely to
provide for an easier solution.

Jan
