Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRCPXlQ>; Fri, 16 Mar 2001 18:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRCPXk4>; Fri, 16 Mar 2001 18:40:56 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:4334 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S131293AbRCPXkq>;
	Fri, 16 Mar 2001 18:40:46 -0500
Message-ID: <3AB2A46D.B10CF743@fc.hp.com>
Date: Fri, 16 Mar 2001 16:40:29 -0700
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
Cc: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <3AB29636.64C90827@neuronet.pitt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael E. Herrera" wrote:
> 
> sr0: scsi3-mmc drive: 16x/16x xa/form2 changer
> sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> sr1: scsi3-mmc drive: 16x/16x xa/form2 changer
> sr1: CDROM (ioctl) reports ILLEGAL REQUEST.
> sr2: scsi3-mmc drive: 16x/16x xa/form2 changer
> sr2: CDROM (ioctl) reports ILLEGAL REQUEST.
> sr3: scsi3-mmc drive: 16x/16x xa/form2 changer
> sr3: CDROM (ioctl) reports ILLEGAL REQUEST.
> sr4: scsi3-mmc drive: 16x/16x xa/form2 changer
> sr4: CDROM (ioctl) reports ILLEGAL REQUEST.
> sr5: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
>  sda: sda1 sda2 sda3 sda4
> SCSI device sdb: 8388315 512-byte hdwr sectors (4295 MB)
>  sdb: sdb1

My guess is, ILLEGAL REQUEST is caused by the sr driver issuing
"Mechanism Status" (0xbd) command to the CDROM drives sr0, sr1, sr2, sr3
and sr4. The reason sr driver is issuing this command is because the
loading mechanism type field in CD-ROM capabilities page is set to 0x4
(changer). Does the Nakamichi drive put the changer mechanism on a
separate LUN, e.g. 1? If so, maybe the "Mechanism Status" commnad should
go to LUN 1 but cdrom_read_mech_status() does not set the LUN field in
cgc.cmd[1] to any value other than 0. Could this be the reason for
ILLEGAL REQUEST?

-- 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
