Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVCBBYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVCBBYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 20:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVCBBYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 20:24:11 -0500
Received: from bay14-f39.bay14.hotmail.com ([64.4.49.39]:8763 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261963AbVCBBYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 20:24:02 -0500
Message-ID: <BAY14-F39A87ACAF59B6DF53A9CBE955A0@phx.gbl>
X-Originating-IP: [80.15.132.11]
X-Originating-Email: [tonyosborne_a@hotmail.com]
From: "tony osborne" <tonyosborne_a@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Trap number: how a system software recognise it?
Date: Wed, 02 Mar 2005 01:23:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 02 Mar 2005 01:24:00.0603 (UTC) FILETIME=[835A7AB0:01C51EC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wish to be personally CC'ed the answers/comments posted to the list in 
response to this post

I have done some reading about system calls and memory management but some 
issues are not yet that clear for me, so I hope some of you will assist 
me...


PART1
----------
Assume within a C user program there is a read (fid, buf, nbytes) procedure 
call. According to Tanenbaum book, this will call a C-system read function 
or what is known as C-stub function read_stb.
read_stb includes some initial instructions and in particularly a trap 
number to make a system call to the Kernel. This number will be used to 
index the trap vector or table stored in the kernel in order to retrieve the 
address of the trap handler routine which performs the read operation.

My question is how the read_stb knew about the trap number used by the 
kernel to perform read operation from the device?
Although my question refers to c library, my question holds for other system 
softwares that might perform the same operation.

Does the reading operation from a disk have a fix trap number? What about 
other I/O peripherals (scanner, webcam, digital camera, printer)

For the above peripherals, we need generally to install a device driver. If 
we take the scanner as an example and say the user wants to zoom out a 
scanned section. This operation is associated with some initial instructions 
and a system call through a trap number call. This trap number will be used 
to point to the relevant device driver routine as explained above.

Will this variable get assigned a value during the installation of 
peripheral device drivers?

We know that each device has its interface commands that the kernel can 
call. Each procedure will be stored at a particular location in the kernel 
memory. Once saved, I presume that the OS updates its trap table and 
allocate a trap number to each device procedure. Is that right?

What about the devices which are recognised without installing device 
drivers, have they a fixed location and trap numbers? Is this documented for 
  whoever want to write a device driver?


PART 2
----------
The main CPU initiates the I/O operation by instructing the device 
controller with a high level commands (writing to the device registers and 
so on). Such high level commands are then translated to lower instruction by 
the device controller. Then it is up to the device processor to take these 
commands and branch to the relevant device driver code at the kernel space 
to perform the low level instructions. Upon completion an interrupt will be 
sent to the CPU to flag (hopefully) the completion of the task.

So could we deduce that the device processor have *full* access to the 
kernel memory (fill privileges)?

If we take as an example: reading a block of data from a stored file. Each 
file is associated with a File Control Block that contains the file’s 
metatdata, i.e. among others the description of file organisation.

Will the command sent by the CPU to the disk controller (after inspecting 
the file FCB) be similar to RETRIEVE BLOCK X. and this will be translated by 
the device controller to cylinder C, PLATTER P, SECTOR S?

What about if the OS wants to retrieve more block. Will just be written into 
the device controller memory?


Many thanks

_________________________________________________________________
It's fast, it's easy and it's free. Get MSN Messenger today! 
http://www.msn.co.uk/messenger

