Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265623AbRFWElx>; Sat, 23 Jun 2001 00:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265622AbRFWEln>; Sat, 23 Jun 2001 00:41:43 -0400
Received: from james.kalifornia.com ([208.179.59.2]:39774 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265623AbRFWEl3>; Sat, 23 Jun 2001 00:41:29 -0400
Message-ID: <3B341DF2.9010904@blue-labs.org>
Date: Fri, 22 Jun 2001 21:41:22 -0700
From: David Ford <david@blue-labs.org>
Organization: Blue Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <200106230307.f5N370U83109@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the output of a plain jane 2.4.5 compile with the 'new' adaptec 
compiled in:

Linux version 2.4.5 (root@James) (gcc version 2.95.3 20010315 (release)) 
#3 Fri
Jun 22 21:23:04 PDT 2001
...
Kernel command line: BOOT_IMAGE=test ro root=801 BOOT_FILE=/boot/test 
aic7xxx=verbose nmi_watchdog=1 console=ttyS0,38400 console=tty0 
serial=0,38400n8
...
ahc_pci:0:12:0: Reading SEEPROM...done.
ahc_pci:0:12:0: Manual LVD Termination
ahc_pci:0:12:0: BIOS eeprom not present
ahc_pci:0:12:0: Secondary High byte termination Enabled
ahc_pci:0:12:0: Primary Low Byte termination Enabled
ahc_pci:0:12:0: Primary High Byte termination Enabled
ahc_pci:0:12:0: Downloading Sequencer Program... 416 instructions downloaded
PCI: Found IRQ 10 for device 00:0c.1
PCI: The same IRQ used for device 00:0c.0
ahc_pci:0:12:1: Reading SEEPROM...done.
ahc_pci:0:12:1: Manual LVD Termination
ahc_pci:0:12:1: BIOS eeprom not present
ahc_pci:0:12:1: Secondary High byte termination Enabled
ahc_pci:0:12:1: Primary Low Byte termination Enabled
ahc_pci:0:12:1: Primary High Byte termination Enabled
ahc_pci:0:12:1: Downloading Sequencer Program... 416 instructions downloaded
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

Now it breaks

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
SCSISEQ = 0x12, SBLKCTL = 0x6
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x108, 0x15f, 0x0
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 
19 20 21 22 23 24 25 26 27 28 29 30 31
Pending list:
Kernel Free SCB list: 3 1 0
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Sending PPR bus_width 1, period c, offset 7f, ppr_options 0
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x168
SCSISEQ = 0x12, SBLKCTL = 0x6
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0xa0, SCSISIGI = 0xb6, SXFRCTL0 = 0x88
SSTAT0 = 0x2, SSTAT1 = 0x3
STACK == 0x175, 0x15f, 0x0, 0xe7
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 
20 21 22 23 24 25 26 27 28 29 30 31
Pending list: 2
Kernel Free SCB list: 1 0
Untagged Q(0): 2
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0: SCSI bus reset delivered. 1 SCBs aborted.
scsi0:0:0:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x45
SCSISEQ = 0x12, SBLKCTL = 0x6
DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0xa0, SCSISIGI = 0x0, SXFRCTL0 = 0x88
SSTAT0 = 0x0, SSTAT1 = 0x0
STACK == 0x15f, 0x0, 0xe6, 0x3
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 3
QINFIFO entries: 3
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 
19 20 21 22 23 24 25 26 27 28 29 30 31
Pending list: 3
Kernel Free SCB list: 1 0
Untagged Q(0): 3
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus 
reset: host 0 channel 0 id 0 lun 0

(repeated for each ID on each channel)

David


