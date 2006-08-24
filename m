Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWHXLEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWHXLEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWHXLEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:04:54 -0400
Received: from elvis.mu.org ([192.203.228.196]:50392 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1751105AbWHXLEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:04:53 -0400
Message-ID: <44ED87AC.8070106@FreeBSD.org>
Date: Thu, 24 Aug 2006 13:04:12 +0200
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
References: <44ED157D.6050607@google.com> <p7364gifx8o.fsf@verdi.suse.de>
In-Reply-To: <p7364gifx8o.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Edward Falk <efalk@google.com> writes:
> 
> 
>>Add spin_lock_string_flags and _raw_spin_lock_flags() to
>>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
>>semantics on x86_64 as it does on i386 and does *not* have interrupts
>>disabled while it is waiting for the lock.
> 
> 
> Did it fix anything for you?

I think this was to work around the fact that some buggy drivers try to 
grab spinlocks without disabling interrupts when they should, which 
would cause deadlocks when trying to rendez-vous every cpu via IPIs.

It's a bad idea to spin with interrupts disabled when they could very 
well be enabled, anyway.

-- Suleiman
