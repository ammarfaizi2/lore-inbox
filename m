Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVDFDLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVDFDLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 23:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVDFDLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 23:11:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262093AbVDFDKl (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 23:10:41 -0400
Message-ID: <42535323.8040403@osdl.org>
Date: Tue, 05 Apr 2005 20:10:27 -0700
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
> 
> CPU
> 
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
>>  		i2c-mcf5282.h (new file)
>>  		Kconfig (modified)
>>  		Makefile (modified)

It also includes Kconfig.orig & Makefile.orig &
m528xsim.h.orig .
You should use
   diff -X dontdiff
where dontdiff is a filename to exclude the listed files,
where dontdiff includes *.orig .
There is a fairly up-to-date dontdiff file available at
http://developer.osdl.org/rddunlap/doc/dontdiff-osdl

A diffstat summary would (hereby requested in the future)
would let us see which files are modified and how much
they are modified:

  drivers/i2c/busses/Kconfig            |   10
  drivers/i2c/busses/Kconfig.orig       |  489 
++++++++++++++++++++++++++++++++++
  drivers/i2c/busses/Makefile           |    2
  drivers/i2c/busses/Makefile.orig      |   46 +++
  drivers/i2c/busses/i2c-mcf5282.c      |  407 
++++++++++++++++++++++++++++
  drivers/i2c/busses/i2c-mcf5282.h      |   45 +++
  include/asm-m68knommu/m528xsim.h      |  112 +++++++
  include/asm-m68knommu/m528xsim.h.orig |   45 +++
  8 files changed, 1156 insertions(+)


>>  
>> linux/include/asm-m68knommu
>>  		m528xsim.h (modified)
>>
>> Please let me know if you have any questions.
> 
> 
> The patch was very wordwrapped by your email client.  Please fix that up
> (first email the patch to yourself and test that the result still
> applies OK) or
> resend as an email attachment.

linux_dev/include/asm-m68knommu/m528xsim.h:

some spaces in this expression (& elsewhere) would make it
easier to read:
+#define MCF5282_I2C_I2ADR_ADDR(x) 
(((x)&0x7F)<<0x01)

Oh, it's not even used.... don't need it then.
And this one is not used:
+#define MCF5282_I2C_I2FDR_IC(x)                         (((x)&0x3F))

Lots of the bit-level definitions aren't used and usually aren't
added unless used.

Comment (7) doesn't match name (hm, and it's not used):
+/* Interrupt Control Register 7 */
+#define MCF5282_INTC0_ICR17     (volatile u8 *) (MCF_IPSBAR + 0x0C51)

These are not used -- but if they were, we generally like to
have macro expressions wrapped in parentheses:
+#define MCF5282_QSPI_QMR        MCF_IPSBAR + 0x0340
+#define MCF5282_QSPI_QDLYR      MCF_IPSBAR + 0x0344
+#define MCF5282_QSPI_QWR        MCF_IPSBAR + 0x0348
+#define MCF5282_QSPI_QIR        MCF_IPSBAR + 0x034C
+#define MCF5282_QSPI_QAR        MCF_IPSBAR + 0x0350
+#define MCF5282_QSPI_QDR        MCF_IPSBAR + 0x0354
+#define MCF5282_QSPI_QCR        MCF_IPSBAR + 0x0354

i2c-mcf5282.h:

Please limit line lengths to 80 characters in source files:  e.g.:
+static int mcf5282_i2c_start(const char read_write, const u16 
target_address, const enum I2C_START_TYPE i2c_start);

What is this one for?
+void dumpReg(char *, u16 addr, u8 data);


I'm looking over the primary .c file separately now.

-- 
~Randy
