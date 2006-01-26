Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWAZLJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWAZLJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWAZLJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:09:58 -0500
Received: from mail.gmx.de ([213.165.64.21]:3518 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932289AbWAZLJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:09:57 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 12:09:51 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126110951.GA2824@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
	acahalan@gmail.com
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner> <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D89B7C.nailDTH38QZBU@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-26:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > Joerg Schilling wrote:
> >
> > >> So I'll repeat my question: is there anything that SG_IO to /dev/hd* (via
> > >> ide-cd) cannot do that it can do via /dev/sg*? Device enumeration doesn't count.
> > > 
> > > But device enumeration is the central point when implementing -scanbus.
> >
> > Again: Is there anything *besides* (<German>: außer) device enumeration that
> > does not work with the current /dev/hd* SG_IO interface?
> 
> This is the main point.

So there is no real reason.

> People like to run cdrecord -scanbus in order to find a list of usable devices.
> People like to see all SCSI devices in a single name space as they are all 
> using the same protocol for communication.

I find -scanbus rather annoying, particularly since it doesn't scan all
buses, I need to query cdrecord for the implemented transports, run
-scanbus for each of them again, and everything.

I know what device my writer has, SG_IO is sufficiently capable to write
CDs, is the declared standard for Linux parallel ATA-PI devices and I
want cdrecord to stop pissing at my leg for knowing the device up front.

> A sane way to send SCSI commands to _any_ type of devices would be to have a 
> SCSI generic transport layer that is independent from the high-level features 
> of the OS and that is independent from whether there is a high-level driver for 
> this device at all.

It appears as though the high-level driver gave you exactly that
generic mid-level access. If Linux violates design principles, is none
of your business as long as your application works.

> This is what I designed the scg driver interface for in 1986 and this is what

Yes, 20 years ago. How relevant is this for OSes that needed to be
updated in 2005 to support cdrecord again?

And what has this got to do with libscg's bogus assumptions ("If I
cannot have /dev/hda, I don't need to probe /dev/hdc anyways") after
you've agreed that resmgr and similar to allow console users access to
ONLY the writer were no major security risk?

> Adaptec did in 1988 with ASPI. This is of course also why the SCSI standard 
> commitee made a proposal for the CAM SCSI interface. 

We don't have ASPI on Linux, you're digressing.

-- 
Matthias Andree
