Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292934AbSB1WCM>; Thu, 28 Feb 2002 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293151AbSB1WAK>; Thu, 28 Feb 2002 17:00:10 -0500
Received: from huitzilopochtli.presidencia.gob.mx ([200.57.34.35]:54430 "EHLO
	huitzilopochtli.presidencia.gob.mx") by vger.kernel.org with ESMTP
	id <S310136AbSB1V5h>; Thu, 28 Feb 2002 16:57:37 -0500
Message-ID: <3C7EA7CB.C36D0211@sandino.net>
Date: Thu, 28 Feb 2002 15:57:31 -0600
From: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-MX, es, es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Oops happens after I use the ide-scsi module with my CDRW and then I
plug the Zip USB in.

To reproduce the oops:
1. Boot the machine (usbmgr should be started at boot)
2. rmod ide-cd ; rmmod ide-scsi ; rmmod sr_mod ; rmmod cdrom
3. modprobe ide-scsi
    /dev/scsi/host2/bus0/target0/lun0/generic is created
4. modprobe sr_mod
    /dev/scsi/host2/bus0/target0/lun0/cd is created
    /dev/cdroms/cdrom0 -> /dev/scsi/host2/bus0/target0/lun0/cd
5. Plug the Zip in the USB
    usb-storage is loaded
    /dev/scsi/host2/bus0/target0/lun0/disc is created
    /dev/scsi/host2/bus0/target0/lun0/part4 is created
    /dev/scsi/host2/bus0/target0/lun0/cd disappears
    /dev/cdroms/cdrom0 becomes broken link
    /dev/scsi/host2/bus0/target0/lun0/generic changes from the CDRW
generic device to the Zip generic device
6. Unplug the Zip
    /dev/scsi/host2/bus0/target0/lun0 disappears, I can only reach to
/dev/scsi/host2/bus0/target0
    usb-storage is unloaded
7. different ways of provoking the Oops
    7.1 umount /mnt/cdrom
    7.2 rmmod sr_mod
    7.3 rmmod ide-scsi
    7.4 Any kind of trying to read or write the CD

The Oops does not happen if I unload ide-scsi, sr_mod, cdrom before
pluging the Zip in and if I unplug the Zip before modprobe ide-scsi and
modprobe sr_mod.


--
Sandino Araico Sánchez
>drop table internet;
OK, 135454265363565609860398636678346496 rows affected.
"oh fuck" --fluxrad



