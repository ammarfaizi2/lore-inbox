Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946041AbWJ0G2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946041AbWJ0G2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 02:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946045AbWJ0G2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 02:28:37 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:44469 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1946041AbWJ0G2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 02:28:36 -0400
Message-ID: <4541A758.9010504@kolumbus.fi>
Date: Fri, 27 Oct 2006 09:29:44 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andi Kleen <ak@muc.de>, Om Narasimhan <om.turyx@gmail.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, bob.picco@hp.com
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com> <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com> <20061027024238.GC58088@muc.de> <20061027055708.GA20270@suse.cz>
In-Reply-To: <20061027055708.GA20270@suse.cz>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 27.10.2006 09:28:25,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 27.10.2006 09:28:25,
	Serialize complete at 27.10.2006 09:28:25,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 27.10.2006 09:28:26,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 27.10.2006 09:28:34,
	Serialize complete at 27.10.2006 09:28:34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Oct 27, 2006 at 04:42:38AM +0200, Andi Kleen wrote:
>
>   
>> On Wed, Oct 25, 2006 at 02:20:22PM -0700, Om Narasimhan wrote:
>>     
>>> I tested against five different bioses (some with 8132, some with
>>> CK-804 ..etc) and I observed three different patterns.
>>>
>>> 1. HW is LRR capable, HPET ACPI it is 1, timer interrupt is on INT2.
>>> Before the fix: Linux cannot get timer interrupts on INT0, goes for ACPI 
>>> timer.
>>>       
>> What ACPI timer?  I don't think we have any fallback for int 0.
>>
>> Not sure what you mean with INT2. Pin2 on ioapic 0 perhaps?
>>
>>     
>>> After the fix : Works fine. This is according to hpet spec.
>>>       
>> On what exact motherboard was that?
>>
>>     
>>> To handle case 3, I removed all references to acpi_hpet_lrr, explained
>>> this case in the code and decided to solely rely on the command line
>>> parameter for LRR capability. Rational for this approach is ,
>>>       
>> This means the systems which you said fixes this would need the command
>> line parameter to work? 
>>
>>     
>>> 1. At present, there are not many BIOSes which implement LRR (correctly)
>>> 2. People would see the bootup message (MP-BIOS bug...) if LRR is
>>> enabled and no timer interrupt on INT0. They can pass the hpet_lrr=1
>>> to make everything work fine.
>>> Is it the right approach?
>>>       
>> Generally we try to work everywhere without command line parameter
>> unless something is terminally broken. 
>>     
>
> JFYI: The new per-cpu timekeeping code doesn't need the HPET legacy bit,
> thus not replacing IRQ0 (PIT) and IRQ13 (RTC). It still can do that, but
> will work just as well without it.
>
>   
There seems to be lot of confusion here. Current code isn't using hpet 
as tick source if legacy is not supported. This patch adds 
hpet_lrr_force but it's not clear how it interacts with hpet_use_timer - 
in some places it is hpet_use_timer and some (hpet_use_timer && 
hpet_lrr_force).

The timer is routed to ioapic pin 2 which is irq0 with source override. 
With this patch with hpet_lrr_force=1 timer irq is set to 2 for x86_64 
and 0 for i386, that can't be right?

--Mika


