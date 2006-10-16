Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWJPIsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWJPIsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWJPIsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:48:21 -0400
Received: from mout2.freenet.de ([194.97.50.155]:40593 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1161222AbWJPIsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:48:20 -0400
To: "Jens Axboe" <jens.axboe@oracle.com>,
       "Peter Osterlund" <petero2@telia.com>
From: balagi@justmail.de
Subject: Re: Re: [PATCH 2/2] 2.6.19-rc1-mm1 pktcdvd: bio write congestion
Cc: linux-kernel@vger.kernel.org
X-Priority: 3
X-Abuse: 300631278 / unknown, unknown
User-Agent: freenetMail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1GZO8u-0006bn-VJ@www14.emo.freenet-rz.de>
Date: Mon, 16 Oct 2006 10:48:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the congestion control will work with both code changes, but i am
not sure, if using clear_queue_congested() and blk_congestion_wait()
is the right thing to use here: it works on global level. Any other
thread/driver/etc. can do a clear_queue_congested() and wake
up anyone waiting on this global write or read wait queue, resulting to
unneeded task switches.
The driver local solution (own waitqueue) would prevent this.....

-Thomas Maier


----- original Nachricht --------

Betreff: Re: [PATCH 2/2] 2.6.19-rc1-mm1 pktcdvd: bio write congestion
Gesendet: So 15 Okt 2006 20:16:31 CEST
Von: "Jens Axboe"<jens.axboe@oracle.com>

> On Sat, Oct 14 2006, Peter Osterlund wrote:
> > "Thomas Maier" <balagi@justmail.de> writes:
> > 
> > > Hello,
> > > 
> > > this adds a bio write queue congestion control
> > > to the pktcdvd driver with fixed on/off marks.
> > > It prevents that the driver consumes a unlimited
> > > amount of write requests.
> > 
> > Thanks, this looks good in principle, but I think it can be
> > implemented in a simpler way.
> > 
> > Jens, can I please ask your opinion. Would it make sense to export the
> > clear_queue_congested() and set_queue_congested() functions in
> > ll_rw_blk.c so that the pktcdvd driver can use them? Something like
> > this patch from a few years ago:
> > 
> >        
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109378210610508&w=2
> 
> It definitely would. Did you test, and did it work well for you? I think
> it's the right approach.
> 
> -- 
> Jens Axboe
> 
> 

--- original Nachricht Ende ----









