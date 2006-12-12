Return-Path: <linux-kernel-owner+w=401wt.eu-S1750853AbWLLBpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWLLBpH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWLLBpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:45:07 -0500
Received: from gw.goop.org ([64.81.55.164]:50248 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbWLLBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:45:05 -0500
Message-ID: <457E097C.5030208@goop.org>
Date: Mon, 11 Dec 2006 17:44:28 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
References: <457E0460.4030107@goop.org> <457E08FE.6050600@vmware.com>
In-Reply-To: <457E08FE.6050600@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
>> Hi Andi,
>>
>> What problem do they cause together?  There's certainly no problem with
>> Xen+vdso (in fact, its actually very useful so that it picks up the
>> right libc with Xen-friendly TLS).
>>   
>
> Methinks the compat VDSO support got broken in the config?  Paravirt +
> COMPAT_VDSO are incompatible. 

Yes, that's true, but I'm looking at arch/i386/kernel/sysenter.c:

#ifdef CONFIG_PARAVIRT
unsigned int __read_mostly vdso_enabled = 0;
#else
unsigned int __read_mostly vdso_enabled = 1;
#endif

I can't think of any reason why that should be necessary.

    J
