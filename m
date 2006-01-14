Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWANNOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWANNOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWANNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:14:17 -0500
Received: from relay4.usu.ru ([194.226.235.39]:9867 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751286AbWANNOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:14:16 -0500
Message-ID: <43C8F962.9030409@ums.usu.ru>
Date: Sat, 14 Jan 2006 18:15:14 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@suse.de>
Cc: Greg K-H <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
References: <11371818082670@kroah.com> <11371818084013@kroah.com> <43C88898.10900@ums.usu.ru> <20060114110401.GA11237@vrfy.org>
In-Reply-To: <20060114110401.GA11237@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.123; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:

>On Sat, Jan 14, 2006 at 10:14:00AM +0500, Alexander E. Patrakov wrote:
>  
>
>>Greg KH wrote:
>>    
>>
>>>[PATCH] INPUT: add MODALIAS to the event environment
>>>
>>>input: add MODALIAS to the event environment
>>>      
>>>
>>Could you please tell me sample modaliases for a number of "common" 
>>devices (like a PS/2 mouse)?
>>
>>I ask because earlier (namely, in 
>>http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/old/gregkh-all-2.6.15.patch) 
>>such modaliases contained commas (",") and comma is not a "trusted" 
>>character in Udev (see replace_untrusted_chars() in udev_utils_string.c). 
>>Thus, such modaliases were mangled and didn't work.
>>    
>>
>
>Only if you read it with $sysfs{modalias}, it's available in $env{MODALIAS}
>and does not get mangled there, right? If you have problems with that,
>let us know and we will fix it.
>  
>
With the old gregkh-all-2.6.15.patch, I have:

sh-3.1# cat /sys/class/input/input1/modalias
input:b0011v0002p0004e0000-e0,1,2,k110,111,112,113,114,r0,1,8,amlsfw
sh-3.1# echo "add" >/sys/class/input/input1/uevent
sh-3.1# cat /events/1663
PHYSDEVPATH=/devices/platform/i8042/serio0
EV=7
SUBSYSTEM=input
DEVPATH=/class/input/input1
NAME="GenPS/2 Genius <NULL>"
ACTION=add
PWD=/
UDEV_LOG=7
REL=103
KEY=1f0000 0 0 0 0 0 0 0 0
UDEVD_EVENT=1
SHLVL=1
PHYSDEVDRIVER=psmouse
PHYS="isa0060/serio1/input0"
PRODUCT=11/2/4/0
PHYSDEVBUS=serio
SEQNUM=1663
_=/usr/bin/env

i.e., there is the "modalias" file in sysfs but no $MODALIAS in the 
environment. Is this the problem that your patch solves (note: I haven't 
tried it yet)?

-- 
Alexander E. Patrakov
