Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbRA3VR7>; Tue, 30 Jan 2001 16:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbRA3VRt>; Tue, 30 Jan 2001 16:17:49 -0500
Received: from postoffice.mediax.com ([207.111.215.67]:11015 "EHLO
	postoffice.mediax.com") by vger.kernel.org with ESMTP
	id <S130767AbRA3VRg>; Tue, 30 Jan 2001 16:17:36 -0500
Message-ID: <3A772F4E.4040506@mediax.com>
Date: Tue, 30 Jan 2001 13:17:02 -0800
From: Martin <martin@mediax.com>
Reply-To: martin@mediax.com
Organization: MediaX Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; m18) Gecko/20001010
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Bug in drivers/char/mem.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Bug in drivers/char/mem.c
[2.] An if statement (#if !defined) has apparently been left out of 
drivers/char/mem.c. This breaks the build on the m68k architecture.
[3.] Kernel 2.4.1
[4.] Oops: Not applicable
[6.] Try building a kernel on m68k.
[7.] Env: not applicable.
[7.1.] Software (add the output of the ver_linux script here)
Linux quadra 2.2.10 #13 Sat Feb 5 15:56:35 CET 2000 m68k unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded        

[7.2.] Processor information (from /proc/cpuinfo):
drink@quadra:/home/src/linux/drivers/char$ cat /proc/cpuinfo
CPU:            68040
MMU:            68040
FPU:            68040
Clocking:       33.1MHz
BogoMips:       22.11
Calibration:    11059200 loops

[7.3.] Module information (from /proc/modules):
none

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
none

[7.5.] PCI information ('lspci -vvv' as root)
nubus

[7.6.] SCSI information (from /proc/scsi/scsi)
drink@quadra:/home/src/linux/drivers/char$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST11200N         Rev: 8334
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
The error is at line 598. The code normally looks like so:
       {3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
       {4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},
       {5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},

I changed it to look like this instead:

       {3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
#if !defined(__mc68000__)
       {4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},
#endif
       {5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},

This is probably not the right way to fix this. However, it was the only 
way at my immediate disposal with my limited coding skill[sz]. If 
someone has a better solution, please apply it.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
