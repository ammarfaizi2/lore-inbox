Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJQRIP>; Thu, 17 Oct 2002 13:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261688AbSJQRIO>; Thu, 17 Oct 2002 13:08:14 -0400
Received: from h-64-105-136-233.SNVACAID.covad.net ([64.105.136.233]:39848
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261677AbSJQRIN>; Thu, 17 Oct 2002 13:08:13 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 17 Oct 2002 10:14:03 -0700
Message-Id: <200210171714.KAA02527@baldur.yggdrasil.com>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] de2104x.c missing __devexit_p in 2.5.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>Andrey Panin wrote:
>> diff -urN -X /usr/share/dontdiff linux-vanilla/drivers/net/tulip/de2104x.c \
>>                 linux/drivers/net/tulip/de2104x.c
>> --- linux-vanilla/drivers/net/tulip/de2104x.c Sun Sep  1 02:04:53 2002
>> +++ linux/drivers/net/tulip/de2104x.c Thu Oct 17 04:10:19 2002
>> @@ -2216,7 +2216,7 @@
>>       .name           = DRV_NAME,
>>       .id_table       = de_pci_tbl,
>>       .probe          = de_init_one,
>> -     .remove         = de_remove_one,
>> +     .remove         = __devexit_p(de_remove_one),
>> #ifdef CONFIG_PM
>>       .suspend        = de_suspend,
>>       .resume         = de_resume,
>
>
>alas, it is incorrect, as no one hotplugs this hardware.

	I believe that there are motherboards that use a chipset from
Compaq that allows hot plugging and unplugging of ordinary PCI cards,
supported by drivers in linux-2.5.43/drivers/hotplug/cpq*.[ch].  At a
trade show, I saw a demo of a motherboard with such a capability (not
running Linux, but I think from Compaq).

	So, I believe that all ordinary PCI cards (as opposed to
devices soldered onto motherboards, for example) are now hot plug
capable, although their Linux drivers may not yet be.

	Do I misunderstand the situation?

	As a side note, I also either do not agree or somehow
misunderstand Jeff Garzik's opposition to devexit_p in non-hotplug
drivers, but that issue will irrelevant in the case of de2104.c if it
is indeed possible for all ordinary PCI form factor cards to be
deployed with the hot plug motherboard chipset that I described.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
