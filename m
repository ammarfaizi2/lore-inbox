Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284812AbRLEXJi>; Wed, 5 Dec 2001 18:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLEXJ3>; Wed, 5 Dec 2001 18:09:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28428
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S284812AbRLEXJV>; Wed, 5 Dec 2001 18:09:21 -0500
Date: Wed, 5 Dec 2001 15:05:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <9um58i$9no$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10112051438030.9419-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Linus Torvalds wrote:

> The old SCSI code won't be fixed.  It will just be made totally obsolete
> by the better generic block layer code.  I personally hope that a year
> from now, if somebody wants to do a new SCSI driver, he won't even
> _think_ about using the SCSI code, the driver will just take the
> (generic SCSI) requests directly off the block queue. 
> 
> Death to middle-men that can't do a good job anyway.

Linus,

Would a three part model be to your liking?  The parts of there for
isolation and testing the intergity of the driver to have confidence it
can be trusted to do its tasks proper.

BLOCK IO
----------------------
1)	Mainloop
2)	Personality Drivers		(DEVICE TYPES, but expanded)
3)	HOST/Controller-DEVICE

The significance in part three of the driver layer is for satisfying a new
requirement in SCSI4 for (buzzword) "Domain Boundaries".  It means to
provide a diagnostic verification of the transport/data-phase layers.

It would require non-serialized block access to perform something like a
direct pattern-block write-read-verification-checksum.  This is not
trivial for SCSI, but it can be created.  The strength of this model is
Linux could then isolate the hardware problems and make corrections on a
controller bases and not pollute the purity of the "Domain Boundaries".

This is a model, I have been working on for a while for ATA for 2.5,
however it is no longer possible at this time because of the changes in
the Block IO model that are not documented describing what and why new
request_struct items are added and their usage ruleset.

Regards,

Andre Hedrick
Linux ATA Development

