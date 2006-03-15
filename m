Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWCOJFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWCOJFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCOJFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:05:17 -0500
Received: from javad.com ([216.122.176.236]:12307 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751907AbWCOJFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:05:16 -0500
From: Sergei Organov <osv@javad.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <878xrecypp.fsf@javad.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<31016.1142368317@warthog.cambridge.redhat.com>
Date: Wed, 15 Mar 2006 12:04:54 +0300
In-Reply-To: <31016.1142368317@warthog.cambridge.redhat.com> (David
 Howells's
	message of "Tue, 14 Mar 2006 20:31:57 +0000")
Message-ID: <87hd60axjd.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Sergei Organov <osv@javad.com> wrote:
>
>> "You can prevent an `asm' instruction from being deleted by writing the
>> keyword `volatile' after the `asm'. [...]
>> The `volatile' keyword indicates that the instruction has important
>> side-effects.  GCC will not delete a volatile `asm' if it is reachable.
>> (The instruction can still be deleted if GCC can prove that
>> control-flow will never reach the location of the instruction.)  *Note
>> that even a volatile `asm' instruction can be moved relative to other
>> code, including across jump instructions.*"
>
> Ummm... If "asm volatile" statements don't form compiler barriers, then how do
> you specify a compiler barrier? Or is that what the "memory" bit in:
>
> 	#define barrier() __asm__ __volatile__("": : :"memory")
>
> does?

AFAIU the "memory" tells GCC that this asm has side-effects of changing
arbitrary memory addresses. This in turn prevents GCC from keeping
memory values in registers through the instruction:

"If your assembler instructions access memory in an unpredictable
 fashion, add `memory' to the list of clobbered registers.  This will
 cause GCC to not keep memory values cached in registers across the
 assembler instruction and not optimize stores or loads to that memory.
 You will also want to add the `volatile' keyword if the memory affected
 is not listed in the inputs or outputs of the `asm', as the `memory'
 clobber does not count as a side-effect of the `asm'."

So both volatile and "memory" are required to get true compiler barrier.

-- Sergei.
