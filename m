Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUI1HTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUI1HTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 03:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUI1HTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 03:19:21 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:15972 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267601AbUI1HTT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 03:19:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG: 2.6.9-rc2-bk11] input completely dead in X
Date: Tue, 28 Sep 2004 02:19:16 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Micha Feigin <michf@post.tau.ac.il>,
       Peter Osterlund <petero2@telia.com>
References: <20040926210450.GA2960@luna.mooo.com> <200409280126.19919.dtor_core@ameritech.net> <20040928070107.GC1834@ucw.cz>
In-Reply-To: <20040928070107.GC1834@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409280219.16976.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 02:01 am, Vojtech Pavlik wrote:
> On Tue, Sep 28, 2004 at 01:26:19AM -0500, Dmitry Torokhov wrote:
> > Resending as I forgot to CC Vojtech and Peter first time around...
> > 
> > On Monday 27 September 2004 10:46 pm, Micha Feigin wrote:
> > > > Or better yet, use the auto-dev feature, which should work if you have
> > > > a new enough X driver and kernel patch.
> > > > 
> > > 
> > > auto-dev doesn't work for me and I don't have time to check it
> > > out.
> > 
> > Addition of Kensington ThinkingMouse / ExpertMouse support caused Synaptics
> > and ALPS protocol numbers to move to 8 and 9 respectively which broke Peter's
> > auto-dev detection. 
> 
> Ouch. I suspected something bad will happen.
> 
> > Vojtech, we need to keep protcol numbers stable, I propose something like this:
> > 
> > enum psmouse_type {
> >         PSMOUSE_PS2             = 0,
> >         PSMOUSE_PS2PP,
> >         PSMOUSE_THINKPS,
> >         PSMOUSE_GENPS           = 64,   /* 4 byte protocol start */
> >         PSMOUSE_IMPS,
> >         PSMOUSE_IMEX,
> >         PSMOUSE_SYNAPTICS       = 128,  /* 5+ byte protocols start */
> >         PSMOUSE_ALPS,
> > };
> 
> No, we really need to keep backwards compatibility with the numbering
> here and solve the packetsize issue elsewhere. Probably the best would
> be for each of the protocols to have its own packet collection routine,
> like the Synaptics and ALPS already have. It could be shared among the
> simpler protocols.
> 
> We'll need this anyway for a heuristic resynchronizer.
>

Ok, for now I am killing PS2TPP which is not really useful and will allow
THINKPS take it's spot moving SYNAPTICS and ALPS to their former numbers. 

-- 
Dmitry
