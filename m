Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSJIWam>; Wed, 9 Oct 2002 18:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbSJIWam>; Wed, 9 Oct 2002 18:30:42 -0400
Received: from mail.ipinfusion.com ([65.223.109.2]:10133 "EHLO
	gateway.ipinfusion.com") by vger.kernel.org with ESMTP
	id <S262148AbSJIWal>; Wed, 9 Oct 2002 18:30:41 -0400
Message-ID: <3DA4AEA5.8090105@ipinfusion.com>
Date: Wed, 09 Oct 2002 15:33:09 -0700
From: Vividh Siddha <vividh@ipinfusion.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Interface address change netlink socket problem.(Patch
 attached)
References: <3DA4A3A3.2090408@ipinfusion.com> <20021009.150818.102229501.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you give
ifconfig eth0 10.10.10.50 netmask 0xffffff00 broadcast 10.10.10.255

It first calls devinet_ioctl() with cmd as SIOCSIFADDR. In this we reset 
netmask and broadcast address.

When devinet_ioctl() is called with SIOCSIFBRDADDR, the check for old 
address and new address suceeds as we changed the broadcast 
address(whereas it is unchanged). This then calls inet_del_ifa(delete 
notification) and then inet_insert_ifa(add notification).

Similarly when devinet_ioctl() is called with SIOCSIFNETMASK.

I tested this with the netlink socket with the patch applied and it 
works as expected.

Thanks,
vividh

David S. Miller wrote:
> Can you explain how not initializing some fields of the 'ifa'
> prevents the extra netlink messages?  I don't understand how
> your patch works.
> 
> 


