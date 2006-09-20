Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWITAcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWITAcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 20:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWITAcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 20:32:18 -0400
Received: from opersys.com ([64.40.108.71]:59659 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750754AbWITAcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 20:32:17 -0400
Message-ID: <451090E7.603@opersys.com>
Date: Tue, 19 Sep 2006 20:52:55 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> 	 <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> 	 <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> 	 <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> 	 <45102641.7000101@google.com>  <20060919175405.GC26339@Krystal> <1158710925.32598.120.camel@localhost.localdomain>
In-Reply-To: <1158710925.32598.120.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> Ar Maw, 2006-09-19 am 13:54 -0400, ysgrifennodd Mathieu Desnoyers:
>> Very good idea.. However, overwriting the second instruction with a jump could
>> be dangerous on preemptible and SMP kernels, because we never know if a thread
>> has an IP in any of its contexts that would return exactly at the middle of the
>> jump. 
> 
> No: on x86 it is the *same* case for all of these even writing an int3.
> One byte or a megabyte,
> 
> You MUST ensure that every CPU executes a serializing instruction before
> it hits code that was modified by another processor. Otherwise you get
> CPU errata and the CPU produces results which vendors like to describe
> as "undefined".

I was aware of that this errata existed, but never actually knew the
actual specifics of it. Are these two separate problems or just
one?
a) the errata & a possible thread having an IP leading back within (not
   at the start of) the range to be replaced.
b) the errata & replacing single instruction with single instruction of
   same size.

In a), there's almost an intractable problem of making sure no IP leads
back within the range to be replaced. In b) we still have to take care
of the errata part, but no worry about the stalled thread with invalid
IP.

> Thus you have to serialize, and if you are serializing it really doesn't
> matter if you write a byte, a paragraph or a page.

I was vaguely aware of the issue on x86. Do you know if this applies the
same on other achitectures?

Also, this is SMP-only, right? (Not that single UP matters for desktop
anymore, but just checking.)

Any pointers to the errata?

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
