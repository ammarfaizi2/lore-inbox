Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRAATmL>; Mon, 1 Jan 2001 14:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbRAATmC>; Mon, 1 Jan 2001 14:42:02 -0500
Received: from AGrenoble-101-1-1-84.abo.wanadoo.fr ([193.251.23.84]:48378 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S129741AbRAATlv>;
	Mon, 1 Jan 2001 14:41:51 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.0 test13-pre7 still causes CDROM ioctl errors
In-Reply-To: <20001231141855.B574@suse.de>
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Mon, 01 Jan 2001 20:11:15 +0100
Message-ID: <8253.978376275@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Saw your reply on the web archive: I'm not subscribed to linux-kernel.
 Cc-ing the list for archive -- I've faked an In-Reply-To for correct
 threading].

A "cat /proc/sys/dev/cdrom/info" says
(I have 2 CD-ROMs, but the one with ioctl() errors is the SCSI one)

    CD-ROM information, Id: cdrom.c 3.12 2000/10/18

    drive name:             sr0     hdb
    drive speed:            1       1
    drive # of slots:       1       1
    Can close tray:         1       1
    Can open tray:          1       1
    Can lock tray:          1       1
    Can change speed:       0       1
    Can select disk:        1       0
    Can read multisession:  1       1
    Can read MCN:           1       1
    Reports media changed:  1       1
    Can play audio:         1       1
    Can write CD-R:         1       0
    Can write CD-RW:        1       0
    Can read DVD:           1       0
    Can write DVD-R:        1       0
    Can write DVD-RAM:      1       0

Apparently, it recognizes its audio-playing capabilities.

However, this is NOT a CD writer, and I don't know why it's saying it
can *write* CDs.  This CD-ROM is:

    Host: scsi1 Channel: 00 Id: 02 Lun: 00
      Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.01
      Type:   CD-ROM                           ANSI SCSI revision: 02

As for sr_mod loading, I don't have any special flags specified
(no options in /etc/modules.conf).  But I did not have any either
previously.

The module "sr_mod" loads correctly:

    Module                  Size  Used by
    sr_mod                 12688   0 (autoclean)
    es1371                 29104   0 (autoclean)
    ac97_codec              7728   0 (autoclean) [es1371]
    vmnet                  17824   3
    vmmon                  19056   3
    nls_cp437               4352   2 (autoclean)

Note that this does not prevent correct playback from xmcd, i.e. the control
interface to launch the playback works correctly, xmcd just complains about
the ioctl() error.

However, I'm also running VMWare (as you can see with the vmnet and
vmmon modules), and it refuses to connect my SCSI CD-ROM device.  It says:

    CDROM: "/dev/cdrom" exists but does not appear to be a CDROM device

And /dev/cdrom is:

    /dev/cdrom -> /dev/scd0

Raphael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
