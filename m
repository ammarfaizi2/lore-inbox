Return-Path: <linux-kernel-owner+w=401wt.eu-S932288AbWLZExR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWLZExR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 23:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWLZExR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 23:53:17 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:62952 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbWLZExQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 23:53:16 -0500
Message-ID: <4590AAA6.1010106@bx.jp.nec.com>
Date: Tue, 26 Dec 2006 13:52:54 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 0/5] proposal for dynamic configurable netconsole
References: <458BC905.7050003@bx.jp.nec.com> <20061222103615.6e074f4e@localhost.localdomain>
In-Reply-To: <20061222103615.6e074f4e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comments.

>> So, I propose the following extended features for netconsole.
>>
>> 1) support for multiple logging agents.
>> 2) add interface to access each parameter of netconsole
>>    using sysfs.
>>
>> This patch is for linux-2.6.20-rc1-mm1 and is divided to each function.
>> Your comments are very welcome.
> 
> Rather than extending the existing kludge with module parameter, to
> sysfs. I would rather see a better API for this. Please build think
> about doing a better API with a basic set of ioctl's. Some additional

What advantage do we use a set of ioctl's compared to sysfs?
I think that sysfs is easier and more readable than the ioctl's 
to change configurations(IP address and port number and so on).

ex)
# cat /sys/class/misc/netconsole/port1/remote_ip
192.168.0.1
# echo 172.16.0.1 > /sys/class/misc/netconsole/port1/remote_ip
# cat /sys/class/misc/netconsole/port1/remote_ip
172.16.0.1

And the sysfs doesn't need to create access program such as the ioctl's.
If you change configurations related to netconsole through the sysfs interface, 
a simple script file including a set of commands such as above echo 
will help you set up automatically.

> things:
> 	- shouldn't just be IPV4 specific, should handle IPV6 as well

I would like to implement handling IPV6 on demand in the future.

> 	- shouldn't specify MAC address, it can do network discovery/arp to
> 	  find that when adding addresses

I think a userland application would rather find target MAC address and 
change it through the sysfs.

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com




