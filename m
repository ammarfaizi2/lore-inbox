Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUIULhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUIULhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIULhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:37:46 -0400
Received: from NS-1.e-dict.net ([62.197.1.27]:237 "EHLO e-dict.net")
	by vger.kernel.org with ESMTP id S267576AbUIULfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:35:19 -0400
From: "Ingo Freund" <Ingo.Freund@e-dict.net>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, <achim_leubner@adaptec.com>
Subject: RE: three days running fine, then memory allocation errors
Date: Tue, 21 Sep 2004 13:35:02 +0200
Message-ID: <NEBBILBHKLDLOMLDGKGNEEKOCIAA.Ingo.Freund@e-dict.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20040920134835.GE3459@logos.cnet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] wrote:
> 
> On Mon, Sep 20, 2004 at 04:58:02PM +0200, Ingo Freund wrote:
> > 
> > The problem is, that I only get the errors on one machine.
> > Others (with less memory) don't react this way. 
> 
> > Is it neccessary to wait until the error occurs or do you only
> > want some outputs?
> 
> Only some outputs - it will show us if the /proc handling function
> is freeing correctly some of the memory it allocates.
> 

The patch is included.
There is no output neither in the syslog file nor in dmesg and I am not so
good in C or kernel programming to see why.

This is the output of the cat command on /proc/scsi/gdth/2 when it works.
Another strange thing is the time, the command needs to finish.
# time cat /proc/scsi/gdth/2
Driver Parameters:
 reserve_mode:  1               reserve_list:   --
 max_ids:       127             hdr_channel:    0

Disk Array Controller Information:
 Number:        0               Name:           GDT8543RZ
 Driver Ver.:   2.05            Firmware Ver.:  2.28.07-R051
 Serial No.:    0x47C24685      Cache RAM size: 262144 KB

Physical Devices:
 Chn/ID/LUN:    A/08/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  2
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    A/09/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  9
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    A/10/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  8
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    A/11/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  7
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    B/12/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  4
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    B/13/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  5
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    B/14/0          Name:           SEAGATE ST373307LC      0007
 Capacity [MB]: 70006           To Log. Drive:  6
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    D/00/0          Name:           IBM     IC35L036UCD210-0S5BS
 Capacity [MB]: 35002           To Log. Drive:  0
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    D/01/0          Name:           IBM     IC35L036UCD210-0S5BS
 Capacity [MB]: 35002           To Log. Drive:  0
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    D/02/0          Name:           IBM     IC35L036UCD210-0S5BS
 Capacity [MB]: 35002           To Log. Drive:  10
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    D/03/0          Name:           IBM     IC35L018UCD210-0S5BS
 Capacity [MB]: 17501           To Log. Drive:  1
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    D/04/0          Name:           IBM     IC35L018UCD210-0S5BS
 Capacity [MB]: 17501           To Log. Drive:  1
 Retries:       0               Reassigns:      0
 Grown Defects: 0

 Chn/ID/LUN:    D/05/0          Name:           IBM     DDYS-T18350M    SA2A
 Capacity [MB]: 17501           To Log. Drive:  3
 Retries:       0               Reassigns:      0
 Grown Defects: 0

Logical Drives:
 Number:        0               Status:         ok
 Capacity [MB]: 35002           Type:           RAID-1
 Slave Number:  21              Status:         ok
 Missing Drv.:  0               Invalid Drv.:   0
 To Array Drv.: --

 Number:        1               Status:         ok
 Capacity [MB]: 17501           Type:           RAID-1
 Slave Number:  26              Status:         ok
 Missing Drv.:  0               Invalid Drv.:   0
 To Array Drv.: --

 Number:        2               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        3               Status:         ok
 Capacity [MB]: 17501           Type:           Disk
 To Array Drv.: --

 Number:        4               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        5               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        6               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        7               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        8               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        9               Status:         ok
 Capacity [MB]: 70006           Type:           Disk
 To Array Drv.: 2

 Number:        10              Status:         ok
 Capacity [MB]: 35002           Type:           Disk
 To Array Drv.: --

Array Drives:
 Number:        2               Status:         ready
 Capacity [MB]: 210019          Type:           RAID-5

Host Drives:
 Number:        0               Arr/Log. Drive: 0
 Capacity [MB]: 35000           Start Sector:   0

 Number:        1               Arr/Log. Drive: 1
 Capacity [MB]: 17500           Start Sector:   0

 Number:        2               Arr/Log. Drive: 2
 Capacity [MB]: 210013          Start Sector:   0

 Number:        3               Arr/Log. Drive: 3
 Capacity [MB]: 17500           Start Sector:   0

Controller Events:

real    0m8.626s
user    0m0.000s
sys     0m0.000s
