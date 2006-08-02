Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWHBTJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWHBTJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHBTJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:09:10 -0400
Received: from mail.aknet.ru ([82.179.72.26]:62727 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932177AbWHBTJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:09:08 -0400
Message-ID: <44D0F901.40504@aknet.ru>
Date: Wed, 02 Aug 2006 23:12:01 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru> <44CFC139.4030801@vmware.com> <44D0DCF5.8050906@aknet.ru> <44D0EF30.7030701@vmware.com>
In-Reply-To: <44D0EF30.7030701@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Zachary Amsden wrote:
> Yes.  The iret faults, the fault pushes a new kernel frame - and the 
> fault handler's iret returns, removing the kernel frame.  So the kernel 
> frame is gone by the time the fixup runs.
OK, thanks! I wasn't completely realizing that the fixup runs
after an exception handler is already returned. Now it all looks
pretty obvious. :)

> It's really hard to catch bugs that could otherwise happen when a 
> non-zero based stack gets used (for example, C code which uses %ebp with 
> -fomit-frame-pointer).  Setting the limit to THREAD_SIZE should 
> guarantee that the non-zero based stack never is used to access anything 
> but the stack and current thread.
Yes, be there a possibility the set the *constant* limit (THREAD_SIZE),
I'd certainly do that, no questions. But as long as we are talking
about the nasty non-constant limit like regs->esp+THREAD_SIZE*2, is it
really worth an efforts? This limit is very unpredictable. I'll have
to add the code to deal with granularity. And its still very, very
permissive. Not even nearly something like just THREAD_SIZE.
Do you really, really think it is worth all the headache?

