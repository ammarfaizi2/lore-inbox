Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317891AbSHLMLV>; Mon, 12 Aug 2002 08:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSHLMLV>; Mon, 12 Aug 2002 08:11:21 -0400
Received: from ml12pc11.uta.fi ([153.1.56.101]:21376 "EHLO
	euphrates.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S317891AbSHLMLU>; Mon, 12 Aug 2002 08:11:20 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [lkml] Linux 2.4.19-ac4
References: <200208051147.g75Blh720012@devserv.devel.redhat.com>
	<9cflm7kmbht.fsf@rogue.ncsl.nist.gov>
	<9cfeldcmanw.fsf@rogue.ncsl.nist.gov>
	<1028730702.18156.300.camel@irongate.swansea.linux.org.uk>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 12 Aug 2002 15:12:06 +0300
In-Reply-To: <1028730702.18156.300.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3n0rswa21.fsf@euphrates.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Sorry for the delay in responding... I'm on travel and was
disconnected for a while there.

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Tue, 2002-08-06 at 13:30, Ian Soboroff wrote:
> > 
> > Never mind.  It turns out I still have to pass 'ide0=ata66 ide1=ata66'
> > on the kernel command line.  2.4.19-ac4 boots for me!
> 
> Do you have ALI_INIT_CODE_TEST in the file defined or undef ?

I can't find this string anywhere in my source tree... I also looked
through the alim15x3.c code and didn't see anything like it.  So the
bit you have below doesn't seem to be protected by a #ifdef.

I haven't had the chance to do a recompile and reboot, but I will let
you know when I do.  By the way, there used to be a patch (which I've
attached) floating around the Fujitsu P-series community which
essentially disabled the writes to config byte 0x79 (which the
comments say is related to the southbridge).  The other workaround
people used was passing 'ide0=ata66 ide1=ata66' on the command line.

Anyway, I'll let you know if it works as soon as I get a chance to
test it.

ian

--=-=-=
Content-Disposition: attachment; filename=alim15x3.patch_2.4.18

*** linux/drivers/ide/alim15x3.c.orig	Tue Jan 29 20:22:49 2002
--- linux/drivers/ide/alim15x3.c	Tue Jan 29 20:23:50 2002
***************
*** 573,589 ****
  		/*
  		 * set south-bridge's enable bit, m1533, 0x79
  		 */
! 		pci_read_config_byte(isa_dev, 0x79, &tmpbyte);
  		if (m5229_revision == 0xC2) {
  			/*
  			 * 1543C-B0 (m1533, 0x79, bit 2)
  			 */
! 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
  		} else if (m5229_revision >= 0xC3) {
  			/*
  			 * 1553/1535 (m1533, 0x79, bit 1)
  			 */
! 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
  		}
  		/*
  		 * Ultra66 cable detection (from Host View)
--- 573,589 ----
  		/*
  		 * set south-bridge's enable bit, m1533, 0x79
  		 */
! //		pci_read_config_byte(isa_dev, 0x79, &tmpbyte);
  		if (m5229_revision == 0xC2) {
  			/*
  			 * 1543C-B0 (m1533, 0x79, bit 2)
  			 */
! //			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
  		} else if (m5229_revision >= 0xC3) {
  			/*
  			 * 1553/1535 (m1533, 0x79, bit 1)
  			 */
! //			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
  		}
  		/*
  		 * Ultra66 cable detection (from Host View)

--=-=-=--
