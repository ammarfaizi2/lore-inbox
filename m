Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268439AbTBNPd5>; Fri, 14 Feb 2003 10:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268447AbTBNPd5>; Fri, 14 Feb 2003 10:33:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:44265 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268439AbTBNPd4>; Fri, 14 Feb 2003 10:33:56 -0500
Date: Fri, 14 Feb 2003 07:43:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 355] New: Error when compiling SCSI drivers (Adaptec, Seagate
 etc.)
Message-ID: <57590000.1045237423@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=355

           Summary: Error when compiling SCSI drivers (Adaptec, Seagate
                    etc.)
    Kernel Version: 2.5.60 (- bk4)
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: martinsteeg@t-online.de


Software Environment: linnx Kernel 2.5.60 ( and snapshots -bk1 ... -bk4)  
Problem Description:   
  In the change of linux-2.5.59 to linux-2.5.60, the struct scsi_cmnd   
  was changed in that the fields host, target, lun, channel are replaced   
  by fields of the device field (struct scsi_device*): host, id, lun,
channel       
  This is not reflected in several SCSI drivers, e.g. the change is not  
  considered for Adaptec and Seagate SCSI controllers.  
  
Proposal to fix the Problem:  
1. some new defines for drivers/scsi/scsi.h  
+#define SCSICMND_HOST     device->host  
+#define SCSICMND_TARGET   device->id  
+#define SCSICMND_LUN      device->lun  
+#define SCSICMND_CHANNEL  device->channel  
2. replacing the lines of drivers/scsi/*.c containing the following code  
-(ptr)->host  
+)ptr)->SCSICMND_HOST  
-(ptr)->target  
+)ptr)->SCSICMND_TARGET  
-(ptr)->lun  
+)ptr)->SCSICMND_LUN  
-(ptr)->channel  
+)ptr)->SCSICMND_CHANNEL


