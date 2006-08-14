Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWHNGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWHNGys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWHNGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 02:54:48 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:39127 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751896AbWHNGys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 02:54:48 -0400
Message-Id: <44E03A80.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 14 Aug 2006 08:55:28 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608111916_MC3-1-C7D7-ACA4@compuserve.com>
In-Reply-To: <200608111916_MC3-1-C7D7-ACA4@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I understand now, but am still uncertain
>> about the need to annotate FIX_STACK() - especially since you use
>> .cfi_undefined, meaning the return point cannot be established
anyway.
>> If at all I'd annotate the initial pushes with either just the
normal
>> CFI_ADJUST_CFA_OFFSET, and the final one with one setting back the
>> CFA base to the now adjusted frame. That way, until the pushes are
>> complete the old frame will be used for determining the call
origin,
>> and once complete the (full) new state will be used.
>
>But that's the whole point of the new annotations -- we have just
>overwritten %esp with a new value and the old assumptions are
>completely broken:
>
>        movl TSS_sysenter_esp0+offset(%esp),%esp;       \
>
>After this the old frame cannot be located by using %esp as a base
>and the new frame is incomplete.  So the only choice is to make eip
>undefined until the new value is available -- if not then the
>unwinder will try to use whatever random values are on the new frame.
>Either that or I'm still unclear on how unwind works...

Hmm, yes, on a second look I agree.

Jan
