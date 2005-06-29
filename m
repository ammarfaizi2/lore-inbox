Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVF2Bdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVF2Bdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVF2Bb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:31:29 -0400
Received: from [218.94.38.158] ([218.94.38.158]:61073 "EHLO xianan.com.cn")
	by vger.kernel.org with ESMTP id S261594AbVF2B3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:29:25 -0400
X-AuthUser: chengq@xianan.com.cn
Message-ID: <42C1F91D.4060609@gmail.com>
Date: Wed, 29 Jun 2005 09:27:57 +0800
From: Benbenshi <benbenshi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:Re: route trouble with kernel
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:


>>On Tue, 28 Jun 2005 20:57:04 +0800, cigarette Chan said:
>>  
>>
>  
>
>>>>i add a route to the kernel
>>>>eg: # route add -net XXX.XXX.XXX.XXX/24 gw XXX.XXX.XXX.XXX dev eth1
>>>>
>>>>but after i restart eth1
>>>>
>>>>#ifdown eth1
>>>>#ifup eth1
>>>>
>>>>the route disappear,this make me a lot of troubles.i have several
>>>>interfaces,and i have to
>>>>re-add all of these routes...
>>>>
>>>>Is there any way or patches to make route work like iptables,after i
>>>>restart the interface,
>>>>rules  are still there.
>>>>    
>>>>
>>    
>>
>>
>>Your system should have a way of doing this in a callout during the ifup
>>and ifdown scripts.  Under Fedora, ifup calls ifup-post, which calls
>>/sbin/ifup-local - you could add your routes there.
>>
>>  
>>
>  
>
nerver used Fedora before. On my Debian sarge, ifup will call
/etc/network/interfaces,
which looks like follow:
################################
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
address 192.168.10.200
netmask 255.255.255.0
broadcast 192.168.10.255
network 192.168.10.0
gateway 192.168.10.1
###############################
with this script,ifup know how to add default gateway to the route
table. Is that your mean ?


>>More importantly, routes are different from iptables.  At worst, an iptable
>>rule has a dangling '-i ethX' match that will fail if the interface is down,
>>but that's a harmless because the packet isn't from that interface.
>>
>>On the other hand, what is the kernel supposed to do with a route that
>>points to a down'ed ethX after you've done the ifdown, but before you've
>>done the ifup?  It may as well clear routes to the down'ed interface....
>>  
>>
>  
>
If ethX was down, can kernel just drop the packages to ethX ? Is there
anything wrong with kernel to work like this ?

Thanks for your great reply.


