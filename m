Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVILUSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVILUSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVILUSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:18:40 -0400
Received: from bay105-f42.bay105.hotmail.com ([65.54.224.52]:36010 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932190AbVILUSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:18:38 -0400
Message-ID: <BAY105-F4274DB38813EE55D238942C09D0@phx.gbl>
X-Originating-IP: [84.191.235.136]
X-Originating-Email: [wegner3000@hotmail.com]
From: "Marcus Wegner" <wegner3000@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: Crash in Yenta initialization
Date: Mon, 12 Sep 2005 22:17:40 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3ce5_6e03_7e0f"
X-OriginalArrivalTime: 12 Sep 2005 20:17:40.0374 (UTC) FILETIME=[066F5B60:01C5B7D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_3ce5_6e03_7e0f
Content-Type: text/plain; charset=iso-8859-1; format=flowed

>  On Sat, Sep 03, Ivan Kokshaysky wrote:
>
>>On Sat, Sep 03, 2005 at 02:45:08AM +0200, Andreas Koch wrote:
>> > crucial part seem to be the different bridge initialization sections:
>>
>>Indeed.
>>
>> > 2.6.12-rc6 + Ivan's patches:
>>...
>> >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
>> >             IO window: 00006000-00006fff
>> >             IO window: 00007000-00007fff
>> >             PREFETCH window: 82000000-83ffffff
>> >             MEM window: 8c000000-8dffffff
>> >           PCI: Bus 11, cardbus bridge: 0000:06:09.1
>> >             IO window: 00008000-00008fff
>> >             IO window: 00009000-00009fff
>> >             PREFETCH window: 84000000-85ffffff
>> >             MEM window: 8e000000-8fffffff
>> >           PCI: Bus 15, cardbus bridge: 0000:06:09.3
>>...
>> > ... Versus the much shorter output from 2.6.13
>>...
>> >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
>> >             IO window: 00004000-000040ff
>> >             IO window: 00004400-000044ff
>> >             PREFETCH window: 82000000-83ffffff
>> >             MEM window: 88000000-89ffffff
>> >           PCI: Bridge: 0000:00:1e.0
>>
>>It's mysterious.
>>So 2.6.13 doesn't see cardbus bridge functions 06:09.1 and 06:09.3,
>>which means that these devices are not on the per-bus device list.
>>OTOH, they are still visible on the global device list, since yenta
>>driver found them. No surprise that it crashes with some uninitialized
>>pointer.
>
>Did you find the reason for this already?
>We have a similar report:
>https://bugzilla.novell.com/show_bug.cgi?id=113778
>...
>It dies in yenta_config_init because dev->subordinate is NULL.
>...
I had the same problem with an ACER 8101 WLMI. I reverted the initialization
partly and it works now, but I don't know if it really fixes the bug.
Something seems to wrong in the pci initcode.

But other hardware errors with the acer notebook still remain. The detection
of the ioapic results in a deadlock in the boot process (the
multiple-ioapic-fix or "noapic" solved this).

yenta related:
- pccard hardware is working now
- O2 Micro 4-1 cardreader is not working

Does someone have ideas, configs or patches for the cardreader? Do you need 
more info? Let me know.

Marcus


------=_NextPart_000_3ce5_6e03_7e0f
Content-Type: application/octet-stream; name="pci-assign-res-fix"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pci-assign-res-fix"


------=_NextPart_000_3ce5_6e03_7e0f
Content-Type: application/octet-stream; name="multiple-ioapic-fix"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="multiple-ioapic-fix"


------=_NextPart_000_3ce5_6e03_7e0f--
