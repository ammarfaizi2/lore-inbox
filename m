Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbTDGOu6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTDGOu6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:50:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31420 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263474AbTDGOuy (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:50:54 -0400
Date: Mon, 07 Apr 2003 08:02:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 545] New:  usb-storage initialization problem 
Message-ID: <2550000.1049727743@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=545

           Summary:  usb-storage initialization problem
    Kernel Version: 2.5.66
            Status: NEW
          Severity: high
             Owner: greg@kroah.com
         Submitter: gj@pointblue.com.pl


Distribution: Debian woody
Hardware Environment:
lsusb:
Bus 001 Device 003: ID 054c:0032 Sony Corp. MemoryStick MSC-U01 Reader

Software Environment:
nalesnik:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f77,proto,pascal,objc,ada --prefix=/usr
--mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared --with-system-zlib
--enable-nls --without-included-gettext --enable-__cxa_atexit
--enable-clocale=gnu --enable-java-gc=boehm --enable-objc-gc i386-linux
Thread model: posix
gcc version 3.2.3 20030331 (Debian prerelease)

any other information about software required ?

Problem Description:

device (memstick reader) is almost working, it is detected. 
There is trace in logs (below), but i am not able to 
perform scsi-emulated operations on it.


kernel.log snippet:
Apr  6 13:43:42 nalesnik kernel: SCSI subsystem initialized
Apr  6 13:43:43 nalesnik kernel: Initializing USB Mass Storage driver...
Apr  6 13:43:43 nalesnik kernel: usb-storage: act_altsetting is 0
Apr  6 13:43:43 nalesnik kernel: usb-storage: id_index calculated to be: 32
Apr  6 13:43:43 nalesnik kernel: usb-storage: Array length appears to be: 100
Apr  6 13:43:43 nalesnik kernel: usb-storage: Vendor: Sony
Apr  6 13:43:43 nalesnik kernel: usb-storage: Product: Memorystick MSC-U01N
Apr  6 13:43:43 nalesnik kernel: usb-storage: USB Mass Storage device detected
Apr  6 13:43:43 nalesnik kernel: usb-storage: Endpoints: In: 0xc6da8ce0 Out:
0xc6da8cf4 Int: 0xc6da8d08 (Period 255)
Apr  6 13:43:43 nalesnik kernel: usb-storage: Transport: Control/Bulk
Apr  6 13:43:43 nalesnik kernel: usb-storage: Protocol: Uniform Floppy Interface
(UFI)
Apr  6 13:43:43 nalesnik kernel: usb-storage: Allocating usb_ctrlrequest
Apr  6 13:43:43 nalesnik kernel: usb-storage: Allocating URB
Apr  6 13:43:43 nalesnik kernel: usb-storage: Allocating scatter-gather request
block
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Command INQUIRY (6 bytes)
Apr  6 13:43:43 nalesnik kernel: usb-storage:  12 00 00 00 24 00
Apr  6 13:43:43 nalesnik kernel: usb-storage: usb_stor_ctrl_transfer(): rq=00
rqtype=21 value=0000 index=00 len=12
Apr  6 13:43:43 nalesnik kernel: usb-storage: Status code 0; transferred 12/12
Apr  6 13:43:43 nalesnik kernel: usb-storage: -- transfer complete
Apr  6 13:43:43 nalesnik kernel: usb-storage: Call to usb_stor_ctrl_transfer()
returned 0
Apr  6 13:43:43 nalesnik kernel: usb-storage: usb_stor_bulk_transfer_buf(): xfer
36 bytes
Apr  6 13:43:43 nalesnik kernel: usb-storage: Status code 0; transferred 36/36
Apr  6 13:43:43 nalesnik kernel: usb-storage: -- transfer complete
Apr  6 13:43:43 nalesnik kernel: usb-storage: CB data stage result is 0x0
Apr  6 13:43:43 nalesnik kernel: usb-storage: -- CB transport device requiring
auto-sense
Apr  6 13:43:43 nalesnik kernel: usb-storage: ** no auto-sense for a special command
Apr  6 13:43:43 nalesnik kernel: usb-storage: Fixing INQUIRY data to show SCSI
rev 2 - was 0
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x0
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel:   Vendor: Sony      Model: MSC-U01N         
Rev: 1.00
Apr  6 13:43:43 nalesnik kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Faking INQUIRY command for EVPD
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x2
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Faking INQUIRY command for EVPD
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x2
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (1/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (2/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (3/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (4/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (5/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (6/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: usb-storage: queuecommand() called
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread awakened.
Apr  6 13:43:43 nalesnik kernel: usb-storage: Bad target number (7/0)
Apr  6 13:43:43 nalesnik kernel: usb-storage: scsi cmd done, result=0x40000
Apr  6 13:43:43 nalesnik kernel: usb-storage: *** thread sleeping.
Apr  6 13:43:43 nalesnik kernel: WARNING: USB Mass Storage data integrity not
assured
Apr  6 13:43:43 nalesnik kernel: USB Mass Storage device found at 2
Apr  6 13:43:43 nalesnik kernel: drivers/usb/core/usb.c: registered new driver
usb-storage
Apr  6 13:43:43 nalesnik kernel: USB Mass Storage support registered.



Steps to reproduce:
boot kernel on sony vaio picturebook :-)

