Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288258AbSAHTXB>; Tue, 8 Jan 2002 14:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288257AbSAHTWv>; Tue, 8 Jan 2002 14:22:51 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:3713 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S288255AbSAHTWp>; Tue, 8 Jan 2002 14:22:45 -0500
Message-ID: <3C3B46F3.5010107@allegientsystems.com>
Date: Tue, 08 Jan 2002 14:22:27 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mario Mikocevic <mozgy@hinet.hr>
CC: Doug Ledford <dledford@redhat.com>,
        Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3AA9AD.6070203@redhat.com> <3C3AB5AB.2080102@redhat.com> <20020108161137.A6747@danielle.hinet.hr>
Content-Type: multipart/mixed;
 boundary="------------070506020005040606070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070506020005040606070401
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Mario Mikocevic wrote:

>Hi,
>
>>OK, various clean ups made, and enough of the SiS code included that I think 
>>it should work, plus one change to the i810 interrupt handler that will 
>>(hopefully) render the other change you made to get_dma_addr and drain_dac 
>>unnecessary.  If people could please download and test the new 0.14 version 
>>of the driver on my site, I would appreciate it.
>>
>>http://people.redhat.com/dledford/i810_audio.c.gz
>>
>
>Hmmm, maybe way too much cleanups !? :)
>
Works fine for me with the attached patch. (artsd, mmap mode ok so far)

--------------070506020005040606070401
Content-Type: text/plain;
 name="14.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="14.diff"

--- i810_audio.c.14	Tue Jan  8 03:28:31 2002
+++ linux/drivers/sound/i810_audio.c	Tue Jan  8 14:01:26 2002
@@ -655,7 +655,6 @@
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned int civ, offset, port, port_picb, bytes = 2;
-	struct i810_channel *c;
 	
 	if (!dmabuf->enable)
 		return 0;
@@ -744,7 +743,7 @@
 	if(card->pci_id == PCI_DEVICE_ID_SI_7012)
 		outb( inb(card->iobase + PO_PICB), card->iobase + PO_PICB );
 	else
-		outb( inb(card->iobase + PO_SR), card->iobase + PI_OR );
+		outb( inb(card->iobase + PO_SR), card->iobase + PO_SR );
 	outl( inl(card->iobase + GLOB_STA) & INT_PO, card->iobase + GLOB_STA);
 }
 

--------------070506020005040606070401--

