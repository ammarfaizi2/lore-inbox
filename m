Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWGGOcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWGGOcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWGGOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:32:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54479 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932090AbWGGOcb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:32:31 -0400
Message-Id: <200607071432.k67EWLZa004115@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6 libata stupid question...
In-Reply-To: Your message of "Fri, 07 Jul 2006 01:33:56 EDT."
             <44ADF244.5050504@garzik.org>
From: Valdis.Kletnieks@vt.edu
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
            <44ADF244.5050504@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152282741_2967P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 10:32:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152282741_2967P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jul 2006 01:33:56 EDT, Jeff Garzik said:
> Valdis.Kletnieks@vt.edu wrote:
> > There's only one minor detail - although the CD is (AFAIK) a UDMA/33 device
,
> > the hard drive and the controller are both able to do UDMA/100.
> 
> Currently both master and slave are forced to the least common 
> denominator speed.

OK, that explains why I couldn't make it work. :)

> Alan Cox has fixed this in a patch, for the controllers that allow 
> master and slave to run at different bus speeds (most allow this).

Good to know.  As a practical matter, the disk throughput is dominated by
seek overhead, so I'm not seeing a *vast* performance hit.  So I can wait
till the patch shows up in a form I can get working with a -mm kernel.

The only other thing I've noticed (possibly reported before when I wasn't
paying attention to libata activity) was this when SMART started up:

(The hardware involved, for those who missed the start of thread):

lspci says:
00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 02)

And 'hdparm -I /dev/sda' says:
ATA device, with non-removable media
        Model Number:       FUJITSU MHV2060AH                       
        Serial Number:      NT25T5629CCL
        Firmware Revision:  00000096


[   53.109000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   53.110000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   53.111000] ata1: soft resetting port
[   53.420000] ata1.00: configured for UDMA/33
[   53.572000] ata1.01: configured for UDMA/33
[   53.572000] ata1: EH complete
[   53.573000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   53.574000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   53.575000] ata1: soft resetting port
[   53.882000] ata1.00: configured for UDMA/33
[   54.033000] ata1.01: configured for UDMA/33
[   54.033000] ata1: EH complete
[   54.034000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   54.035000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   54.036000] ata1: soft resetting port
[   54.343000] ata1.00: configured for UDMA/33
[   54.495000] ata1.01: configured for UDMA/33
[   54.495000] ata1: EH complete
[   54.496000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   54.497000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   54.498000] ata1: soft resetting port
[   54.805000] ata1.00: configured for UDMA/33
[   54.957000] ata1.01: configured for UDMA/33
[   54.957000] ata1: EH complete
[   54.958000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   54.959000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   54.960000] ata1: soft resetting port
[   55.267000] ata1.00: configured for UDMA/33
[   55.419000] ata1.01: configured for UDMA/33
[   55.419000] ata1: EH complete
[   55.420000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   55.421000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   55.422000] ata1: soft resetting port
[   55.729000] ata1.00: configured for UDMA/33
[   55.880000] ata1.01: configured for UDMA/33
[   55.880000] ata1: EH complete
[   55.917000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   55.918000] sda: Write Protect is off
[   55.919000] sda: Mode Sense: 00 3a 00 00
[   55.919000] SCSI device sda: drive cache: write back
[   55.920000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   55.921000] sda: Write Protect is off
[   55.922000] sda: Mode Sense: 00 3a 00 00
[   55.922000] SCSI device sda: drive cache: write back
[   56.524000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   56.525000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   56.526000] ata1: soft resetting port
[   56.833000] ata1.00: configured for UDMA/33
[   56.985000] ata1.01: configured for UDMA/33
[   56.985000] ata1: EH complete
[   57.099000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   57.100000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   57.101000] ata1: soft resetting port
[   57.408000] ata1.00: configured for UDMA/33
[   57.559000] ata1.01: configured for UDMA/33
[   57.559000] ata1: EH complete
[   57.673000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   57.674000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   57.675000] ata1: soft resetting port
[   57.982000] ata1.00: configured for UDMA/33
[   58.133000] ata1.01: configured for UDMA/33
[   58.133000] ata1: EH complete
[   58.247000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   58.248000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   58.249000] ata1: soft resetting port
[   58.557000] ata1.00: configured for UDMA/33
[   58.709000] ata1.01: configured for UDMA/33
[   58.709000] ata1: EH complete
[   58.833000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   58.834000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   58.835000] ata1: soft resetting port
[   59.143000] ata1.00: configured for UDMA/33
[   59.294000] ata1.01: configured for UDMA/33
[   59.294000] ata1: EH complete
[   59.418000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[   59.419000] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[   59.420000] ata1: soft resetting port
[   59.727000] ata1.00: configured for UDMA/33
[   59.879000] ata1.01: configured for UDMA/33
[   59.879000] ata1: EH complete
[   59.880000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   59.881000] sda: Write Protect is off
[   59.882000] sda: Mode Sense: 00 3a 00 00
[   59.883000] SCSI device sda: drive cache: write back
[   59.884000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   59.886000] sda: Write Protect is off
[   59.887000] sda: Mode Sense: 00 3a 00 00
[   59.888000] SCSI device sda: drive cache: write back

Lot of noise, but the system keeps going and /usr/sbin/smartd doesn't seem
to notice a problem....


--==_Exmh_1152282741_2967P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErnB1cC3lWbTT17ARAuhrAJ9Gx71Vvk4qSEvRj25jxZk+ezI+ggCgkQwm
ShEMMp9KiApox0Z0nozDURk=
=qryz
-----END PGP SIGNATURE-----

--==_Exmh_1152282741_2967P--
