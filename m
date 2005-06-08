Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVFHT7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVFHT7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFHT73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:59:29 -0400
Received: from stargate.chelsio.com ([64.186.171.138]:46389 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S261585AbVFHT7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:59:11 -0400
Message-ID: <42A74FAE.2010106@chelsio.com>
Date: Wed, 08 Jun 2005 13:06:06 -0700
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
References: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com> <20050608184933.GC2369@mail.muni.cz> <42A742FF.2020706@chelsio.com> <20050608193215.GF2369@mail.muni.cz>
In-Reply-To: <20050608193215.GF2369@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2005 19:58:13.0922 (UTC) FILETIME=[6784E820:01C56C64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

I had to investigate the driver a bit and I am mistaken in saying that the NIC 
driver will support the T110 card. It does not.

The reason for this is that the T110 will use the TCAM even in NIC mode and that 
code is missing from the NIC driver. The TCAM needs to be initialized for using 
TCP traffic in tunneled (non-offload) mode. However, if you just add the 
enumeration for the T110, UDP should work but TCP will not. This would not be 
very useful.

The T210 does not have this issue.

Unfortunately, you will need to use the TOE driver for 2.6.6 kernel.

I apologize for the confusion.

-Scott

Lukas Hejtmanek wrote:
> On Wed, Jun 08, 2005 at 12:11:59PM -0700, Scott Bardone wrote:
> 
>>You would need to use the cxgb-2.1.1 driver (NIC only). It is near the 
>>bottom of the webpage, under "Chelsio N210 / N110 10Gb Ethernet Server 
>>Adapter",  Chelsio N210 / N110 Linux Driver - Version 2.1.1 (05/17/2005).
>><https://service.chelsio.com/drivers/linux/n210/cxgb-2.1.1.tar.gz>
>>Use the above driver for the T110 in NIC mode. This driver will work for 
>>the T110 and T210 but only in NIC mode.
> 
> 
> Unfortunately, this driver does not contain 
> CH_DEVICE(6, 0|1.. )
> 
> Should I just add it?
> 
