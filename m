Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271637AbRHQMWq>; Fri, 17 Aug 2001 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271623AbRHQMWh>; Fri, 17 Aug 2001 08:22:37 -0400
Received: from [200.156.3.116] ([200.156.3.116]:56059 "EHLO
	office.extracta.com.br") by vger.kernel.org with ESMTP
	id <S271637AbRHQMW3>; Fri, 17 Aug 2001 08:22:29 -0400
Message-ID: <3B7D0D7D.9020005@extracta.com.br>
Date: Fri, 17 Aug 2001 09:26:37 -0300
From: Jon Lapham <lapham@extracta.com.br>
Reply-To: lapham@extracta.com.br
Organization: Extracta Moleculas Naturais
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010807
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange SCSI behavior?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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



