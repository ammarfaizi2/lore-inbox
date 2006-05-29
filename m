Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWE2Kft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWE2Kft (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWE2Kft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 06:35:49 -0400
Received: from smtp2.actcom.co.il ([192.114.47.35]:9344 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S1750822AbWE2Kft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 06:35:49 -0400
Message-ID: <027e01c68313$e8e11440$c400a8c0@Chavalaptop>
From: "Chava Leviatan" <chavale@actcom.net.il>
To: <bidulock@openss7.org>
Cc: <linux-kernel@vger.kernel.org>
References: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop> <20060529021315.B23539@openss7.org> <023201c6830a$827539b0$c400a8c0@Chavalaptop> <20060529035344.A25913@openss7.org>
Subject: Re: Ethernet driver module compilation  (8139too)
Date: Mon, 29 May 2006 13:34:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian ,

Thanks alot ! This exactly the line I was missing at my makefile !
Now it works ...


Chava
----- Original Message ----- 
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: "Chava Leviatan" <chavale@actcom.net.il>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, May 29, 2006 11:53 AM
Subject: Re: Ethernet driver module compilation (8139too)


> Chava,
>
> On Mon, 29 May 2006, Chava Leviatan wrote:
>
>> Hi Brian,
>>
>> I did reboot the machine, and saw that during boot time there is a call 
>> to
>> depmod.
>> I did depmod -ae as you've requested, and here are the results:
>>   [root@NettGain root]# depmod -ae >chav.dat
>> depmod: /lib/modules/2.4.18-3/kernel/drivers/net/makefile.8139 is not an 
>> ELF
>> file
>> depmod: /lib/modules/2.4.18-3/kernel/drivers/net/makefile.eepro is not an
>> ELF file
>> depmod: *** Unresolved symbols in
>> /lib/modules/2.4.18-3/kernel/drivers/net/8139too.o
>> depmod:         __netdev_watchdog_up
>> depmod:         flush_signals
> ...
> ...
>> depmod:         mii_ethtool_gset
> ...
> ...
>>
>> Please note that if I manually insmod mii , then the insmod 8139too 
>> passes
>> w/o problems .
>>
>
> I don't see how it could with all those depmod errors.  Try doing
> this:
>
> grep uregister_netdev /proc/ksyms
>
> If you get something like this:
>
>  c0194ef0 unregister_netdev_Rc45f34ea
>  c01d5270 unregister_netdevice_notifier_Rfe769456
>  c01d6ca0 unregister_netdevice_R52c1d940
>
> then your kernel has versioned symbols.
>
> In which case, you are probably missing
>
> -DMODVERSIONS -include linux/modversions.h
>
> from your compile statement.
>
> Hope that helps.
>
> --brian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

