Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTEOT32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTEOT32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:29:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:8376 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264202AbTEOT3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:29:25 -0400
Date: Thu, 15 May 2003 10:28:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 724] New: USB Storage oops
Message-ID: <247920000.1053019688@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


           Summary: USB Storage oops
    Kernel Version: 2.5.69-bk8
            Status: NEW
          Severity: high
             Owner: andmike@us.ibm.com
         Submitter: florin@iucha.net


Distribution: Debian Testing/Unstable
Hardware Environment: K7
Software Environment:
Problem Description:
Attempting to mount a CF card in a SanDisk USB 2.0 adapter results in the
following oops:
SCSI device sda: 31232 512-byte hdwr sectors (16 MB)                             
sda: Write Protect is off                                                        
sda: Mode Sense: 02 00 00 00                                                     
drivers/usb/core/message.c: usb_control/bulk_msg: timeout                        
drivers/usb/core/message.c: usb_control/bulk_msg: timeout                        
drivers/usb/core/hub.c: USB device not accepting new address (error=-22)         
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun
+0                                                                               
usb 5-2: USB disconnect, address 2                                               
Unable to handle kernel paging request at virtual address 544150a8               
 printing eip:                                                                   
c02abc39                                                                         
*pde = 00000000                                                                  
Oops: 0000 [#1]                                                                  
CPU:    0                                                                        
EIP:    0060:[<c02abc39>]    Not tainted                                         
EFLAGS: 00010286                                                                 
EIP is at scsi_eh_finish_cmd+0x19/0x60                                           
eax: ef19d000   ebx: eef28080   ecx: eef22140   edx: 54415056                    
esi: eef21fa8   edi: eef21fb0   ebp: eef21fa8   esp: eef21f60                    
ds: 007b   es: 007b   ss: 0068                                                   
Process scsi_eh_1 (pid: 118, threadinfo=eef20000 task=eef23340)                  
Stack: eef28080 eef28080 eef21fb0 c02ac418 eef28080 eef21fa8 00000000 00000000   
       00000000 ef62f428 eef20000 00000282 eef21fa8 c02ac8d6 eef21fb0 eef21fa8   
       eef21fa8 eef21fb0 eef21fa8 eef21fa8 eef28098 eef28098 ef62f400 eef21fd4   
Call Trace:                                                                      
 [<c02ac418>] scsi_eh_offline_sdevs+0x68/0x80                                    
 [<c02ac8d6>] scsi_unjam_host+0xc6/0xd0                                          
 [<c02ac9b1>] scsi_error_handler+0xd1/0x120                                      
 [<c02ac8e0>] scsi_error_handler+0x0/0x120                                       
 [<c0108abd>] kernel_thread_helper+0x5/0x18                                      
                                                                                 
Code: 0f b7 42 52 48 66 89 42 52 c7 43 24 00 00 00 00 66 c7 43 08                

mount process is stuck in D state

bear:~# lsusb
Bus 005 Device 002: ID 0781:9191 SanDisk Corp.
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 002: ID 0451:2046 Texas Instruments, Inc. TUSB2046 Hub
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 004: ID 045e:001e Microsoft Corp. IntelliMouse Explorer
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000


Steps to reproduce:
Try to mount a card.

