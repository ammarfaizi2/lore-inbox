Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTIZGUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTIZGUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:20:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:9862 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261962AbTIZGUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:20:50 -0400
Date: Fri, 26 Sep 2003 08:20:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, akpm@osdl.org, dtor_core@ameritech.net,
       petero2@telia.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Extend KD?BENT to handle > 256 keycodes.
Message-ID: <20030926062018.GA5313@ucw.cz>
References: <10645086121089@twilight.ucw.cz> <1064508612197@twilight.ucw.cz> <20030925233837.GA21764@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925233837.GA21764@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 01:38:37AM +0200, Andries Brouwer wrote:
> On Thu, Sep 25, 2003 at 06:50:12PM +0200, Vojtech Pavlik wrote:
> 
> > -struct kbentry {
> > +struct kbentry_old {
> >  	unsigned char kb_table;
> >  	unsigned char kb_index;
> >  	unsigned short kb_value;
> >  };
> > +#define KDGKBENT_OLD	0x4B46	/* gets one entry in translation table (old) */
> > +#define KDSKBENT_OLD	0x4B47	/* sets one entry in translation table (old) */
> > +
> > +struct kbentry {
> > +	unsigned int kb_table;
> > +	unsigned int kb_index;
> > +	unsigned short kb_value;
> > +};
> 
> > -#define KDGKBENT	0x4B46	/* gets one entry in translation table */
> > -#define KDSKBENT	0x4B47	/* sets one entry in translation table */
> > +#define KDGKBENT	0x4B73	/* gets one entry in translation table */
> > +#define KDSKBENT	0x4B74	/* sets one entry in translation table */
> 
> Please don't.
> 
> As said already, no new ioctls are needed today,

Well, as already said, there are two ways to go:

1) Keep NR_KEYS at 512 (or more in the future, iff needed), and have new
   ioctls.

2) Decrease NR_KEYS to 256 or better 255 or 254, so that for() cycles
   don't break because of limited range of the iterator, and optimize the
   KEY_* macros in input.h to fit in that range.

   This however means moving some already #defined macros to other values,
   which hopefully is not too big a problem, as few are using it.

   And it's likely we overflow the 254 entries soon, nevertheless, so we
   will need the new ioctls anyway.

> but if you add some anyway, please leave old names unchanged and add
> something new, like KDSKBENT32 or so.
> 
> Reusing old ioctl names for new uses is very bad practice.

Ok, I'm willing to give approach #2 a chance. But I'll need help from
you - as you have the most extensive list of extended keyboards - would
you please help me by creating a list of most used (and most standard)
keys on those keyboards and scancodes (unxlated set2) associated with
those?  

I'd then add what USB and Sun and others use and this way we should be
able to trim down the amount of defined keys down a bit.

I'm postponing the KD?KBENT patch for the moment ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
