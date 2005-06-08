Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVFHTEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVFHTEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFHTEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:04:50 -0400
Received: from stargate.chelsio.com ([64.186.171.138]:12328 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S261544AbVFHTEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:04:43 -0400
Message-ID: <42A742FF.2020706@chelsio.com>
Date: Wed, 08 Jun 2005 12:11:59 -0700
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
References: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com> <20050608184933.GC2369@mail.muni.cz>
In-Reply-To: <20050608184933.GC2369@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2005 19:04:06.0990 (UTC) FILETIME=[D83266E0:01C56C5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

You would need to use the cxgb-2.1.1 driver (NIC only). It is near the bottom of 
the webpage, under "Chelsio N210 / N110 10Gb Ethernet Server Adapter",  Chelsio 
N210 / N110 Linux Driver - Version 2.1.1 (05/17/2005).
<https://service.chelsio.com/drivers/linux/n210/cxgb-2.1.1.tar.gz>
Use the above driver for the T110 in NIC mode. This driver will work for the 
T110 and T210 but only in NIC mode.

The NIC driver does not have CONFIG_CHELSIO_T1_OFFLOAD, so the card will work in 
  NIC only mode.

You would not have success in trying to modify the TOE driver (cxgbtoe-2.1.1) 
because this requires a lot of modifications to the TOM (TCP Offload Module) and 
the TOE API in order to work with a newer kernel.

In the future, we plan on trying to get our TOE API into the Linux kernel, but 
this requires a lot of work and acceptance of TOE by the community first.

-Scott

Lukas Hejtmanek wrote:
> On Wed, Jun 08, 2005 at 10:33:09AM -0700, Scott Bardone wrote:
> 
>>You can download the N210/N110 (ver 2.1.1) from the Chelsio website and use
>>that driver for the T110 with a newer kernel. I have tested that driver up to
>>the 2.6.11 kernel release. It will provide you NIC mode functinoality on your
>>T110 TOE card, you can use it as a module, or try to patch it into a later
>>kernel. If patching it into a kernel, you may need to modify the patch a bit.
> 
> 
> Thanks, however, without CONFIG_CHELSIO_T1_OFFLOAD card is not detected (no
> wonder, driver enables T110 card only if offload is used). I do not need TCP
> offload engine. With T1 Offload it cannot be compiled - it reject
> cxgbtoe-2.1.1-linux-2.6.6-toe_api.patch
> 
> So, do I really need Offloading in kernel or should it work with just enableing
> card in sources even without Offloading?
> 
