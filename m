Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUIVFHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUIVFHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 01:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIVFHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 01:07:45 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28549 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S263448AbUIVFHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 01:07:43 -0400
Date: Wed, 22 Sep 2004 07:07:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dylan@ultimation.org
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support for Snapstream Firefly remote added to ati_remote.c
Message-ID: <20040922050721.GA4532@ucw.cz>
References: <12361.69.25.132.5.1095791755.squirrel@69.25.132.5> <20040921190710.GA4237@ucw.cz> <16359.69.25.132.5.1095795335.squirrel@69.25.132.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16359.69.25.132.5.1095795335.squirrel@69.25.132.5>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 12:35:35PM -0700, dylan@ultimation.org wrote:

> >> @@ -460,6 +479,7 @@ static void ati_remote_input_report(stru
> >>         struct input_dev *dev = &ati_remote->idev;
> >>         int index, acc;
> >>         int remote_num;
> >> +       int ev_type;
> >>
> >>         /* Deal with strange looking inputs */
> >>         if ( (urb->actual_length != 4) || (data[0] != 0x14) ||
> >> @@ -492,7 +512,9 @@ static void ati_remote_input_report(stru
> >>
> >>         if (ati_remote_tbl[index].kind == KIND_LITERAL) {
> >>                 input_regs(dev, regs);
> >> -               input_event(dev, ati_remote_tbl[index].type,
> >> +
> >> +               ev_type = ((disable_keyboard) ? 0 : >
> >> ati_remote_tbl[index].type);
> >> +               input_event(dev, ev_type,
> >>                         ati_remote_tbl[index].code,
> >>                         ati_remote_tbl[index].value);
> >>                 input_sync(dev);
> >
> > I won't let you abuse the input API this way. Event type 0 is EV_SYN and
> > is reserved for synchronization and configuration change notifications.
> > Definitely not for sending events that look like keystrokes but aren't.
> >
> > There is a nice ioctl, called EVIOCGRAB which will give you what you
> > want (the console won't be receiving the events anymore) without any
> > ugly hacks.
> >
> 
> Sorry for the hacks, I'm still learning about how this all works. I was
> just excited that I was able to get it "work" at all, even if it was
> really ugly. ;)  I'll look into EVIOCGRAB and touch up the patch before
> thinking about resubmitting again. Thanks for the input!
 
Ok, I'll be looking forward to your patch. :)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
