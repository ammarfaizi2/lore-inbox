Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbTCOUO0>; Sat, 15 Mar 2003 15:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTCOUOZ>; Sat, 15 Mar 2003 15:14:25 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51912 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261508AbTCOUOV>;
	Sat, 15 Mar 2003 15:14:21 -0500
Date: Sat, 15 Mar 2003 21:25:09 +0100
From: bert hubert <ahu@ds9a.nl>
To: dan carpenter <d_carpenter@sbcglobal.net>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, wrlk@riede.org
Subject: Re: Any hope for ide-scsi (error handling)?
Message-ID: <20030315202509.GA4374@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	dan carpenter <d_carpenter@sbcglobal.net>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, wrlk@riede.org
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com> <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net> <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com> <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 03:52:21AM +0100, dan carpenter wrote:
> > >
> > >    887          spin_lock_irqsave(&ide_lock, flags);
> > >    888          while (HWGROUP(drive)->handler) {
> > >    889                  HWGROUP(drive)->handler = NULL;
> > >    890                  schedule_timeout(1);
> > >    891          }
> > >
> > > Here is at least one bad call to schedule() in
> > > static int idescsi_reset (Scsi_Cmnd *cmd)
> >
> > Apart from the schedule with the ide_lock held, what is that code actually
> > doing?
> >
> > 	Zwane
> 
> Hm...  Good question.  I have no idea what the while loop is for.

A construct like this was suggested for use in swsusp too to make sure that
only *one* request is outstanding for a controler. This was also mentioned
to be the unclean way and that there are taskfile interfaces which are
cleaner.

Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
