Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKJILH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKJILH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVKJILH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:11:07 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:33713
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750723AbVKJILG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:11:06 -0500
Message-Id: <43730EE8.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 09:12:08 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "George Anzinger" <george@mvista.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/39] NLKD/i386 - time adjustment
References: <43720DAE.76F0.0078.0@novell.com>  <43720E2E.76F0.0078.0@novell.com>  <43720E72.76F0.0078.0@novell.com>  <43720EAF.76F0.0078.0@novell.com>  <43720F5E.76F0.0078.0@novell.com>  <43720F95.76F0.0078.0@novell.com>  <43720FBA.76F0.0078.0@novell.com>  <43720FF6.76F0.0078.0@novell.com>  <43721024.76F0.0078.0@novell.com>  <4372105B.76F0.0078.0@novell.com>  <43721081.76F0.0078.0@novell.com> <43724991.10607@mvista.com>
In-Reply-To: <43724991.10607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> George Anzinger <george@mvista.com> 09.11.05 20:10:09 >>>
>Jan Beulich wrote:
>> Since i386 time handling is not overflow-safe, these are the
>> adjustments needed for allowing debuggers to update time after
>> having halted the system for perhaps extended periods of time.
>> 
>> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
>> 
>> (actual patch attached)
>
>The patch includes code that seems to imply that gcc can not do mpy of
(long long) variables.  It 
>does just fine with these.  It also adds (long long) types just fine. 
The only problem it has is 
>with div, for which we have do_div().

gcc can do long long multiplies fine, but only with a long long result.
The code presented, however, needs (at least) 96 bits of the result,
which expressing in C would be far more complicated than doing it with a
couple of assembly statements.

>I really do not see the relavence of the run time library patches
given the above.  The adjust code 
>does not seem to use them.  Also, gcc (with the lib code) does all of
this stuff.  The only need for 
>it would, possibly, be to debug the library code and even then, I
suspect you really want to do that 
>in user land and then bring the result into the kernel.

Which run time library patches are you referring to? NLKD's? If so,
these routines must not be used by code outside of the debugger (and the
opposite is true, too: debugger code must not use common code routines
where ever possible).

Further, it is my understanding that it is for a (unknown to me) reason
that the linux kernel doesn't have the full set of libgcc support
routines. Since the debugger in various places relies on being able to
do 64-bit math on 32-bit systems, I had to add these in a way so that
they'd be hidden from the rest of the kernel (and also so that they'd
satisfy the isolation rules outlined above).

Jan
