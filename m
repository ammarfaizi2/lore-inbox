Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314457AbSEXQDP>; Fri, 24 May 2002 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSEXQCJ>; Fri, 24 May 2002 12:02:09 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13492 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314457AbSEXP6I>;
	Fri, 24 May 2002 11:58:08 -0400
Date: Fri, 24 May 2002 17:57:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020524175740.A21033@ucw.cz>
In-Reply-To: <Pine.SOL.4.30.0205241620440.16894-100000@mion.elka.pw.edu.pl> <20020524172910.A17984@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2002 at 05:29:10PM +0200, Vojtech Pavlik wrote:
> On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Hi!
> > 
> > I have a very quick look over patch/driver... looks quite ok...
> > 
> > But it doesn't support multiple controllers. We should add 'unsigned
> > long private' to 'ata_channel struct' and store index in the chipset
> > table there.
> > You can remove duplicate entries from module data table.
> > 
> > BTW: please don't touch pdc202xx.c I am playing with it...
> 
> Here is a new patch. Martin: This one should be OK for inclusion now.
> Bartlomiej: Please check it anyway.

One more fix attached.

-- 
Vojtech Pavlik
SuSE Labs

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="artop3.diff"

ChangeSet@1.660, 2002-05-24 17:56:40+02:00, vojtech@twilight.ucw.cz
  UDMA33 controller cannot deetct 80-wire cable.


 aec62xx.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
--- a/drivers/ide/aec62xx.c	Fri May 24 17:56:57 2002
+++ b/drivers/ide/aec62xx.c	Fri May 24 17:56:57 2002
@@ -223,6 +223,9 @@
 {
 	unsigned char t;
 
+	if (ch->pci_dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF)
+		return 0;
+
 	pci_read_config_byte(ch->pci_dev, AEC_MISC, &t);
 	return ((t & (1 << ch->unit)) ? 0 : 1);
 }

--GvXjxJ+pjyke8COw--
