Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUKIXn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUKIXn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUKIXnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:43:49 -0500
Received: from fmr99.intel.com ([192.55.52.32]:13497 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261782AbUKIXmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:42:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: /sys/devices/system/timer registered twice
Date: Tue, 9 Nov 2004 15:41:51 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60034D6F9F@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /sys/devices/system/timer registered twice
Thread-Index: AcTGs3nVOCvCdJ+PSnOL7pipsK9MlAAARTXQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <dtor_core@ameritech.net>, "Greg KH" <greg@kroah.com>
Cc: "Kay Sievers" <kay.sievers@vrfy.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Nov 2004 23:41:52.0758 (UTC) FILETIME=[B09B8960:01C4C6B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Dmitry Torokhov
>Sent: Tuesday, November 09, 2004 3:19 PM
>To: Greg KH
>Cc: Kay Sievers; linux-kernel@vger.kernel.org
>Subject: Re: /sys/devices/system/timer registered twice
>
>On Tue, 9 Nov 2004 14:52:45 -0800, Greg KH <greg@kroah.com> wrote:
>> 
>> 
>> On Tue, Nov 09, 2004 at 08:30:43PM +0100, Kay Sievers wrote:
>> > Hi,
>> > I got this on a Centrino box with the latest bk:
>> >
>> >   [kay@pim linux.kay]$ ls -l /sys/devices/system/
>> >   total 0
>> >   drwxr-xr-x  7 root root 0 Nov  8 15:12 .
>> >   drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
>> >   drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
>> >   drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
>> >   drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
>> >   drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
>> >   ?---------  ? ?    ?    ?            ? timer
>> >
>> >
>> > It is caused by registering two devices with the name "timer" from:
>> >
>> >   arch/i386/kernel/time.c
>> >   arch/i386/kernel/timers/timer_pit.c
>> >
>> > If I change one of the names, I get two correct looking 
>sysfs entries.
>> >
>> > Greg, shouldn't the driver core prevent the corruption of the first
>> > device if another one tries to register with the same name?
>> 
>> Hm, this looks like an issue for Dmitry, as there shouldn't be too
>> sysdev_class structures with the same name, right?
>> 
>
>I agree, but I think you got the wrong man here ;) You need to talk to
>Venkatesh.
>
>http://linux.bkbits.net:8080/linux-2.5/cset@41810e4aGZ0E5bn_hMb
>4JgIY5u90zA?nav=index.html|src/.|src/arch|src/arch/i386|src/arc
>h/i386/kernel|related/arch/i386/kernel/time.c
>

Yes. It was me :(.

But, do we really need two system devices for timers?. I feel 
we can call setup_pit_timer from time.c, whenever pit is being used.
Otherwise, we may have more issues like the order in which these 
two resumes are called and the like.

Thanks,
Venki 
