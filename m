Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWHBRQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWHBRQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHBRQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:16:37 -0400
Received: from mail.aknet.ru ([82.179.72.26]:1034 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751197AbWHBRQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:16:37 -0400
Message-ID: <44D0DCF5.8050906@aknet.ru>
Date: Wed, 02 Aug 2006 21:12:21 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru> <44CFC139.4030801@vmware.com>
In-Reply-To: <44CFC139.4030801@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Zachary Amsden wrote:
> You need to get a #GP or #NP on the faulting iret.  Several ways to do 
> that -
I do that much simpler - I provoke a SIGSEGV and in a signal handler
I put the wrong value to scp->cs or scp->ss, and that makes iret to fault.

> iret faults, but doesn't pop the user return frame.
But does it push the kernel frame after it or not?
If not - I don't understand how we go to a fixup.
If yes - I don't understand how the user's frame gets
accessed later, as it is above the kernel's frame.

>> safe limit is regs->esp + THREAD_SIZE*2... Well, may just I not do 
>> that please? :)
>> For what, btw? There are no such a things for __KERNEL_DS or anything, so
>> I just don't see the necessity.
> It helps track down any bugs that could leak through otherwise and 
> corrupt random memory.
I think regs->esp + THREAD_SIZE*2 is already very permissive,
and I'd like to avoid messing with granularity. So unless you
really insist, I'll better not do that. :)

