Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWEKVSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWEKVSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWEKVSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:18:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63130 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750795AbWEKVSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:18:48 -0400
Date: Thu, 11 May 2006 23:18:33 +0200 (MEST)
Message-Id: <200605112118.k4BLIXqX012607@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: ak@suse.de
Subject: Re: [patch] SMP alternatives: skip with UP kernels.
Cc: kraxel@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2006 20:28:09 +0200, Andi Kleen wrote:
>Mikael Pettersson <mikpe@it.uu.se> writes:
>
>> On Thu, 11 May 2006 14:13:22 +0200, Gerd Hoffmann wrote:
>> >+	if (0 == (__smp_alt_end - __smp_alt_begin))
>> >+		return; /* no tables, nothing to patch (UP kernel) */
>> 
>> That's an unnecessarily obscure way of stating the obvious:
>> 
>> 	if (__smp_alt_end == __smp_alt_begin)
>
>iirc ISO-C guarantees that symbols have different values and the
>optimizer could possibly make use of that fact. So you might actually
>need some RELOC_HIDE()s to make this safe.

OK, I didn't consider that (with "extern $type a[], b[];", "a == b"
is false by definition). However, the (0 == (_ - _)) version is no
safer, since a compiler can legally turn it back to a single "==".

Since you brought up the "rules of C" argument: the
(__smp_alt_end - __smp_alt_begin) expression is undefined because
pointer subtraction is only valid if both pointers point into
the same object (or just after it), which isn't the case here.

A plain "==" with RELOC_HIDE() on the operands would be best IMO.

/Mikael
