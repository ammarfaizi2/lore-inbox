Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbUCTOo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUCTOo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:44:26 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64251 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262575AbUCTOoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:44:24 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fast 64-bit atomic writes (SSE?)
References: <874qskl5ca.fsf@love-shack.home.digitalvampire.org.suse.lists.linux.kernel>
	<p73znacvuic.fsf@brahms.suse.de>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 20 Mar 2004 06:43:34 -0800
In-Reply-To: <p73znacvuic.fsf@brahms.suse.de>
Message-ID: <87znabk295.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> Definitely not how you do it ;-) You corrupt the user space
    Andi> FPU context.  Also you didn't do a CPUID check, so it would
    Andi> just crash on machines

I'm not an asm expert, so could you explain how it corrupts the FPU
context?  I tried to save off the value of the XMM register I used,
and the docs I have say that the movq and movdq instructions don't
affect any flags.

As far as the CPUID, you're right... I left that part of the code out
but I am definitely planning on using this only if the machine has SSE2.

    Andi> The RAID code has some examples on how to use SSE2 in the
    Andi> kernel correctly.

Hmm, they save cr0 and do a clts, and then restore cr0 when they're
done.  For my education, can you explain why?

    Andi> Better is probably to use CMPXCHG8, which avoids all of
    Andi> this.

OK, thanks.

 - Roland
