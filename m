Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWA3MEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWA3MEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWA3MEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:04:15 -0500
Received: from mail.gmx.de ([213.165.64.21]:24035 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932236AbWA3MEP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:04:15 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 13:04:08 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, James@superbug.co.uk, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060130120408.GA8436@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jengelh@linux01.gwdg.de, James@superbug.co.uk, mrmacman_g4@mac.com,
	linux-kernel@vger.kernel.org, acahalan@gmail.com,
	"unlisted-recipients:; "@pop3.mail.demon.net
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk> <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <43DDFBFF.nail16Z3N3C0M@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-30:

> > >> -	/dev/hd* artificially prevents the ioctls SCSI_IOCTL_GET_IDLUN
> > >> SCSI_IOCTL_GET_BUS_NUMBER from returning useful values.
> > >> As long as this bug is present, there is no way to see SG_IO via
> > >> /dev/hd* as integral part of the Linux SCSI transport concept.
> >
> > Now you're talking shop ;-)
> >
> > Hm, this ATAPI stuff makes me a headache. Well, anyway, out of 
> > curiosity, what is an ATAPI drive (IDE-ATAPI) supposed to return when asked 
> > for bus number, id or lun - independent of OS and/or cdrecord?
> 
> The drive does not return this information, but the SCSI subsystem creates
> these instance numbers. A SCSI drive (like a CD/DVD burner) is supposed to
> be known to the SCSI sub-system and thus needs to have a SCSI subsystem
> related instance number.

We are talking about ATA and ATAPI drives here. They may use SCSI
commands, but the transport is different. My take is: the Kernel guys
have been refusing to invent a non-native enumeration scheme for
non-SCSI transports, and you have not provided evidence why this is
indispensable.

Why is it a *kernel* task to invent SCSI identifier for a non-SCSI
transport that does not have such identifiers, in addition to the device
name? libscg is already doing it for /dev/hd* and /dev/pg*.
How about USB or Firewire or SATA? Do they have ID or LUN?

Why isn't libscg simply scanning all transports exhaustively (i. e. not
stopping at EPERM) and inventing this itself? You're failing to answer
this questions for week now, even though you agreed resmgr or similar
setups were safe.

How is a user going to tell apart two devices of the same make and model
from -scanbus output? The answer is (s)he cannot.

Sounds unrealistic? Well, some orchestras sell fresh recordings half an
hour after the final chord, with some dozen CD writers...

> Cdrecord is a program that needs to be able to send any SCSI command as 
> it needs to be able to add new vendor unique commands for new drive/feature
> support.

Right, but evidently it does not need the kernel to invent numbering.
dev=/dev/hdc works today.

-- 
Matthias Andree
