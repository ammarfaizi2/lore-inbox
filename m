Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWA2RKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWA2RKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 12:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWA2RKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 12:10:42 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:17632 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S1751078AbWA2RKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 12:10:41 -0500
Date: Sun, 29 Jan 2006 19:10:40 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Nix <nix@esperi.org.uk>,
       Ariel <askernel2615@dsgml.com>,
       Jamie Heilman <jamie@audible.transient.net>,
       Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-ID: <20060129171040.GU28738@edu.joroinen.fi>
References: <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz> <1137997104.2977.7.camel@laptopd505.fenrus.org> <200601230029.12674.chase.venters@clientec.com> <Pine.LNX.4.62.0601230136080.22979@pureeloreel.qftzy.pbz> <20060123072556.GC15490@fifty-fifty.audible.transient.net> <Pine.LNX.4.62.0601261312160.1174@pureeloreel.qftzy.pbz> <87ek2td4i9.fsf@amaterasu.srvr.nix> <20060128192714.GI9750@suse.de> <20060129155009.GT28738@edu.joroinen.fi> <1138552692.3352.6.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1138552692.3352.6.camel@mulgrave>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 10:38:12AM -0600, James Bottomley wrote:
> On Sun, 2006-01-29 at 17:50 +0200, Pasi Kärkkäinen wrote:
> > Are all sata drivers affected by this bug in 2.6.15?
> 
> Well, all SCSI drivers are affected by it, yes.  However, SATA devices
> are peculiarly affected because the ordered_flush method of enforcing
> barriers, which is where the leak is, can only be implemented for
> devices that don't do tag command queueing (i.e. don't have multiple
> commands outstanding for a given single device).  By and large, SATA
> drivers are the only drivers in the SCSI subsystem that can't do tag
> command queueing, which is why the problem didn't show up for any other
> type of SCSI driver.
>

OK.. thanks for summarizing this.
 
> > Any 'official' patch available?
> 
> Well, yes, 2.6.16-rc1 has this fixed.  I can't see backporting this to
> 2.6.15.x since it represents a significant functionality enhancement as
> well, so I'd lean towards just forcing ordered_flush to zero in 2.6.15.x
> which seems to be the best bug fix.
>

OK.
 
> > Or is the recommended workaround to set ordered_flush to 0 to fix this..
> > does that have any downsides?
> 
> setting ordered_flush to zero for 2.6.15 turns off the flushing
> functionality and restores the old behaviour.  I don't see that there
> would be any down side to this.
> 

That's good to hear. Thanks.

-- Pasi 
