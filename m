Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752004AbWJWVL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbWJWVL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJWVL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:11:28 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:6962 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1752004AbWJWVL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:11:27 -0400
Message-ID: <453D2FFA.3040506@qumranet.com>
Date: Mon, 23 Oct 2006 23:11:22 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
References: <453CC390.9080508@qumranet.com> <200610232141.45802.arnd@arndb.de>	 <453D230D.7070403@qumranet.com> <200610232229.41934.arnd@arndb.de>	 <453D27F8.8020509@qumranet.com> <69304d110610231402k7913df63l7e493f95b5d92911@mail.gmail.com>
In-Reply-To: <69304d110610231402k7913df63l7e493f95b5d92911@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 21:11:26.0785 (UTC) FILETIME=[CD3D1B10:01C6F6E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
>>
>> I could do that, but I feel that's more brittle.  I might need more (or
>> other) fields later on.  It will also cost me more  pushes on the stack
>> (no real performance or space impact, just C64-era frugality).
>
> maybe thats the mindsent needed to make these virtual cpu patches
> without eating away all the cpu power with more than needed
> abstractions ;)
>

Unfortunately not.  Saving a cycle or two doesn't help when a vm exit 
costs thousands of cycles, and worse, kills your tlb.

The key is eliminating unnecessary exits.  I have plans for massively 
optimizing the mmu virtualization, and the next AMD core will do that in 
hardware (look for a "nested page tables" sticker before you buy).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

