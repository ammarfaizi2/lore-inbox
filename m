Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSHGNJT>; Wed, 7 Aug 2002 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHGNJP>; Wed, 7 Aug 2002 09:09:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50425 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317388AbSHGNIi>; Wed, 7 Aug 2002 09:08:38 -0400
Subject: Re: [lkml] Linux 2.4.19-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
In-Reply-To: <9cfeldcmanw.fsf@rogue.ncsl.nist.gov>
References: <200208051147.g75Blh720012@devserv.devel.redhat.com>
	<9cflm7kmbht.fsf@rogue.ncsl.nist.gov>  <9cfeldcmanw.fsf@rogue.ncsl.nist.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 15:31:42 +0100
Message-Id: <1028730702.18156.300.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 13:30, Ian Soboroff wrote:
> 
> Never mind.  It turns out I still have to pass 'ide0=ata66 ide1=ata66'
> on the kernel command line.  2.4.19-ac4 boots for me!

Do you have ALI_INIT_CODE_TEST in the file defined or undef ?

If its defined then this means the code path that causs the problem is
quite small and is in the function

ata66_ali15x3

Can you comment out the bit below and see if that is the cure

        /*
         * CD_ROM DMA on (m5229, 0x53, bit0)
	 *	Enable this bit even if we want to use PIO
	 * PIO FIFO off (m5229, 0x53, bit1)
	 *	The hardware will use 0x54h and 0x55h to control PIO FIFO
	 */
	pci_read_config_byte(dev, 0x53, &tmpbyte);
	tmpbyte = (tmpbyte & (~0x02)) | 0x01;

	pci_write_config_byte(dev, 0x53, tmpbyte);

