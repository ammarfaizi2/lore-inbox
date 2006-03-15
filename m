Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWCOJJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWCOJJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCOJJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:09:54 -0500
Received: from javad.com ([216.122.176.236]:25363 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932107AbWCOJJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:09:53 -0500
From: Sergei Organov <osv@javad.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "David Howells" <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <878xrecypp.fsf@javad.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<31016.1142368317@warthog.cambridge.redhat.com>
	<Pine.LNX.4.61.0603141601550.9216@chaos.analogic.com>
Date: Wed, 15 Mar 2006 12:09:43 +0300
In-Reply-To: <Pine.LNX.4.61.0603141601550.9216@chaos.analogic.com>
	(linux-os@analogic.com's message of "Tue, 14 Mar 2006 16:11:36 -0500")
Message-ID: <87bqw8axbc.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Tue, 14 Mar 2006, David Howells wrote:
>
>> Sergei Organov <osv@javad.com> wrote:
>>
>>> "You can prevent an `asm' instruction from being deleted by writing the
>>> keyword `volatile' after the `asm'. [...]
>>> The `volatile' keyword indicates that the instruction has important
>>> side-effects.  GCC will not delete a volatile `asm' if it is reachable.
>>> (The instruction can still be deleted if GCC can prove that
>>> control-flow will never reach the location of the instruction.)  *Note
>>> that even a volatile `asm' instruction can be moved relative to other
>>> code, including across jump instructions.*"
>>
>> Ummm... If "asm volatile" statements don't form compiler barriers, then how do
>> you specify a compiler barrier? Or is that what the "memory" bit in:
>>
>> 	#define barrier() __asm__ __volatile__("": : :"memory")
>>
>> does?
>>
>> David
>
> Yeh. This is the problem (restated) that I mentioned the other
> day when you must do a dummy read of the PCI/Bus to flush all
> the writes, to some variable that gcc can't decide isn't
> important. That's why (void)readl(PCI_STATUS) won't work
> (with gcc 3.3.3 anyway).

If it indeed doesn't, then it's a bug in GCC. GCC shouldn't throw
away volatile accesses. I've already quoted the GCC manual for you:

" Less obvious expressions are where something which looks like an access
is used in a void context.  An example would be,

     volatile int *src = SOMEVALUE;
     *src;

 With C, such expressions are rvalues, and as rvalues cause a read of
the object, GCC interprets this as a read of the volatile being pointed
to. "

-- Sergei.
