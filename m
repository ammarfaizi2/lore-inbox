Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315610AbSECJFU>; Fri, 3 May 2002 05:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315612AbSECJFT>; Fri, 3 May 2002 05:05:19 -0400
Received: from www.stpibonline.soft.net ([164.164.128.17]:52691 "EHLO
	cyclops.soft.net") by vger.kernel.org with ESMTP id <S315610AbSECJFR>;
	Fri, 3 May 2002 05:05:17 -0400
Message-ID: <91A7E7FABAF3D511824900B0D0F95D10137057@BHISHMA>
From: Abdij Bhat <Abdij.Bhat@kshema.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-mips-kernel@lists.sourceforge.net'" 
	<linux-mips-kernel@lists.sourceforge.net>
Cc: Abdij Bhat <Abdij.Bhat@kshema.com>,
        Preetesh Parekh <Preetesh.Parekh@kshema.com>
Subject: Custom Driver to Serial Driver Read Interface Problem
Date: Fri, 3 May 2002 14:33:53 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am writing a kernel mode device driver which needs to read and write data
from serial port ( /dev/ttyS1 in this case ).
 The driver is for an embedded system target MIPS running on Linux. However
my problem is both on standard Intel PC running Red Hat Linux (Kernel
2.4-7). So all the further discussion will be for standard Linux PC; since
if i get this to work i should get my embeddded system to work too.

 I have two approaches to accomplish my task.

1. Open /dev/ttyS1 from my Kernel mode Device Driver and then read/write
data.

2. Write my own custom serial port device driver. Disable the standard Linux
serial port device driver and load my custom serial driver.

 Approach 1 seems to be the easier and best suited for my task. And hence i
am working on it.

 I could successfully open the serial port (/dev/ttyS1) from my Kernel mode
Device Driver. I could successfully write data into it too. [ Using kcp.c as
my reference which uses filp_open, FILE_FD->f_op->write Kernel API ].

 However i am facing problem while reading data from the Serial Port using
the same reference API's [ FILE_FD->f_op->read API ].

 This is what i am doing.

 I have a test harnsess [ user mode application ] that opens my kernel mode
driver [ i have tried both blocked and non blocked mode approaches ]. In my
Kernel driver I use the same mode to open the standard serial port (
/dev/ttyS1 ) using filp_open API. 
 The test harness is in a continuous loop to read 4 bytes from my kernel
mode device driver. In my Kernel mode device driver's read routine, i also
read from /dev/ttyS1 using FILE_FD->f_op->read API for the same number of
bytes. But i observe that i am not getting any data from the standard serial
port device driver [/dev/ttyS1]. I get a return value of -512 when i
terminate my user mode test harness (using ctrl c ).

 I am at my wits end as to what the problem might be. Can somebody please
enlighten me on the same. Any help and suggestion regarding the same would
be appreciated greatly.

 Thanks a lot in advance.

Thanks and Regards,
Abdij
