Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSFZRu1>; Wed, 26 Jun 2002 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSFZRu0>; Wed, 26 Jun 2002 13:50:26 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:27397 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S316747AbSFZRuX>;
	Wed, 26 Jun 2002 13:50:23 -0400
Subject: Re: max_scsi_luns and 2.4.19-pre10.
From: Austin Gonyou <austin@digitalroadkill.net>
To: Kurt Garloff <garloff@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <20020626160745.GF3023@gum01m.etpnet.phys.tue.nl>
References: <1025052385.19462.5.camel@UberGeek>
	 <20020626123337.GC1217@gum01m.etpnet.phys.tue.nl>
	 <1025101125.19558.4.camel@UberGeek>
	  <20020626160745.GF3023@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 26 Jun 2002 12:50:19 -0500
Message-Id: <1025113819.22762.5.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 11:07, Kurt Garloff wrote:
> Hi Austin,
> 
> On Wed, Jun 26, 2002 at 09:18:45AM -0500, Austin Gonyou wrote:
> > On Wed, 2002-06-26 at 07:33, Kurt Garloff wrote:
> > > enough guesses have been there not answering your questions ...
> > 
> > Sure I hear that. But I posted an earlier question about QLA2200 and a
> 
> You don't think that somebody who reads your message and tries to post a
> helpful comment scans the list for earlier messages of yours, do you?
> 
Well, I do, especially if someone says it's an urgent thing to try and
get the whole story. If I don't have time, I'll ask someone to give more
info, which you did and I respect that and thank you.

> > PV 660F and not seeing > 8 luns with 2.4.19-pre10.
>   ^^^^^^^
> 
> This device needs BLIST_LARGELUN.

I got that from your earlier post and addressed it directly. Thanks for
the pointer. I didn't know the 660 was defined explicitly in the
scsi_scan.c I've since recompiled several kernel versions to assert this
as being true with the BLIST_LARGELUN option and it's definitely fixed
my problems there.

> > I'll take a look at that, and see if I can merge it into -aa4. 
> 
> The patch should be in there, just not the additional devices that need
> BLIST_LARGELUN.
> 
> > > The flag does allow a device to use more than 8 LUNs despite it reporting
> > > as SCSI Version 2 devices (which can not support more than 8 LUNs normally
> > > ...) 
> > > The flag also needs to be set for some more devices, look for DGC, DELL, CMD
> > > and CNSi/CNSI devices that already have the BLIST_SPARSELUN flag.
> > 
> > This would be a DELL device, so I'll see about changing it from
> > SPARESLUN to LARGELUN?
> 
> No. Add " | BLIST_LARGELUN" .


Yep, Did that. Again Thanks!

> > > But as you did not post the output of /proc/scsi/scsi nor the syslog
> > > meesages from your SCSI subsystem nobody knows what devices you're using or
> > > what actually happens. Just speculations ...
> > 
> > There's nothing to post from /proc/scsi/scsi or the syslog other than
> > there's no more than 8 devices on my FC chain. I guess the real point
> > here is that if you're using FC, you're probably going to use more than
> > 8 luns, even if not immediately. Especially for large Databases. 
> 
> People could have seen what SCSI device you're using.
> So I could have told you instead of guessing and risking to add to the noise
> myself.

I hear you loud and clear. I wouldn't have made so much noise myself had
it not been a *top* priority item that I couldn't find info on anywhere
else, plus the boss putting pressure too. Soon, this system will be a
6650 with PV 660F, 8GB RAM, using Linux with Oracle8.1.7.2, XFS, 0(1)
scheduler and nearly a TB of total DB. 

I have some results from my benchmarking which are quite astounding too.


> Regards,
> -- 
> Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
> GPG key: See mail header, key servers         Linux kernel development
> SuSE Linux AG, Nuernberg, DE                            SCSI, Security
-- 
Austin Gonyou <austin@digitalroadkill.net>
