Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271660AbTGRAcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271661AbTGRAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:32:19 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:42749 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S271660AbTGRAcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:32:16 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D55213@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.72 insmod question, more info.
Date: Thu, 17 Jul 2003 18:47:08 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing I noticed is the query_module have different arguments in 2.4.20-8 nand 2.5.72.  

For the working insmod under 2.4.20-8, it has NULL pointer for buffer amd /* 8 entries */ for module, like following:
 
query_module(NULL, 0, NULL, 0)          = 0
query_module(NULL, QM_MODULES, { /* 8 entries */ }, 8) = 0
query_module("autofs", QM_INFO, {address=0xd08d8000, size=13684, flags=MOD_RUNNING|MOD_AUTOCLEAN, usecount=0}, 16) = 0
brk(0)                                  = 0x807d000
brk(0x807e000)                          = 0x807e000
query_module("autofs", QM_SYMBOLS, { /* 21 entries */ }, 21) = 0
query_module("e100", QM_INFO, {address=0xd08c5000, size=62340, flags=MOD_RUNNING|MOD_VISITED|MOD_USED_ONCE, usecount=0}, 16) = 0
query_module("e100", QM_SYMBOLS, 0x807d178, 1024, 1919) = -1 ENOSPC (No space left on device)
query_module("e100", QM_SYMBOLS, { /* 67 entries */ }, 67) = 0 

However, on same system but booted with 2.5.72 bzImage, it has the following,

query_module(NULL, 0, 0, 0, 134725736)  = -1 ENOSYS (Function not implemented)
query_module(NULL, QM_MODULES, 0x807cd38, 256, 1108208563) = -1 ENOSYS (Function not implemented)
write(2, "insmod: ", 8insmod: )                 = 8
write(2, "QM_MODULES: Function not impleme"..., 37QM_MODULES: Function not implemented) = 37
write(2, "\n", 1)                       = 1
flock(3, LOCK_UN)                       = 0
close(3)                                = 0
chdir("/var/log/ksymoops")              = -1 ENOENT (No such file or directory)
exit_group(1)                           = ?

Thanks!

Eddie

 

> -----Original Message-----
> From: WANG,YIDING (A-SanJose,ex1) 
> Sent: Thursday, July 17, 2003 5:36 PM
> To: linux-kernel@vger. kernel. org (E-mail)
> Subject: 2.5.72 insmod question
> 
> 
> I completed a fibre channel driver change to support for 
> 2.5.72 (suppose to be 2.6 compatible) and compiled it OK.  
> When trying load the driver with "insmod", it complains with 
> the message "insmod: QM_MODULES: Function not implemented".
> 
> I tried kernel built module qla1280.o and got the same 
> result.  It seems the insmod utility in my system is not 
> compatible with new 2.5.72 built module.
> 
> I have 2.4.20-8 kernel installed first and driver loads and 
> runs fine.  Later added 2.5.72 kernel and booted with its 
> bzImage works fine too.  However, the insmod utility I am 
> using to load new driver was from 2.4.20-8 which has 
> system_query_module() being called.  I checked Doc. and 
> source code for 2.5.72 and could not find same function call 
> in module.c
> 
> Some web documents mentioned that the module installation is 
> changed from 2.4.x to 2.5.x.  So far I am still looking for 
> the solution and hope someone can help me on the issue.
> 
> I am compiling the driver out side of kernel source tree but 
> using kernel environmental variables for compatibility.
> 
> Regards,
> 
> Eddie
> 
>  
> 
> 
