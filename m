Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVDFDoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVDFDoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 23:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVDFDoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 23:44:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:34946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262096AbVDFDn5 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 23:43:57 -0400
Message-ID: <42535AF1.5080008@osdl.org>
Date: Tue, 05 Apr 2005 20:43:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Derek Cheung <derek.cheung@sympatico.ca>
CC: "'Andrew Morton'" <akpm@osdl.org>, greg@kroah.com,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
References: <003901c53a51$0093b7d0$1501a8c0@Mainframe>
In-Reply-To: <003901c53a51$0093b7d0$1501a8c0@Mainframe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Cheung wrote:
> 
>> Below please find the patch file I "diff" against Linux 2.6.11.6. It
>> contains the I2C adaptor for ColdFire 5282 CPU. Since most ColdFire
> CPU
>> shares the same I2C register set, the code can be easily adopted for
>> other ColdFire CPUs for I2C operations.
>>
>> I have tested the code on a ColdFire 5282Lite CPU board
>> (http://www.axman.com/Pages/cml-5282LITE.html) running uClinux 2.6.9
>> with LM75 and DS1621 temperature sensor chips. As advised by David
>> McCullough, the code will be incorporated in the next uClinux
> release.
> 
>> The patch contains:
>>
>> linux/drivers/i2c/busses
>>  		i2c-mcf5282.c (new file)

Limit source code lines to 80 characters (including comment lines).

+static int mcf5282_read_data():

+	if (ackType == NACK)
+		*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_TXAK;     // generate NA
+	else
+                *MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_TXAK;    // 
generate ACK

The 2 assignments above should begin in the same column.
Also, kernel comment style is C /* ... */, not C++ (or C99) // style.

+        if (timeout <= 0)
+                printk("%s - I2C IIF never set. Timeout is %d \n", 
__FUNCTION__, timeout);

All printk() calls should have a KERN_WARNING or KERN_ERR or
KERN_DEBUG level used in it...

+	if (timeout <= 0 )

No space before the closing ')'.

+static int mcf5282_write_data():

+        if (timeout <=0)
should be (add a space)
+        if (timeout <= 0)

+	if (timeout <= 0 )
Drop space before ')'

Drop the debugging printk's and DEREK_DEBUG blocks.

+        switch (size) {
+                case I2C_SMBUS_QUICK:
We usually don't indent the 'case' line to save one indent level.
It helps when using 8-space tabs.

+			// this is not yet ready!!!
Put blocks like this inside
#if 0
or
#if NOT_READY_YET
#endif
blocks.

+static u32 mcf5282_func(struct i2c_adapter *adapter)
+{
+	return(I2C_FUNC_SMBUS_QUICK |
+	       I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_PROC_CALL |
+	       I2C_FUNC_SMBUS_BYTE_DATA |
+	       I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA);
+};
Don't use parens on return statements.


+static int __init i2c_mcf5282_init():
is not driver registration needed?  I don't know the I2C
subsystem, so maybe not...



Big Question:  does most Coldfire or I2C use volatile so heavily,
or is it just this one driver that does that?  Volatile here
semms very overused.


-- 
~Randy
