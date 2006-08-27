Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWH0MvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWH0MvC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 08:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWH0MvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 08:51:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38310 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932101AbWH0MvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 08:51:00 -0400
Message-ID: <223978.1156683050640.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Sun, 27 Aug 2006 14:50:50 +0200 (CEST)
From: Thomas Renninger <trenn@suse.de>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       naveen.b.s@intel.com
In-Reply-To: <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-309-smp i386 (JVM 1.3.1_18)
Organization: SuSE Linux AG
References: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com> <1155643418.4302.1154.camel@queen.suse.de> <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr 25.08.2006 13:59 schrieb Yasunori Goto <y-goto@jp.fujitsu.com>:
>
>>
>> > I sent a patch a while ago that gets rid of the whole namespace
>> > walking
>> > by making acpi_memoryhotplug an acpi device and making use of the
>> > .add
>> > callback function and the acpi_bus_register_driver call.
>> >
>> > I am not sure whether this is possible if you have multiple memory
>> > devices, though (if not maybe it should be made possible?)...
>> >
>> > Yasunori even tested the patch and sent an Ok:
>> > http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2
>> >
>> > If this is acceptable I can rebase the patch on a current kernel.
>>
>> Hi. Thomas-san.
>> Did you rebase your patch?
>>
>> I'm trying to do it now too.
>> But, current code (2.6.18-rc4) seems to register handler for
>> only enable status devices at boot time.
>> So, notification is -discarded- due to no handler for new memory
>> device when hot-add event occurs. Hmmm. :-(
>No, what I see the notify handler is always installed.
>But there seem to be added some device state code, which I think is not
>correct:
>E.g. the state in acpi_memory_device_add():
>    mem_device->state = MEMORY_POWER_ON_STATE;
>should be evaluated from _STA function.
> When an ACPI memory device is added, the physical memory might not
>be added yet... IMO only one state, the one evaluated from _STA should
>be used.
>I'll have a closer look.
>
>This probably is nothing for 2.6.18 ... you never know..., but maybe it
>can be added
>to ACPI test branch or mm?
>Patch is against 2.6.18-rc4 and only compile
>tested (don't have hardware to test).
>
>The attached patch moves the install/remove notify handler to the
>.add/.remove callback functions that get invoked for every ACPI memory
>device
>(like it is done in other ACPI modules).
>No need for an additional walk_namespace() call.
>
>Sorry, I can only attach patch because of webmailer...
>

