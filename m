Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756919AbWKVGmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbWKVGmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 01:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756921AbWKVGmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 01:42:39 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:22704 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1756919AbWKVGmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 01:42:38 -0500
Message-ID: <4563F158.3060209@qumranet.com>
Date: Wed, 22 Nov 2006 08:42:32 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <4563667B.2060209@goop.org>
In-Reply-To: <4563667B.2060209@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 06:42:38.0332 (UTC) FILETIME=[66A6EBC0:01C70E01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
>
>
> Like "volatile" variables, I think "asm volatile" is probably overused.
> If you want to guarantee specific ordering of asms, it's probably better
> to add an explicit dependency between them rather than rely on asm
> volatile; this could either be a "memory" clobber, or something more
> fine-grained.  For example:
>
>     /* need never be instansiated; never actually referenced */
>     extern int spin_sequencer;
>
>     /* %0 never referenced */
>     asm("take spinlock" : "+m" (spin_sequencer)...);
>
>     ...
>
>     /* again, %0 never referenced */
>     asm("release spinlock" : "+m" (spin_sequencer)...);
>

Very interesting.

Will it work on load/store architectures?  Since all memory access is 
through a register, won't the constraint generate a useless register 
load (and a use of the variable)?


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

