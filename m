Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbRA3RYS>; Tue, 30 Jan 2001 12:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRA3RYJ>; Tue, 30 Jan 2001 12:24:09 -0500
Received: from columba.EUR.3Com.COM ([161.71.169.13]:57553 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S130761AbRA3RX1>; Tue, 30 Jan 2001 12:23:27 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: David Rees <dbr@spoke.nols.com>, newsreader@mediaone.net
cc: linux-kernel@vger.kernel.org
Message-ID: <802569E4.005F6E19.00@notesmta.eur.3com.com>
Date: Tue, 30 Jan 2001 17:22:05 +0000
Subject: Re: klogd is acting strange with 2.4
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Before 2.2.18.  Now I've tested with both
>> 2.4.1-pre12 and 2.4.1.  2.4 kernel klogd is
>> always using 99% cpu.  What gives?
>>

> Can you try 2.4.0?  Are you using the 3c59x ethernet driver?  I've got the
> same problem on one of my machines, (see message with subject "2.4.1-pre10
> -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK") and the last thing that is logged
> s a message from the 3c59x ethernet driver.

I've seen someone else report that this occurs when klogd reads a NULL
character. In his case the line in the 3c59x.c driver which prints out the
'product code' was responsible for this.

In the 2.4.1 patch this printk has been added to 3c59x.c:-

+    printk(KERN_INFO "  product code '%c%c' rev %02x.%d date %02d-"
+            "%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
+            step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);

Could you try commenting out these lines and see if it fixes the problem?

     Jon


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
