Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUEOQNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUEOQNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 12:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUEOQNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 12:13:55 -0400
Received: from mailout01.ims-firmen.de ([213.174.32.96]:2510 "EHLO
	mailout01.ims-firmen.de") by vger.kernel.org with ESMTP
	id S264656AbUEOQNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 12:13:53 -0400
Subject: Re: dma ripping
From: Daniele Bernardini <db@sqbc.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040515145800.GE24600@suse.de>
References: <1084548566.12022.57.camel@linux.site>
	 <20040515101415.GA24600@suse.de> <1084610731.4666.8.camel@linux.site>
	 <20040515145800.GE24600@suse.de>
Content-Type: text/plain
Message-Id: <1084616037.4666.14.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 12:13:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 16:58, Jens Axboe wrote:
> On Sat, May 15 2004, Daniele Bernardini wrote:
> > 
> > On Sat, 2004-05-15 at 12:14, Jens Axboe wrote:
> > > On Fri, May 14 2004, Daniele Bernardini wrote:
> > > > Hi Folks, 
> > > > 
> > > > I am trying to get cd ripping to work on a freshly installed SuSE 9.1 on
> > > > IBM thinkpad R50 with dvdram drive. 
> > > > 
> > > > It works for a while and then hangs. At this point nothing short of a
> > > > reboot works. Ripping stop working when the message 
> > > > 	cdrom: dropping to single frame dma
> > > > comes up. The system feels slow for a couple of seconds and then is back
> > > > to normal, but no ripping until next reboot
> > > > 
> > > > I am running the 2.6.4 compiled by SuSE.
> > > 
> > > Can you retest with this small debug patch applied.
> > > 
> > > --- drivers/cdrom/cdrom.c~	2004-05-15 12:12:24.770228291 +0200
> > > +++ drivers/cdrom/cdrom.c	2004-05-15 12:13:25.101720866 +0200
> > > @@ -1987,6 +1987,7 @@
> > >  			struct request_sense *s = rq->sense;
> > >  			ret = -EIO;
> > >  			cdi->last_sense = s->sense_key;
> > > +			printk("rip failed, sense %x/%x/%x\n", s->sense_key, s->asc, s->ascq);
> > >  		}
> > >  
> > >  		if (blk_rq_unmap_user(rq, ubuf, bio, len))
> > 
> > I did it and started ripping a cd it froze after 9 tracks, though did
> > not see your message. I was looking at /var/log/messages (see below).
> > BTW the system got instable and then froze had to power down. It
> > happened before always after the ripping problem.
> > 
> > Should I aswitch on debug for the cdrom?
> 
> Just an idea - can you log vmstat 5 info while doing this burn? Maybe
> there's still a little leak in there, so watch the ram usage
> (used/free/swap/cache).
> 
> Does your drive have dma enabled?

How do you check if dma is enabled?

BTW it works with ide-scsi, so whatever the problem is must be ide-cd
specific

Ill post the test result later

