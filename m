Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbQLHKDx>; Fri, 8 Dec 2000 05:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQLHKDd>; Fri, 8 Dec 2000 05:03:33 -0500
Received: from 194.38.82.urbanet.ch ([194.38.82.193]:54027 "EHLO
	internet.dapsys.com") by vger.kernel.org with ESMTP
	id <S129631AbQLHKD3> convert rfc822-to-8bit; Fri, 8 Dec 2000 05:03:29 -0500
From: Edouard Soriano <e_soriano@dapsys.com>
Date: Fri, 08 Dec 2000 10:31:33 GMT
Message-ID: <20001208.10313300@dap20.dapsys.com>
Subject: ASUS CUR-DLS LSI SYM53C896 SCSI driver
To: linux-kernel@vger.kernel.org
CC: e_soriano@dapsys.com
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

Configuring a new box based on ASUS CUR-DLS dual Pentium III, 1GB RAM and 
using
the new LSI SYM53C896 SCSI interface.

Question:  How to get sym53c8xx and eepro100 activated at start-up 
procedure ?

Thanks for your help.
e_soriano@dapsys.com

Description:

Version used is Linux 2.2.17 dowloaded from kernel.org with Redhat 6.1 
(2.2.12-20)

Step 1
When configuring this system from scratch using the RedHat 6.1 CD-ROM the 
system
reconize both the integrated interfaces LSI as well as the Intel 82559 
Ethernet controller.

Fine.

Problem is that Linux version has no updated drivers for the high speed 
LSI controller (160 Mbs)

So I downloaded 2.2.17 from kernel.org and sy1.6b-2.2.17.tar.gz from 
ftp.lsil.com.HostAdapterDrivers/linux/c8xx-driver

Compiled and intalled.

conf.modules:
depfile=/lib/modules/`uname -r`/modules.dep
alias scsi_hostadapter BusLogic
alias scsi_hostadapter1 sym53c8xx
alias scsi_hostadapter2 sym53c8xx
alias eth0 eepro100

lilo.conf:
boot=/dev/sda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
default=linux
image=/boot/vmlinuz-2.2.17smp
        label=linux
        initrd=/boot/initrd-2.2.17smp.img
        read-only
        root=/dev/sda1
image=/boot/vmlinuz-2.2.12-20smp
        label=linux-sv
        initrd=/boot/initrd-2.2.12-20smp.img
        read-only
        root=/dev/sda1
image=/boot/vmlinuz-2.2.12-20
        label=linux-up
        initrd=/boot/initrd-2.2.12-20.img
        read-only
        root=/dev/sda1


Problem: both controllers LSI and Intel are not recognized during 
startup.

So, once the system started, I need to enter:

insmod sym53c8xx  with the following good results:
Dec  7 21:10:09 localhost kernel: sym53c1010-1: Symbios format NVRAM, ID 
7, Fast-80, Parity Checking
Dec  7 21:10:09 localhost kernel: sym53c1010-1: initial 
SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 00/4e/a0/01/00/04
Dec  7 21:10:09 localhost kernel: sym53c1010-1: final   
SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 00/4e/80/00/08/04
Dec  7 21:10:09 localhost kernel: sym53c1010-1: on-chip RAM at 0xf7000000
Dec  7 21:10:09 localhost kernel: sym53c1010-1: resetting, command 
processing suspended for 2 seconds
Dec  7 21:10:09 localhost kernel: sym53c1010-1: restart (scsi reset).
Dec  7 21:10:09 localhost kernel: sym53c1010-1: enabling clock multiplier
Dec  7 21:10:09 localhost kernel: sym53c1010-1: handling phase mismatch 
from SCRIPTS.
Dec  7 21:10:09 localhost kernel: sym53c1010-1: Downloading SCSI SCRIPTS.
Dec  7 21:10:09 localhost kernel: scsi1 : sym53c8xx - version 1.6b
Dec  7 21:10:09 localhost kernel: scsi2 : sym53c8xx - version 1.6b
Dec  7 21:10:09 localhost kernel: scsi : 3 hosts.
Dec  7 21:10:11 localhost kernel: sym53c1010-0: command processing 
resumed
Dec  7 21:10:11 localhost kernel:   Vendor: IBM       Model: DCAS-34330W  
     Rev: S65A
Dec  7 21:10:11 localhost kernel:   Type:   Direct-Access                 
     ANSI SCSI revision: 02
Dec  7 21:10:11 localhost kernel: Detected scsi disk sdb at scsi1, 
channel 0, id 0, lun 0
Dec  7 21:10:11 localhost kernel:   Vendor: QUANTUM   Model: VIKING 4.5 
WSE    Rev: 8808
Dec  7 21:10:11 localhost kernel:   Type:   Direct-Access                 
     ANSI SCSI revision: 02
Dec  7 21:10:11 localhost kernel: Detected scsi disk sdc at scsi1, 
channel 0, id 1, lun 0
Dec  7 21:10:11 localhost kernel: sym53c1010-1: command processing 
resumed
Dec  7 21:10:19 localhost kernel: sym53c1010-0-<0,0>: tagged command 
queue depth set to 4
Dec  7 21:10:19 localhost kernel: sym53c1010-0-<1,0>: tagged command 
queue depth set to 4
Dec  7 21:10:28 localhost kernel: sym53c1010-0-<0,*>: FAST-20 SCSI 20.0 
MB/s (50 ns, offset 15)
Dec  7 21:10:28 localhost kernel: SCSI device sdb: hdwr sector= 512 
bytes. Sectors= 8467200 [4134 MB] [4.1 GB]
Dec  7 21:10:28 localhost kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 
sdb9 >
Dec  7 21:10:28 localhost kernel: sym53c1010-0-<1,*>: FAST-20 SCSI 20.0 
MB/s (50 ns, offset 30)
Dec  7 21:10:28 localhost kernel: SCSI device sdc: hdwr sector= 512 
bytes. Sectors= 8899737 [4345 MB] [4.3 GB]
Dec  7 21:10:28 localhost kernel:  sdc: sdc1
Dec  7 21:11:22 localhost kernel: SCSI device sdb: hdwr sector= 512 
bytes. Sectors= 8467200 [4134 MB] [4.1 GB]
Dec  7 21:11:22 localhost kernel:  sdb: sdb1
Dec  7 21:11:24 localhost kernel: SCSI device sdb: hdwr sector= 512 
bytes. Sectors= 8467200 [4134 MB] [4.1 GB]
Dec  7 21:11:24 localhost kernel:  sdb: sdb1

Same schema with Intel Ethernet controller:
insmod eepro100 with the following good results:
Dec  8 11:15:27 localhost kernel: eepro100.c:v1.09j-t 9/29/99 Donald 
Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Dec  8 11:15:27 localhost kernel: eepro100.c: $Revision: 1.20.2.10 $ 
2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Dec  8 11:15:27 localhost kernel: eth0: OEM i82557/i82558 10/100 
Ethernet, 00:E0:18:02:7D:CA, I/O at 0xd800, IRQ 20.
Dec  8 11:15:27 localhost kernel:   Board assembly 668081-002, Physical 
connectors present: RJ45
Dec  8 11:15:27 localhost kernel:   Primary interface chip i82555 PHY #1.
Dec  8 11:15:27 localhost kernel:   General self-test: passed.
Dec  8 11:15:27 localhost kernel:   Serial sub-system self-test: passed.
Dec  8 11:15:27 localhost kernel:   Internal registers self-test: passed.
Dec  8 11:15:27 localhost kernel:   ROM checksum self-test: passed 
(0x04f4518b). 
Dec  8 11:15:27 localhost kernel:   Receiver lock-up workaround 
activated.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
