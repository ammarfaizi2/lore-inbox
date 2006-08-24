Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWHXDKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWHXDKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWHXDKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:10:42 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:18587 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030232AbWHXDKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:10:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pz9EgJpu3B7yqp+T0auXSo0RydbFV7YaD211LC2KC+IJ/Ez7+3wuqD+MJKVrlGtewCSF/Ldz1/+V1n98AxiT5vVQzOMuD1ro1fRLnPpilC+PoQ99Yy5de0uPG1o4naLpcWuWlQWN97WmBnrUPL3ba+QpadnkClZYZ6N/uW6/vsg=  ;
Message-ID: <44ED1891.6090708@yahoo.com.au>
Date: Thu, 24 Aug 2006 13:10:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Edward Falk <efalk@google.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
References: <44ED157D.6050607@google.com>
In-Reply-To: <44ED157D.6050607@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Falk wrote:
> Add spin_lock_string_flags and _raw_spin_lock_flags() to 
> asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same 
> semantics on x86_64 as it does on i386 and does *not* have interrupts 
> disabled while it is waiting for the lock.
> 
> This fix is courtesy of Michael Davidson

So, what's the bug? You shouldn't rely on these semantics anyway
because you should never expect to wait for a spinlock for so long
(and it may be the case that irqs can't be enabled anyway).

BTW. you should be cc'ing Andi Kleen (x86+/-64 maintainer) on
this type of stuff.

No comments on the merits of adding this feature. I suppose parity
with i386 is a good thing, though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
