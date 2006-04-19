Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDSEUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDSEUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 00:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWDSEUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 00:20:49 -0400
Received: from relay4.usu.ru ([194.226.235.39]:490 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750808AbWDSEUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 00:20:48 -0400
Message-ID: <4445BB0F.6010305@ums.usu.ru>
Date: Wed, 19 Apr 2006 10:22:39 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: Linux 2.6.16.7
References: <20060418042300.GA11061@kroah.com> <20060418042345.GB11061@kroah.com> <44448DFF.3080108@ums.usu.ru> <20060418153951.GC30485@kroah.com>
In-Reply-To: <20060418153951.GC30485@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.0.24; VDF: 6.34.0.200; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Apr 18, 2006 at 12:58:07PM +0600, Alexander E. Patrakov wrote:
>   
>> Greg KH wrote:
>>     
>>> -EXTRAVERSION = .6
>>> +EXTRAVERSION = .7
>>>       
>> Hello, I would like to know if there is a plan to include this in the next 
>> -stable update?
>>
>> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=2731570eba5b35a21c311dd587057c39805082f1;hp=dfb62998866ae2e298139164a85ec0757b7f3fc7;hb=9469d458b90bfb9117cbb488cfa645d94c3921b1;f=net/core/dev.c
>>     
>
> No one has submitted it to the stable@kernel.org mail address from what
> I can see, so no, it is not in the queue.  If you think otherwise,
> please send it.
>   
Without that patch, there is a race when registering network interfaces 
and renaming it with udev rules, because initially the "address" in 
sysfs doesn't contain useful data. See 
http://marc.theaimsgroup.com/?t=114460338900002&r=1&w=2

Breaking the recommended way of assigning persistent network interface 
names is, IMHO, a bug serious enough to be fixed in -stable.

Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>

---

--- linux-2.6.16.5/net/core/dev.c
+++ linux-2.6.16.5/net/core/dev.c
@@ -2932,11 +2932,11 @@
 
 		switch(dev->reg_state) {
 		case NETREG_REGISTERING:
+			dev->reg_state = NETREG_REGISTERED;
 			err = netdev_register_sysfs(dev);
 			if (err)
 				printk(KERN_ERR "%s: failed sysfs registration (%d)\n",
 				       dev->name, err);
-			dev->reg_state = NETREG_REGISTERED;
 			break;
 
 		case NETREG_UNREGISTERING:

-- 
Alexander E. Patrakov

