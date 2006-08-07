Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWHGF4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWHGF4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWHGF4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:56:19 -0400
Received: from gw.goop.org ([64.81.55.164]:23979 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751089AbWHGF4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:56:18 -0400
Message-ID: <44D6D60A.5040108@goop.org>
Date: Sun, 06 Aug 2006 22:56:26 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86 paravirt_ops: binary patching infrastructure
References: <1154925835.21647.29.camel@localhost.localdomain>	<1154926048.21647.35.camel@localhost.localdomain>	<1154926114.21647.38.camel@localhost.localdomain> <200608070738.13768.ak@muc.de>
In-Reply-To: <200608070738.13768.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>  
>> +#ifdef CONFIG_PARAVIRT
>> +void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
>>     
>
> It would be better to merge this with the existing LOCK prefix patching
> or perhaps the normal alternative() patcher (is there any particular
> reason you can't use it?)
>
> Three alternative patching mechanisms just seems to be too many

The difference is that every hypervisor wants its own patched 
instruction sequence, which may require a specialized patching 
mechanism.  If you're simply patching in calls, then it isn't a big 
deal, but you may also want to patch in real inlined code for some 
operations (like sti/cli equivalents).  The alternatives are to allow 
each backend to deal with its own patching (perhaps with common 
functions abstracted out as they appear), or have a common set of 
patching machinery which can deal with all users.  The former seems simpler.

    J
