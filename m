Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVFXUmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVFXUmo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVFXUjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:39:47 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:25513 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261826AbVFXUic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:38:32 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Fri, 24 Jun 2005 13:38:13 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: e1000 driver works on UP, bt not SMP x86_64 (2.6.7 -2.6.12)
In-Reply-To: <5fc59ff30506240755149b048@mail.gmail.com>
Message-ID: <D53BF43BC70DD511A22500508BB3C0071D202DF4@wlvexc00.diginsite.com>
References: <Pine.LNX.4.62.0506191642440.12697@qynat.qvtvafvgr.pbz><200506220038.05869.adobriyan@gmail.com>
 <5fc59ff30506240755149b048@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005, Ganesh Venkatesan wrote:

> David:
>
> Does this not happen with kernels earlier than 2.6.7 or you have not
> tried them? After you ifconfig the fourth port what does
> /proc/interrupts look like? Any additional info in syslog?

I haven't tried with kernels earlier then 2.6.7, when I ran into the 
problem there I tried upgradeing to see if it fixed it and it didn't.


here is /proc/interrupts with eth0 and eth1 in use
happy1-p:~# cat /proc/interrupts
            CPU0       CPU1
   0:     651218      31813    IO-APIC-edge  timer
   2:          0          0          XT-PIC  cascade
   3:        208          1    IO-APIC-edge  serial
   4:         76          1    IO-APIC-edge  serial
   8:          2          1    IO-APIC-edge  rtc
  14:          0         13    IO-APIC-edge  ide0
  25:       7909          1   IO-APIC-level  eth0
  26:       1595          1   IO-APIC-level  eth1
  29:       1698         87   IO-APIC-level  ioc0
NMI:          0          0
LOC:     674604     677630
ERR:          0
MIS:          0

here is after doing ifconfig

  cat /proc/interrupts
            CPU0       CPU1
   0:     760722      31813    IO-APIC-edge  timer
   2:          0          0          XT-PIC  cascade
   3:        555          1    IO-APIC-edge  serial
   4:         76          1    IO-APIC-edge  serial
   8:          2          1    IO-APIC-edge  rtc
  14:          0         13    IO-APIC-edge  ide0
  25:       9146          1   IO-APIC-level  eth0
  26:       1830          1   IO-APIC-level  eth1
  29:       1736         87   IO-APIC-level  ioc0
NMI:          0          0
LOC:     784112     787138
ERR:          0
MIS:          0

syslog shows
Jun 24 13:37:12 happy1-p kernel: e1000: eth11: e1000_up: Unable to allocate interrupt Error: -22

David Lang

> ganesh.
>
> On 6/21/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> On Monday 20 June 2005 03:55, David Lang wrote:
>>> I have some systems with three Intel quad gig-E cards in them that
>>> function with the attached UP config, but port 4 of each card doesn't work
>>> properly with a SMP kernel (otherwise the same config).
>>>
>>> on a SMP kernel when I do an ifconfig of the fourth port I get the
>>> following error
>>> SIOCSIFFLAGS: Function not implemented
>>>
>>> doing an ifconfig of the interface then looks proper, but no network route
>>> is added.
>>>
>>> I first ran into this problem with a 2.6.7 kernel and tried several
>>> kernels from there to 2.6.12, all of which showed the same problem on SMP
>>> kernels. the problem happens with the driver built-in and as a module.
>>>
>>> the systems are dual Opteron 246, 2G ram MPT fusion SCSI drives.
>>
>> I've filed a bug at kernel bugzilla, so your report won't be lost.
>> See http://bugzilla.kernel.org/show_bug.cgi?id=4774
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
