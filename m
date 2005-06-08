Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVFHCNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVFHCNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVFHCNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:13:42 -0400
Received: from stargate.chelsio.com ([64.186.171.138]:44313 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S262068AbVFHCNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:13:35 -0400
Message-ID: <42A655C2.3030406@chelsio.com>
Date: Tue, 07 Jun 2005 19:19:46 -0700
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz> <20050607200820.GA25546@electric-eye.fr.zoreil.com> <20050607211048.GO2369@mail.muni.cz>
In-Reply-To: <20050607211048.GO2369@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2005 02:11:59.0682 (UTC) FILETIME=[73E69220:01C56BCF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

It looks like you have a T110 card (10Gb TOE) by the device ID 0006.
The Chelsio driver which is in the 2.6 mm tree only supports the NIC model cards 
(N110 & N210).

We currently don't have the TOE API in the Linux kernel so the TOE functionality 
does not exist, therefore you can only use the Chelsio modified 2.6.6 kernel for 
TOE.

You will need to download the driver from Chelsio's website for the T110. Please 
send me an email if you don't have a login.

Thanks,
Scott Bardone
Chelsio Communications
http://www.chelsio.com

Lukas Hejtmanek wrote:
> On Tue, Jun 07, 2005 at 10:08:20PM +0200, Francois Romieu wrote:
> 
>>-> it does not match your 0006 revision. No wonder nothing gets detected.
>>
>>As a quick hack, one could cross fingers and add a
>>CH_DEVICE(6, 0, CH_BRD_N110_1F)
>>
>>or, if it does not work:
>>
>>CH_DEVICE(6, 1, CH_BRD_N210_1F)
> 
> 
> I added:
> 
> enum {
>         CH_BRD_T110_1F,
>         CH_BRD_N110_1F,
>         CH_BRD_N210_1F,
>         CH_BRD_T210_1F,
> };
> 
> struct pci_device_id t1_pci_tbl[] = {
>         CH_DEVICE(6, 0, CH_BRD_T110_1F),
>         CH_DEVICE(6, 1, CH_BRD_T110_1F),
>         CH_DEVICE(7, 0, CH_BRD_N110_1F),
>         CH_DEVICE(10, 1, CH_BRD_N210_1F),
>         { 0, }
> };
> 
> according to 2.6.6 driver. 
> 
> However, it seems to be highly unstable. Using iperf it gets broken. Card 
> receives packets but it does not transmit after some iperf tests.
> 
> Using tcpdump I see things like this:
> tcpdump -ni eth0
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
> 23:05:03.854587 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 1
> 23:05:04.853853 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 2
> 23:05:05.853965 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 3
> 23:05:06.854079 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 4
> 23:05:07.854193 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 5
>  
> 
> 
>>If it does not work at all, someone will have to dissect the whole
>>thing. Please fill an entry at bugzilla.kernel.org, add it your lspci info
>>and make it link the 2.6.6 driver from Chelsio's website.
> 
> 
> Should I still add an bugzilla entry? Unfortunately, 2.6.6. driver from website
> is accessible only through password.
> 
