Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271643AbRHQM4C>; Fri, 17 Aug 2001 08:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271644AbRHQMzy>; Fri, 17 Aug 2001 08:55:54 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:37366 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S271643AbRHQMzf>; Fri, 17 Aug 2001 08:55:35 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE1008EAF7@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'lapham@extracta.com.br'" <lapham@extracta.com.br>,
        linux-kernel@vger.kernel.org
Subject: RE: Strange SCSI behavior?
Date: Fri, 17 Aug 2001 05:46:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

You really need to know what the additional sense data shows.
With DAT tapes often they have variable length block sizes and get errors
from some UNIX commands as a result.  Or, it may be something that could be
fixed with a firmware update to the DAT drive, or a driver fix.  It depends
on the details.  Is sd08:11 the DAT drive?

Make sure 
CONFIG_SCSI_LOGGING=y 
CONFIG_SCSI_DEBUG=m (or =y)
in your kernel, and issue
echo "scsi log error 3" > /proc/scsi/scsi
and rerun the tape backup to get more info.

Andy

-----Original Message-----
From: Jon Lapham [mailto:lapham@extracta.com.br]
Sent: Friday, August 17, 2001 8:27 AM
To: linux-kernel@vger.kernel.org
Subject: Strange SCSI behavior?


Hello-

I'm running a heavily used (~10-40 simultaneous users) NFS/smb/email 
server on which I recently installed a new SCSI HD (Atlas V 18GB).  The 
system is a PIII 450, 256MB RAM, 2940U2W SCSI controller, running kernel 
v2.4.8 (but I've also tried older kernels as well) using the new aic7xxx 
driver, the fs is ext2.

What I'm seeing is SCSI "sense key hardware Errors" on the new HD 
during tape backups (HPC1554 DDS-3 drive) scheduled at night (when the 
system is unused):

SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
Info fld=0x214a55b, Current sd08:11: sense key Hardware Error
  I/O error: dev 08:11, sector 34907416

Sounds like bad HD, right?  Well, I've seen bad SCSI disks before, and 
this seems different.  These messages *only* appear during tape backups, 
  but not during the day when the machine is under *heavy* I/O load to 
that HD.  It is *only* when the DAT tape gets involved that I see these 
messages.  I should also say that files that correspond to the affected 
sectors in the error messages are fine, they are not corrupted.

Suggestions?  What can I do to track this down?

TIA, Jon

[root@office /root]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: SEAGATE  Model: ST39175LW        Rev: 0001
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
   Vendor: HP       Model: C1537A           Rev: L708
   Type:   Sequential-Access                ANSI SCSI revision: 02

[root@office /root]# cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 6.1.13
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
Channel A Target 0 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
	Channel A Target 0 Lun 0 Settings
		Commands Queued 760609
		Commands Active 0
		Command Openings 52
		Max Tagged Openings 253
		Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
	Channel A Target 1 Lun 0 Settings
		Commands Queued 790561
		Commands Active 0
		Command Openings 64
		Max Tagged Openings 253
		Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
	Goal: 10.000MB/s transfers (10.000MHz, offset 32)
	Curr: 10.000MB/s transfers (10.000MHz, offset 32)
	Channel A Target 3 Lun 0 Settings
		Commands Queued 3200334
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
