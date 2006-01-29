Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWA2PuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWA2PuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWA2PuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:50:12 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:46044 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S1751049AbWA2PuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:50:10 -0500
Date: Sun, 29 Jan 2006 17:50:09 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Jens Axboe <axboe@suse.de>
Cc: Nix <nix@esperi.org.uk>, Ariel <askernel2615@dsgml.com>,
       Jamie Heilman <jamie@audible.transient.net>,
       Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-ID: <20060129155009.GT28738@edu.joroinen.fi>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz> <1137997104.2977.7.camel@laptopd505.fenrus.org> <200601230029.12674.chase.venters@clientec.com> <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz> <20060123072556.GC15490@fifty-fifty.audible.transient.net> <Pine.LNX.4.62.0601261312160.1174@pureeloreel.qftzy.pbz> <87ek2td4i9.fsf@amaterasu.srvr.nix> <20060128192714.GI9750@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128192714.GI9750@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 08:27:14PM +0100, Jens Axboe wrote:
> On Fri, Jan 27 2006, Nix wrote:
> > On 26 Jan 2006, Ariel noted:
> > > Is this good or bad? I'm guessing it means it's still leaking. So it's
> > > really starting to look like ata_piix is the problem. But we need someone
> > > who has the leak to remove that and see if it helps. I can't, since my
> > > drives are connected to it.
> > 
> > FWIW, a bit of negative-confirmatory evidence: I have a sym53c875
> > and non-SATA IDE drive on this 2.6.15.1, and there is no leak,
> > nor was there in 2.6.15:
> > 
> >     11     11 100%    0.34K      1       11         4K scsi_cmd_cache
> 
> It's not a bad data point, it just confirms that setting ->ordered_flush
> to 0 in the SATA drivers will fix the leak. So really, it's as expected.
> So far apparently nobody tried it, suggested it twice.
> 

Are all sata drivers affected by this bug in 2.6.15?

Any 'official' patch available?

Or is the recommended workaround to set ordered_flush to 0 to fix this..
does that have any downsides?

-- Pasi
