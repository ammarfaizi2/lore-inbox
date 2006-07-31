Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWGaTOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWGaTOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWGaTOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:14:36 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:46391 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030336AbWGaTOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:14:36 -0400
Date: Mon, 31 Jul 2006 13:14:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
In-reply-to: <fa.+Nle/k4hS56BZtGd2LF1VOaLvRg@ifi.uio.no>
To: David Rees <drees76@gmail.com>
Cc: bert hubert <bert.hubert@netherlabs.nl>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
Message-id: <44CE567D.40305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.I17h4UhBWCsvus2I0Myp7dcrW/c@ifi.uio.no>
 <fa.+Nle/k4hS56BZtGd2LF1VOaLvRg@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> On 7/30/06, bert hubert <bert.hubert@netherlabs.nl> wrote:
>> On Sun, Jul 30, 2006 at 09:46:51PM +0200, Arjan van de Ven wrote:
>>
>> > as a side note ... you realize that clockmod doesn't actually save you
>> > any power right? ;)
>>
>> Indeed, and I've measured that too. But it saves an awful amount of 
>> noise!
> 
> If it doesn't save you power, how does it reduce noise? I guess it
> keeps you from overheating your processor which causes the fan to spin
> up?

The aim of power-saving techniques is to allow the same amount of 
computational work to be done while consuming less power. For example, 
if a task only uses 20% of the CPU at its maximum speed, the clock speed 
can be dropped down to half of the maximum. The main advantage of this 
is that it allows reducing the core voltage which I think accounts for 
most of the power savings. Essentially the lower performance settings 
have higher performance per watt than the higher settings.

Clock modulation doesn't reduce the CPU core voltage, nor does it reduce 
the rate at which power is consumed when the CPU is in the active state. 
It just causes the CPU to periodically stop its clock for a while, 
during which no work is done. This means that the power and heat 
produced is reduced but the work that can be done is also reduced by an 
proportional amount, so there is little or no improvement in performance 
per watt. As well, when the CPU has nothing to do it will be halted 
anyway which does pretty much the same as what clockmod is doing.

Essentially clockmod is there as a way to limit the thermal output of 
the CPU in thermal emergencies, it's not really very good as a 
power-saving feature.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

