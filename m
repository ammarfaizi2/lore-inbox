Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbRFJCJ4>; Sat, 9 Jun 2001 22:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbRFJCJq>; Sat, 9 Jun 2001 22:09:46 -0400
Received: from cc1074780-a.ewndsr1.nj.home.com ([24.180.76.171]:51862 "HELO
	saw.sw.com.sg") by vger.kernel.org with SMTP id <S263043AbRFJCJn>;
	Sat, 9 Jun 2001 22:09:43 -0400
Message-ID: <20010609220759.A3978@saw.sw.com.sg>
Date: Sat, 9 Jun 2001 22:07:59 -0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: torvalds@transmeta.com
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Frazer <mark@somanetworks.com>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: eepro100 security fix [was: Re: MII access]
In-Reply-To: <3B1A2982.C53B159C@mandrakesoft.com> <Pine.LNX.4.33.0106051104140.5137-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.33.0106051104140.5137-100000@kenzo.iwr.uni-heidelberg.de>; from "Bogdan Costescu" on Tue, Jun 05, 2001 at 11:07:06AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii

Linus,

Please apply the attached patch.
It fixes a security problem of user-controlled access to the card ports from
a non-privileged ioctl which should have read-only semantics.

Best regards
		Andrey

On Tue, Jun 05, 2001 at 11:07:06AM +0200, Bogdan Costescu wrote:
> On Sun, 3 Jun 2001, Jeff Garzik wrote:
> 
> > Bogdan Costescu wrote:
> > > With clearer mind, I have to make some a correction to one of the previous
> > > messages: the problem of not checking arguments range does not apply to
> > > 3c59x which has in the ioctl function '& 0x1f' for both transceiver number
> > > and register number. However, eepro100 and tulip don't do that. (I'm
> > > checking now with 2.4.3 from Mandrake 8, but I don't think that there were
> > > recent changes in these areas).
> >
> > half right -- tulip does this for the phy id but not the MII register
> > number.  I'll fix that up.  Please bug Andrey about fixing up
> > eepro100...

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mii-access1

--- drivers/net/eepro100.c.prev	Sat Jan 27 05:07:13 2001
+++ drivers/net/eepro100.c	Wed Jun  6 22:26:03 2001
@@ -1913,7 +1913,7 @@
 		   timer routine.  2000/05/09 SAW */
 		saved_acpi = pci_set_power_state(sp->pdev, 0);
 		t = del_timer_sync(&sp->timer);
-		data[3] = mdio_read(ioaddr, data[0], data[1]);
+		data[3] = mdio_read(ioaddr, data[0] & 0x1f, data[1] & 0x1f);
 		if (t)
 			add_timer(&sp->timer); /* may be set to the past  --SAW */
 		pci_set_power_state(sp->pdev, saved_acpi);

--k+w/mQv8wyuph6w0--
