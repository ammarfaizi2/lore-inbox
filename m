Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267750AbUG3R2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267750AbUG3R2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267762AbUG3R2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:28:21 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:41450 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267754AbUG3R15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:27:57 -0400
Message-ID: <410A8588.6020208@colorfullife.com>
Date: Fri, 30 Jul 2004 19:29:44 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
References: <20040730100421.GB8175@redhat.com> <410A4A1C.4040608@colorfullife.com> <20040730162023.GD8175@redhat.com> <410A7CBF.2020708@colorfullife.com> <20040730171606.GE8175@redhat.com>
In-Reply-To: <20040730171606.GE8175@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:

>On Fri, Jul 30, 2004 at 06:52:15PM +0200, Manfred Spraul wrote:
>
>  
>
>>The log is very odd - why are there two lines with
>>
>>    
>>
>>>forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
>>>      
>>>
>>Did you rmmod/insmod the driver twice?
>>    
>>
>
>I think it's just the way that ifup works.  I'm not entirely sure why
>the line appears twice.
>
>  
>
>>Could you manually insmod the driver, wait for two seconds and then call 
>>ifup?
>>    
>>
>
>Aha.  That works fine.
>
>So here is how to make it fail:
>
>/sbin/modprobe forcedeth; \
>/sbin/ip link set dev eth0 up
>
>All subsequent runs of 'ethtool eth0' show:
>
>Settings for eth0:
>        Supports Wake-on: g
>        Wake-on: d
>        Link detected: no
>
>regardless of how long I leave it.
>
>So is this a driver problem or a problem with the way /sbin/ifup
>works?
>
>  
>
Driver problem.
The driver assumes that the nic generates an NVREG_IRQ_LINK interrupt 
with NvRegMIIStatus & NVREG_MIISTAT_LINKCHANGE on a link change. It 
seems your nic doesn't generate that.

Could you try modprobe forcedeth;sleep 5;ip link set dev eth0 up. Then 
pull out the network cable and check if the driver noticed that with 
ethtool. Plug in back in and check again. With dprintk enabled. Then 
send me the kernel log and the ethtool output.

And add the lspci -vxx -s 00:05.0. Probably I'll make the timer 
dependant on nForce 1-3 and exclude the nForce 3 Gb nics: they don't 
need it.

--
    Manfred
