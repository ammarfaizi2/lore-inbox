Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWALRw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWALRw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWALRw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:52:27 -0500
Received: from earth.cora.nwra.com ([65.125.157.180]:58349 "EHLO
	earth.cora.nwra.com") by vger.kernel.org with ESMTP
	id S1030295AbWALRwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:52:25 -0500
Message-ID: <43C6974F.2080104@cora.nwra.com>
Date: Thu, 12 Jan 2006 10:52:15 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Help with machine check exception
References: <dq606p$776$1@sea.gmane.org>  <dq62df$gse$1@sea.gmane.org> <1137087233.26334.3.camel@localhost.localdomain>
In-Reply-To: <1137087233.26334.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-01-12 at 10:07 -0700, Orion Poplawski wrote:
>> mcelog decode states:
>>
>> CPU 0 4 northbridge TSC 184fcd0553e4
>>    Northbridge Watchdog error
>>         bit57 = processor context corrupt
>>         bit61 = error uncorrected
>>    bus error 'generic participation, request timed out
>>        generic error mem transaction
>>        generic access, level generic'
>> STATUS b200000000070f0f MCGSTATUS 4
>> Kernel panic - not syncing: Machine check
> 
> Could be ram cpu or motherboard, even a power glitch of course.
> 
> Before you panic I'd suggest that you check the machine is being
> adequately cooled (especially the CPU) and that the ram and cpu are all
> well socketed.
> 
> memtest86+ will help test for memory problems and may be worth an
> overnight run
> 

Well, I've swapped memory with an identical machine and the problem 
stayed where it was.  The crash is fairly frequent (about 1-2 days of 
operating).

adm1027-i2c-0-2e
Adapter: SMBus AMD8111 adapter at 10e0
V1.5:      +2.601 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore:     +1.304 V  (min =  +1.48 V, max =  +1.63 V)   ALARM
V3.3:      +3.326 V  (min =  +3.13 V, max =  +3.47 V)
V5:       +5.117 V  (min =  +4.74 V, max =  +5.26 V)
V12:      +12.094 V  (min = +11.38 V, max = +12.62 V)
CPU_Fan:      0 RPM  (min = 4000 RPM)                     ALARM
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:      4981 RPM  (min =    0 RPM)
CPU:      +50.00°C  (low  =   +10°C, high =   +50°C)
Board:    +34.00°C  (low  =   +10°C, high =   +35°C)
Remote:   +52.50°C  (low  =   +10°C, high =   +35°C)     ALARM
CPU_PWM:   255
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.550 V  (VRM Version 9.1)


I would have expected 2 CPU temps (being dual-processor).  Maybe Remote 
is the second.

With 4 copies of burnK7:

machine with problems:

CPU:      +71.25°C  (low  =   +10°C, high =   +50°C)     ALARM
Board:    +47.25°C  (low  =   +10°C, high =   +35°C)     ALARM
Remote:   +68.50°C  (low  =   +10°C, high =   +35°C)     ALARM

machine without:

CPU:      +61.25°C  (low  =   +10°C, high =   +50°C)     ALARM
Board:    +47.25°C  (low  =   +10°C, high =   +35°C)     ALARM
Remote:   +74.25°C  (low  =   +10°C, high =   +35°C)     ALARM


So *maybe* cooling?




