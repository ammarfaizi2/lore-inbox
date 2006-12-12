Return-Path: <linux-kernel-owner+w=401wt.eu-S964789AbWLLXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWLLXFl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWLLXFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:05:41 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:6834 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964785AbWLLXFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:05:39 -0500
Message-ID: <457F3621.9030804@ru.mvista.com>
Date: Wed, 13 Dec 2006 02:07:13 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
References: <200612130148.34539.sshtylyov@ru.mvista.com> <20061212150052.b05b05db.randy.dunlap@oracle.com>
In-Reply-To: <20061212150052.b05b05db.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Randy Dunlap wrote:

>>Behold!  This is the driver for the Toshiba TC86C001 GOKU-S IDE controller,
>>completely reworked from the original brain-damaged Toshiba's 2.4 version.
>>
>>This single channel UltraDMA/66 controller is very simple in programming, yet
>>Toshiba managed to plant many interesting bugs in it.  The particularly nasty
>>"limitation 5" (as they call the errata) caused me to abuse the IDE core in a
>>possibly most interesting way so far.  However, this is still better than the
>>#ifdef mess in drivers/ide/ide-io.c that the original version included (well,
>>it had much more mess)...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>> drivers/ide/Kconfig        |    5 
>> drivers/ide/pci/Makefile   |    1 
>> drivers/ide/pci/tc86c001.c |  304 +++++++++++++++++++++++++++++++++++++++++++++
>> drivers/pci/quirks.c       |   18 ++
>> include/linux/pci_ids.h    |    1 
>> 5 files changed, 329 insertions(+)
>>
>>Index: linux-2.6/drivers/ide/Kconfig
>>===================================================================
>>--- linux-2.6.orig/drivers/ide/Kconfig
>>+++ linux-2.6/drivers/ide/Kconfig
>>@@ -742,6 +742,11 @@ config BLK_DEV_VIA82CXXX
>> 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
>> 	  configure the chip to optimum performance.
>> 
>>+config BLK_DEV_TC86C001
>>+	tristate "Toshiba TC86C001 support"

> Needs something here like lots of other IDE PCI drivers have:
> 	depends on PCI && BLK_DEV_IDEPCI

> or at least:  depends on PCI

    No, it's already under if BLK_DEV_IDEPCI. And if you really look into 
Kconfig you'll see hwo it's done there...

>>+	help
>>+	This driver adds support for Toshiba TC86C001 GOKU-S chip.
>>+
>> endif

    Here's that endif.

WBR, Sergei
