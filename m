Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSGDBly>; Wed, 3 Jul 2002 21:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSGDBlx>; Wed, 3 Jul 2002 21:41:53 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:37637 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317308AbSGDBlw>; Wed, 3 Jul 2002 21:41:52 -0400
Date: Wed, 3 Jul 2002 18:44:11 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: which device nodes used by  ips.o module?
Message-ID: <20020703184411.E392@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207031659420.2228-100000@ares.sot.com> <Pine.LNX.4.44.0207031601120.20478-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.44.0207031601120.20478-100000@netfinity.realnet.co.sz>; from zwane@linuxpower.ca on Wed, Jul 03, 2002 at 04:02:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 04:02:06PM +0200, Zwane Mwaikambo wrote:
> On Wed, 3 Jul 2002, Yaroslav Popovitch wrote:
> 
> > 
> > I could not find information about device nodes which are used by ips.o 
> > module(IBM ServeRAID 4Mx).
> > I don't have hardware, as result I cannot check in experiment.
> > Would you help me ...
> 
> By device nodes do you mean /dev/foo? In which case its just 
> /dev/sd[abc...]
> 

Check dmesg

dmesg should output something like:

  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.91
  Type:   Direct-Access                      ANSI SCSI
revision: 02
  Vendor: SEAGATE   Model: ST32155W          Rev: 0528
  Type:   Direct-Access                      ANSI SCSI
revision: 02
  Vendor: COMPAQPC  Model: ST34371N          Rev: 0472
  Type:   Direct-Access                      ANSI SCSI
revision: 02
  Vendor: TEAC      Model: CD-ROM CD-516S    Rev: 1.0D
  Type:   CD-ROM                             ANSI SCSI
revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi1, channel 0, id 0, lun 0
SCSI device sda: 8515173 512-byte hdwr sectors (4360 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 4197405 512-byte hdwr sectors (2149 MB)
 sdb: sdb1
SCSI device sdc: 8386000 512-byte hdwr sectors (4294 MB)
 sdc: unknown partition table

If you forget channel, HBA, or ID your device is on look in
/proc/scsi/scsi which should contain something like:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDIGTL   Model: ENTERPRISE       Rev: 1.91
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST32155W         Rev: 0528
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQPC Model: ST34371N         Rev: 0472
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-516S   Rev: 1.0D
  Type:   CD-ROM                           ANSI SCSI
revision: 02


All you have to do is match the HBA, channel, id, lun
tuple with the dmesg entry "Detected scsi disk..."



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
