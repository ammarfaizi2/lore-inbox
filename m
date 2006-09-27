Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWI0ERe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWI0ERe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 00:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWI0ERe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 00:17:34 -0400
Received: from mail9.hitachi.co.jp ([133.145.228.44]:65487 "EHLO
	mail9.hitachi.co.jp") by vger.kernel.org with ESMTP id S964780AbWI0ERd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 00:17:33 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002683U4519fb3c@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "Jesse Barnes" <jesse.barnes@intel.com>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <akpm@osdl.org>, <tony.luck@intel.com>, <greg@kroah.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 27 Sep 2006 13:17:10 +0900
References: <XNM1$9$0$4$$3$3$7$A$9002681U4518d9f9@hitachi.com> 
    <200609260850.41609.jesse.barnes@intel.com>
Importance: normal
Subject: Re[2]: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel for
    embedded VG
X400-Content-Identifier: X4519FB3C00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml16060927131700WUW]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tuesday, September 26, 2006 12:42 am, eiichiro.oiwa.nm@hitachi.com 
>wrote:
>> To be compatible with Xorg's handling of PCI, we need pci_fixup_video on
>> IA64 platform like x86 platform. There are also machines, which have VGA
>> embedded into main board, among IA64 platform. Embedded VGA generally
>> don't have PCI ROM, and there are VGA ROM image in System BIOS.
>> Therefore, these machines need pci_fixup_video for the sysfs rom.
>> pci_fixup_video already exists in x86 Linux kernel. However since this
>> function doesn't exist in IA64 kernel, we could not run X server on IA64
>> box has embedded-VGA.
>>
>> I tested pci_fixup_video on IA64 box has embedded-VGA. I confirmed we
>> can read VGA BIOS from the sysfs rom regardless of embedded-VGA.
>
>Looks good, Eiichiro, thanks for posting this.
>
>> +#include <linux/delay.h>
>> +#include <linux/dmi.h>
>> +#include <linux/pci.h>
>> +#include <linux/init.h>
>
>For this version, I don't think you need delay.h or dmi.h.  And like Bjorn 
>mentioned, this could probably be turned into generic code in drivers/pci 
>so we don't have too much duplication with x86 (and like I mentioned, 
>x86_64 could probably use this too).
>
>Jesse
>

"PCI-to-PCI Bridge Architecture Specification" describes how to support VGA.
And pci_fixup_video suits this specification because this function checks the
Bridge Control register. I also think pci_fixup_video should be turned into
generic quirks.c in drivers/pci.

Ok, I will modify code and test.

Thanks,
Eiichiro



