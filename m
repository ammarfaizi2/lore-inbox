Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVJ1HFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVJ1HFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVJ1HFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:05:39 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:63149 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965158AbVJ1HFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:05:38 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Date: Fri, 28 Oct 2005 02:05:35 -0500
User-Agent: KMail/1.8.3
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, Greg K-H <greg@kroah.com>
References: <1130481024363@kroah.com> <11304810242953@kroah.com> <20051028065522.GJ27184@lug-owl.de>
In-Reply-To: <20051028065522.GJ27184@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510280205.35866.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 01:55, Jan-Benedict Glaw wrote:
> On Thu, 2005-10-27 23:30:24 -0700, Greg KH <gregkh@suse.de> wrote:
> > diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
> > index 098963c..7f06780 100644
> > @@ -435,14 +434,14 @@ lkkbd_interrupt (struct serio *serio, un
> >  
> >  	switch (data) {
> >  		case LK_ALL_KEYS_UP:
> > -			input_regs (&lk->dev, regs);
> > +			input_regs (lk->dev, regs);
> >  			for (i = 0; i < ARRAY_SIZE (lkkbd_keycode); i++)
> >  				if (lk->keycode[i] != KEY_RESERVED)
> > -					input_report_key (&lk->dev, lk->keycode[i], 0);
> > -			input_sync (&lk->dev);
> > +					input_report_key (lk->dev, lk->keycode[i], 0);
> > +			input_sync (lk->dev);
> >  			break;
> >  		case LK_METRONOME:
> > -			DBG (KERN_INFO "Got LK_METRONOME and don't "
> > +			DBG (KERN_INFO "Got %#d and don't "
> >  					"know how to handle...\n");
> >  			break;
> >  		case LK_OUTPUT_ERROR:
> 
> The format change (%#d) should take an argument on stack, shouldn't
> it? But there's nothing pushed? ...or is it just a typo?
>

I think I messed it up... Was probably trying to do "default" case and then
reverted back. Will fix.

-- 
Dmitry
