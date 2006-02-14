Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422827AbWBNVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422827AbWBNVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422828AbWBNVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:52:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:47041 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422827AbWBNVw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:52:58 -0500
Message-ID: <43F25138.9090503@am-anger-1.de>
Date: Tue, 14 Feb 2006 22:52:56 +0100
From: Heiko Gerstung <heiko@am-anger-1.de>
User-Agent: Mail/News 1.5 (X11/20060120)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bonding mode 1 works as designed. Or not?
References: <43F24DBA.7090602@am-anger-1.de> <20060214214746.GK11380@w.ods.org>
In-Reply-To: <20060214214746.GK11380@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:25672344472c4ac2bbe53bd9833f99fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Willy Tarreau wrote:
>> [...]eth0 and eth1 are in a bonding group, mode=1, miimon=100 ... eth0 is the
>> active slave and used as long as the physical link is available (checked
>> by using MII monitoring), at the same time eth1 is totally passive,
>> neither passing any received packets to the kernel nor sending packets,
>> if the kernel wants it to do so. As soon as the eth0 link status changes
>> to "down", eth1 is activated and used, and now eth0 remains silent and
>> deaf until it becomes the active slave again.
>>
>> Any comments on that? Is the documentation wrong OR is there a bug in
>> the implementation of the bonding module?
>>     
>
> Neither, it's your understanding described above :-)
> In fact, the bonding is used to select an OUTPUT device. If some trafic
> manages to enter through the backup interface, it will reach the kernel.
> It can be useful to implement some link health-checks for instance. However,
> the only packets that you should receive are multicast and broadcast packets,
> so this should be very limited anyway by design. After several years using
> it, it has not caused me any trouble, including in environments involving
> multicast for VRRP.
>
>   
Unfortunately the ping replies come in on both interfaces, as well as 
any other traffic (like ssh or web traffic). Everything works but the 
load of the system caused by network traffic is nearly doubled this way 
and may cause confusion in a number of applications. 

Would there be a way to stop the non-active slave(s) from "listening", 
i.e. drop all traffic received by them? If yes, where could I do that?
> Regards,
> willy
>
>   
Thank you for your reply,
kind regards,
Heiko

