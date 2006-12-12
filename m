Return-Path: <linux-kernel-owner+w=401wt.eu-S964808AbWLLXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWLLXLl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWLLXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:11:41 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:12409 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964802AbWLLXLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:11:39 -0500
Message-ID: <457F374F.4030106@oracle.com>
Date: Tue, 12 Dec 2006 15:12:15 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
References: <200612130148.34539.sshtylyov@ru.mvista.com> <20061212150052.b05b05db.randy.dunlap@oracle.com> <457F3621.9030804@ru.mvista.com>
In-Reply-To: <457F3621.9030804@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Randy Dunlap wrote:
> 
>>> Behold!  This is the driver for the Toshiba TC86C001 GOKU-S IDE 
>>> controller,
>>> completely reworked from the original brain-damaged Toshiba's 2.4 
>>> version.
>>>
>>> This single channel UltraDMA/66 controller is very simple in 
>>> programming, yet
>>> Toshiba managed to plant many interesting bugs in it.  The 
>>> particularly nasty
>>> "limitation 5" (as they call the errata) caused me to abuse the IDE 
>>> core in a
>>> possibly most interesting way so far.  However, this is still better 
>>> than the
>>> #ifdef mess in drivers/ide/ide-io.c that the original version 
>>> included (well,
>>> it had much more mess)...
> 
>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>>> drivers/ide/Kconfig        |    5 drivers/ide/pci/Makefile   |    1 
>>> drivers/ide/pci/tc86c001.c |  304 
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>> drivers/pci/quirks.c       |   18 ++
>>> include/linux/pci_ids.h    |    1 5 files changed, 329 insertions(+)
>>>
>>> Index: linux-2.6/drivers/ide/Kconfig
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/ide/Kconfig
>>> +++ linux-2.6/drivers/ide/Kconfig
>>> @@ -742,6 +742,11 @@ config BLK_DEV_VIA82CXXX
>>>       This allows the kernel to change PIO, DMA and UDMA speeds and to
>>>       configure the chip to optimum performance.
>>>
>>> +config BLK_DEV_TC86C001
>>> +    tristate "Toshiba TC86C001 support"
> 
>> Needs something here like lots of other IDE PCI drivers have:
>>     depends on PCI && BLK_DEV_IDEPCI
> 
>> or at least:  depends on PCI
> 
>    No, it's already under if BLK_DEV_IDEPCI. And if you really look into 
> Kconfig you'll see hwo it's done there...
> 
>>> +    help
>>> +    This driver adds support for Toshiba TC86C001 GOKU-S chip.
>>> +
>>> endif
> 
>    Here's that endif.

Ack.  Thanks.

-- 
~Randy
