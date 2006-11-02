Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752375AbWKBT1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbWKBT1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbWKBT1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:27:19 -0500
Received: from smtp13.dc2.safesecureweb.com ([65.36.255.237]:19435 "EHLO
	smtp13.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S1751352AbWKBT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:27:18 -0500
Message-ID: <000b01c6feb4$c340a580$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: "Bill Davidsen" <davidsen@tmr.com>, "Jean Delvare" <khali@linux-fr.org>
Cc: <davidz@redhat.com>, "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, <linux-kernel@vger.kernel.org>,
       <devel@laptop.org>, <sfr@canb.auug.org.au>, <len.brown@intel.com>,
       <greg@kroah.com>, <benh@kernel.crashing.org>,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
References: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <znLIYxER.1162453921.3011900.khali@localhost> <454A306C.3050200@tmr.com>
Subject: Re: [PATCH v2] Re: Battery class driver.
Date: Thu, 2 Nov 2006 14:26:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Bill Davidsen" <davidsen@tmr.com>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: <davidz@redhat.com>; "Richard Hughes" <hughsient@gmail.com>; "David 
Woodhouse" <dwmw2@infradead.org>; "Dan Williams" <dcbw@redhat.com>; 
<linux-kernel@vger.kernel.org>; <devel@laptop.org>; <sfr@canb.auug.org.au>; 
<len.brown@intel.com>; <greg@kroah.com>; <benh@kernel.crashing.org>; 
"linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>; "Pavel 
Machek" <pavel@suse.cz>
Sent: Thursday, November 02, 2006 12:52 PM
Subject: Re: [PATCH v2] Re: Battery class driver.


> Jean Delvare wrote:
>> On 10/31/2006, man with no name wrote:
>>> In the case at hand we have mWh and mAh, which measure different
>>> physical quantities. You can't convert between them unless you have
>>> intimate knowledge of the battery's chemistry and condition, which we
>>> don't.
>>
>> You just need to know the voltage of the battery, what else?
>>
>>> And it would be nice to also allow for power supply devices that use
>>> other, incompatible units like "percent" or "minutes" or "hand crank
>>> revolutions".
>>
>> Do such batteries exist at the moment, or are you just speculating?
>
> I have seen joules (or mJ) on a laptop. Yes, it was Windows, but I bet the 
> report came from hardware. Some vendor getting anal about metric?

The only thing that makes sense with batteries is the total amount of energy 
available. Such
energy has the dimension of watt-seconds, i.e., joules, even though a 
battery might be rated in ampere-hours.
This is because you can't even guess at the amount of energy remaining by 
looking at a battery's voltage. To
get joules, you need to multiply the voltage times the current times the 
time for all time, both the charge
time and the discharge time. When charging, the charging efficiency  needs 
to be taken into account as well.
The charging efficiency varies with the battery chemistry, its type, and its 
stored energy. For instance, a fully
charged battery has zero charging efficiency (any current supplied is 
converted to heat). A typical battery at
about one-half its capacity converts over 90% of the applied charge to 
stored energy.

No known laptop bothers to do this. That's why the batteries fail at the 
most inoportune times
and why it will decide to shut down when it feels like it, based totally 
upon some detected
voltage drop when a disk-drive started.

Analogic makes a portable CAT Scanner. It can be plugged into an ordinary 
wall outlet even though
the X-Ray subsystem takes 10 kilowatts! It does this by storing the needed 
energy in batteries. Since
the X-Ray is on only for a short period of time, the system has plenty of 
time to charge the batteries
while the image is being processed or reviewed. Since it is against FDA 
regulations to expose a
patient to X-Rays unless diagnistically-useful images result, it is 
mandatory that the charge state
of the batteries be known at all times so that an image sequence once 
started, is guaranteed to
complete. For this, we have a software sampler that calculates the charge 
about 1,000 per second.
It does nor assume that the samples are at millisecond intervals, it reads a 
hardware timer to get
the elapsed time between each sample. It measures the voltage, the current, 
and the time each
sample interval. It accumulates these samples into a charge variable with 
the dimension of joules.

> > I
>> don't quite see how a battery could report remaining energy in time
>> units, as power consumption varies over time. Hand crank revolutions
>> wouldn't be a very useful unit either, unless you know how much energy
>> a revolution provides, and then you can just convert it. Percent would
>> make some sense, but you can only express the remaining energy this way,
>> not the total. And if you know the total in mAh or mWh, you can multiply
>> by the percentage and you get the remaining energy in the same unit.
>>
>> --
>> Jean Delvare
>
>
> -- 
> Bill Davidsen <davidsen@tmr.com>
>   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
> normal user and is setuid root, with the "vi" line edit mode selected,
> and the character set is "big5," an off-by-one errors occurs during
> wildcard (glob) expansion.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 (somewhere) -- They shut off my email at 
work!
Book: http://www.AbominableFireug.com



