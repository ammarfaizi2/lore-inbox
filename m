Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUFCHFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUFCHFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUFCHFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:05:47 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:61892 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261443AbUFCHD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:03:26 -0400
Message-ID: <40BECD28.70806@myrealbox.com>
Date: Thu, 03 Jun 2004 00:03:04 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC] Changing SysRq - show registers handling
References: <fa.jjf8osn.670mbt@ifi.uio.no>
In-Reply-To: <fa.jjf8osn.670mbt@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dmitry Torokhov wrote:

> Hi,
> 
> Currently SysRq "show registers" command dumps registers and the call
> trace from keyboard interrupt context when SysRq-P. For that struct pt_regs *
> has to be dragged throughout entire input and USB systems. Other than passing
> this pointer to SysRq handler these systems has no interest in it, it is
> completely foreign piece of data for them and I would like to get rid of it.
> 
> I am suggesting slightly changing semantics of SysRq-P handling - instread
> of dumping registers and call trace immediately it will simply post a request
> for this information to be dumped. When next HW interrupt arrives and is
> handled, before running softirqs then current stack trace will be printed.
> This approach adds small overhead to the HW interrupt handling routine as the
> condition has to be checked with every interrupt but I expect it to be
> negligible as it is only check and conditional jump that is almost never
> taken. The code should be hot in cache so branch prediction should work just
> fine.

What about checking the flag on return from the input interrupts?  That way 
the overhead would be confined to code paths take the hit from passing an 
extra parameter.


> 
> The patch below implements proposed changes in SysRq handler and adds
> necessary changes to do_IRQ() on i386. If it is agreed upon I will adjust
> other arches.
> 
> Please let me know what you think.
>  

--Andy
