Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946170AbWBDLRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946170AbWBDLRg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946169AbWBDLRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:17:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946170AbWBDLRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:17:35 -0500
Date: Sat, 4 Feb 2006 11:17:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, hch@infradead.org, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060204111732.GA27923@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
	jengelh@linux01.gwdg.de, James@superbug.co.uk, acahalan@gmail.com,
	"unlisted-recipients:; "@pop3.mail.demon.net
References: <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk> <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner> <20060130120408.GA8436@merlin.emma.line.org> <20060130122349.GA13871@infradead.org> <43DE3B98.nail16ZM1LULL@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE3B98.nail16ZM1LULL@burner>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 05:15:20PM +0100, Joerg Schilling wrote:
> > Nothing but SPI (parallel scsi) has a target id.  Everything that broadly
> > falls under SAM has luns.  Because SPI is dying transport the scsi
> > midlayer will get rid of having a mandatory target id mid-term.  Relying
> > on the target id to have any useful meaning is dangerous, it doesn't
> > have a really useful meaning on anything but SPI.
> 
> And now please tell me how you believe this will be inplemented.....

There's very little places left that need to know about the target id.
A few month ago we had a detailed list on linux-scsi, but off my head these
are:

 - sdev_printk prints the device identifier which right now includes the
   target id.  this will become a transport class callout so the transport
   can print transport-specific information
 - various scanning interfaces (scsi_scan_host_selected, scsi_scan_target,
   scsi_add_device) require a channel id.  scsi_scan_target will lose the
   id parameter because it doesn't even need it, the others will move out
   of the core into the spi transport class or another module for all spi-like
   drivers, as lots of RAID HBAs want SPI-like scanning
 - starget_for_each_device does id comparims currently, but it can be changed
   to iterate the targets parent devices list easily.

with those smaller bits the scsi core doesn't need to know about the
target id anymore.

now all this is rather pointless as you really love your scheme and don't
want to change anyway, so let's stop this discussion ;-)
