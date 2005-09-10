Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVIJXr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVIJXr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVIJXr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:47:27 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49046 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932390AbVIJXr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:47:26 -0400
Message-ID: <43237083.5070406@pobox.com>
Date: Sat, 10 Sep 2005 19:47:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com> <200509102332.54619.s0348365@sms.ed.ac.uk>
In-Reply-To: <200509102332.54619.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Saturday 10 September 2005 22:58, Jeff Garzik wrote:
> 
>>Linus Torvalds wrote:
>>
>>>Case closed.
>>>
>>>Bogus warnings are a _bad_ thing. They cause people to write buggy code.
>>>
>>>That drivers/pci/pci.c code should be simplified to not look at the error
>>>return from pci_set_power_state() at all. Special-casing EIO is just
>>>another bug waiting to happen.
>>
>>As a tangent, the 'foo is deprecated' warnings for pm_register() and
>>inter_module_register() annoy me, primarily because they never seem to
>>go away.
>>
>>The only user of inter_module_xxx is CONFIG_MTD -- thus the deprecated
>>warning is useless to 90% of us, who will never use MTD.  As for
>>pm_register(), there are tons of users remaining.  As such, for the
>>forseeable future, we will continue to see pm_register() warnings and
>>ignore them -- thus they are nothing but useless build noise.
>>
>>I've attached a patch, just tested, which addresses inter_module_xxx by
>>making its build conditional on the last remaining user.  This solves
>>the deprecated warning problem for most of us, and makes the kernel
>>smaller for most of us, at the same time.
> 
> 
> Though external modules using these functions will be hung out to dry. But 
> only if you don't select CONFIG_MTD? That's not particularly intuitive.
> 
> It's better to mark it deprecated (which has been done), then officially 
> remove it (and all in-tree users) once and for all. Compiling the code 
> conditionally just to avoid a few warnings is a silly idea.


Presumably David Woodhouse (MTD maintainer) would yell if we just ripped 
out the in-tree users.

It is even more silly to continue compiling code that is dead for almost 
everybody.

	Jeff


