Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTAQVnl>; Fri, 17 Jan 2003 16:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTAQVnl>; Fri, 17 Jan 2003 16:43:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261364AbTAQVnk>;
	Fri, 17 Jan 2003 16:43:40 -0500
Subject: [2.5.59][KEXEC] Success Report
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Jan 2003 13:52:58 -0800
Message-Id: <1042840379.11201.14.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

The same configuration of kexec that I used successfully with 2.5.58
patches cleanly to 2.5.59 and works fine for me.

The current patch stack that I am using is available in OSDL's patch
manager:

kexec for 2.5.59 (based upon the version for 2.5.54):
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1442

hwfixes that makes it work for me (same as for 2.5.58):
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1444

For those that are curious, the firmware on my SCSI-based test machine
requires about 49 seconds (crudely measured by hand) to get its act
together and hand the machine over to LILO.

Approximate boot timelines for my machine (2 SCSI disks on an Adaptec
aic7892 Ultra160 SCSI controller, IDE CD-ROM, 640MB of memory, P3-800). 
Measured by hand (so give or take a second or two), starting from
single-user mode, non-relevant filesytems unmounted, relevant
filesystems mounted read-only:

    reboot via kexec:

         :00 kexec-1.8 --force
         :08 begin of IDE probe
         :13 end of IDE probe / begin of SCSI probe
         :19 end of SCSI probe
         :22 start /sbin/init
         :55 login:

    standard reboot (going through the firmware):

         :00 reboot -df
         :49 firmware --> LILO --> begin uncompressing kernel
         :57 begin of IDE probe
        1:10 end of IDE probe / begin of SCSI probe
        1:16 end of SCSI probe
        1:19 start /sbin/init
        1:52 login:

Regards,
Andy



