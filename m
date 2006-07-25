Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWGYJuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWGYJuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWGYJuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:50:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31525 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751525AbWGYJuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:50:00 -0400
Date: Tue, 25 Jul 2006 11:24:57 +0200
From: Jens Axboe <axboe@suse.de>
To: gmu 2k6 <gmu2006@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
Message-ID: <20060725092457.GL4044@suse.de>
References: <20060725073208.GA10601@suse.de> <f96157c40607250100x3850ffb7g1d2ed300529661f1@mail.gmail.com> <20060725074107.GA4044@suse.de> <f96157c40607250120s2554cbc6qbd7c42972b70f6de@mail.gmail.com> <20060725080002.GD4044@suse.de> <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com> <20060725080807.GF4044@suse.de> <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com> <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com> <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25 2006, gmu 2k6 wrote:
> On 7/25/06, gmu 2k6 <gmu2006@gmail.com> wrote:
> >On 7/25/06, gmu 2k6 <gmu2006@gmail.com> wrote:
> >> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> >> > On Tue, Jul 25 2006, gmu 2k6 wrote:
> >> > > On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> >> > > >On Tue, Jul 25 2006, gmu 2k6 wrote:
> >> > > >> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> >> > > >> >On Tue, Jul 25 2006, gmu 2k6 wrote:
> >> > > >> >> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> >> > > >> >> >On Mon, Jul 24 2006, gmu 2k6 wrote:
> >> > > >> >> >> the problem I have with hangs is related to changes in CFQ 
> >and that
> >> > > >> >> >> CFQ is now the default. 2.6.17-git12 had the problem but 
> >booting
> >> > > >> >> >> it with elevator=deadline fixes the hang.
> >> > > >> >> >>
> >> > > >> >> >> symptoms encountered during git-bisecting between v2.6.17 
> >and
> >> > > >> >> >v2.6.18-rc1:
> >> > > >> >> >> A hang while starting network services
> >> > > >> >> >> B hang while trying to login
> >> > > >> >> >>   1 on remote console [not SSH] it hang after typing 
> ><uid><CR>
> >> > > >> >> >>   1 via OpenSSH it hang after typing <pwd><CR> when doing 
> >slogin
> >> > > >> >> >root@<IP>
> >> > > >> >> >>
> >> > > >> >> >> A is the problem I got in the first place and this seems to 
> >be the
> >> > > >> >> >> case since 2.6.17-git11 definitely although git-bisect 
> >pointed me
> >> > > >at
> >> > > >> >> >> the following
> >> > > >> >> >> changeset which is included since 2.6.17-git12:
> >> > > >> >> >>
> >> > > >> >> >> caaa5f9f0a75d1dc5e812e69afdbb8720e077fd3
> >> > > >> >> >> by Jens Axboe
> >> > > >> >> >> titled "[PATCH] cfq-iosched: many performance fixes"
> >> > > >> >> >>
> >> > > >> >> >> strange enough it also hangs with 2.6.17-git11 which did not
> >> > > >include
> >> > > >> >that
> >> > > >> >> >> one changeset yet.
> >> > > >> >> >
> >> > > >> >> >So perhaps your bisect isn't 100% trust worthy? Can you do a 
> >manual
> >> > > >> >> >-gitX bisect to see which 2.6.17-gitX introduced the problem?
> >> > > >> >> >
> >> > > >> >> >Also please put a serial console or similar on the machine, 
> >so you
> >> > > >can
> >> > > >> >> >log + store the sysrq+t output.
> >> > > >> >>
> >> > > >> >> well I didn't say that caa....fd3 is the exact change which 
> >broke it,
> >> > > >> >> just that it's related to 1) CFQ changes and 2) CFQ being the 
> >default
> >> > > >> >> now.
> >> > > >> >> I have a Remote Serial Console via HP's integrated Lights-Out 
> >Java
> >> > > >> >> Applet but am not sure how to enable serial console via kernel 
> >boot
> >> > > >> >> params (will try to find out).
> >> > > >> >> I will first try to find the 2.6.17-git* revision working 
> >before
> >> > > >> >> bisecting it against -git11 or git12.
> >> > > >> >
> >> > > >> >Thanks, would be much appreciated to try and narrow it down to a
> >> > > >> >specific fix.
> >> > > >> >
> >> > > >> >Are you seeing the hang on cciss?
> >> > > >>
> >> > > >> I'm not sure it is in the cciss driver, but the SmartArray is 
> >driven by
> >> > > >> cciss.
> >> > > >> starting git<11 boot tests in a minute now.
> >> > > >
> >> > > >Ok, thanks for confirming it's cciss. The bug is likely an 
> >interaction
> >> > > >between cciss and cfq I think, so it would be very useful if you 
> >can pin
> >> > > >point which of the cfq patches make it stall.
> >> > >
> >> > > is there anything special about cciss or did you just deduce that it
> >> > > must be cciss in that particular box and are suspecting interaction
> >> > > problems with that driver and your CFQ changes?
> >> >
> >> > Nothing really special about cciss, but a few months ago I had a 
> >similar
> >> > discussion about cciss and a strange hang.
> >> >
> >> > If possible, please also try a known bad kernel and apply the below
> >> > patch and see if it still reproduces:
> >> >
> >> > diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> >> > index 1c4df22..2b36e7a 100644
> >> > --- a/drivers/block/cciss.c
> >> > +++ b/drivers/block/cciss.c
> >> > @@ -2362,7 +2362,11 @@ static inline void complete_command(ctlr
> >> >         cmd->rq->completion_data = cmd;
> >> >         cmd->rq->errors = status;
> >> >         blk_add_trace_rq(cmd->rq->q, cmd->rq, BLK_TA_COMPLETE);
> >> > +#if 1
> >> > +       cciss_softirq_done(cmd->rq);
> >> > +#else
> >> >         blk_complete_request(cmd->rq);
> >> > +#endif
> >> >  }
> >> >
> >> >  /*
> >>
> >> manually nailed it down to 2.6.17-git7 being the first broken revision.
> >> going to try whether Linus' git tree knows the -git revisions and do a 
> >bisect
> >> otherwise interdiff and looking for CFQ or cciss changes as best I can.
> >
> >oops, doing git-status while running 2.6.17-git6 seems to have locked the 
> >box
> >again :D, ping works though. *sigh*. Jens I will try your cciss.c change 
> >now.
> 
> ok, let's nail it to 2.6.17-git5 instead as it survived git status
> compared to -git6
> which seems to have correctly booted by accident the lastime. timing issues
> I guess.

Then please also try the cciss patch, as suggested.

-- 
Jens Axboe

