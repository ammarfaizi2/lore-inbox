Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVEFQfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEFQfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFQfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 12:35:15 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:22535 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261186AbVEFQem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 12:34:42 -0400
Message-ID: <427B9DDB.7030307@shadowconnect.com>
Date: Fri, 06 May 2005 18:39:55 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: best practise for ioremap / ioremap_nocache / MTRR
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all some background information to the hardware itself.

In my special case (the I2O driver see also drivers/message/i2o/* for 
further information) the hardware uses a memory mapped I/O region of 
around 128kb. This memory region contains 3 control ports which IMHO 
don't make send to be cached.

The remaining memory is divided into 512 byte sized message frames. The 
driver have to request one of the 512 byte message frames by reading on 
one of the control ports, and gets back an address of the message frame 
which he could use to write data into it. After finishing the address of 
the message frame must be written back to the control register.

At the moment the driver writes each 32-bit word directly into the I/O 
memory region.


My questions now are:

1) does the ioremap() have any advantage over ioremap_nocache() in this 
case, because the memory is only written once, and not read by the driver 
again?

2) does it make sense to prepare the message in kernel using a mempool, 
and then copy over to the I/O memory at once using memcpy_toio instead of 
writing each 32-bit word directly to the I/O memory?

3) at the moment MTRR is used for the messages (but not for the control 
registers), does this have an advantage because each 32-bit word is 
written separately? Or is it better to not use MTRR, and use the approach 
described in 2)?

Any advice would be appreciated! Thank you very much in advance!



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
