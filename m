Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWHKUB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWHKUB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHKUB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:01:28 -0400
Received: from rtr.ca ([64.26.128.89]:15238 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964779AbWHKUB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:01:27 -0400
Message-ID: <44DCE213.8090508@rtr.ca>
Date: Fri, 11 Aug 2006 16:01:23 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <44DCCB96.5080801@rtr.ca> <20060811183954.GH26930@redhat.com> <44DCDD50.4020804@rtr.ca>
In-Reply-To: <44DCDD50.4020804@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Dave Jones wrote:
>>
>> boot with cpufreq.debug=7, and capture dmesg output after it fails
>> to transition.  This might be another manifestation of the mysterious
>> "highest frequency isnt accessable" bug, that seems to come from
>> some recent change in acpi.
> 
> booting with that option doesn't seem to give me any new messages
> in dmesg (or /var/log/messages).  I also tried editing cpufreq.c
> and hardcoding debug = 7 on the variable declaration.
> Still no new messages.

Mmm.. that's interesting.. this time, the scaling_max_freq went back up
to 1100000 all by itself after a longish idle period, before which it had
dropped to 800000 and got "stuck" there.

Currently using the "ondemand" governor -- it doesn't seem to call the
central cpufreq_debug_printk() thingie from cpufreq.c.

I did hack cpufreq_debug_printk() to force output anytime it gets called,
but still no new output in the logs.

Cheers
