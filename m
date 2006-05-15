Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWEOOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWEOOTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWEOOTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:19:12 -0400
Received: from mailhost.tue.nl ([131.155.2.19]:61174 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S964926AbWEOOTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:19:10 -0400
Message-ID: <44688DDC.3020605@etpmod.phys.tue.nl>
Date: Mon, 15 May 2006 16:19:08 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Tomasz Malesinski <tmal@mimuw.edu.pl>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Segfault on the i386 enter instruction
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <p734pzv73oj.fsf@bragg.suse.de> <20060512153139.GA4852@duch.mimuw.edu.pl> <446867C4.3070108@etpmod.phys.tue.nl> <Pine.LNX.4.61.0605150933060.22830@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605150933060.22830@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 15 May 2006, Bart Hartgers wrote:
> 
>> Tomasz Malesinski wrote:
>>> On Fri, May 12, 2006 at 03:50:20PM +0200, Andi Kleen wrote:
>>>> Handling it like you expect would require to disassemble
>>>> the function in the page fault handler and it's probably not
>>>> worth doing that for this weird case.
>>> Does it mean that the ENTER instruction should not be used to create
>>> stack frames in Linux programs?
>>>
>> Basically, yes. Here is a link to a relevant discussion in the 2.2.7 era:
>>
>> http://groups.google.co.nz/groups?selm=7i86ni%24b7n%241%40palladium.transmeta.com
>>
>> And perhaps x86-64 is handled different because of the red zone (some
>> memory below the stack-pointer that can be accessed legally)?
>>
>> Groeten,
>> Bart
> 
> The enter instruction works perfectly fine. The processors were
> designed to use both enter and leave. There are no prohibitions
> against their use. It's just that if you play games with assembly
> so you create a stack-pointer wrap situation, you can get a
> bounds error.

No. The assembly is fine. Also enter does what it is supposed to do. The
problem is that enter can cause a pagefault on an address (far) below
the %esp, and Linu[xs] considers that an error (for good reasons).

Groeten,
Bart
-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
