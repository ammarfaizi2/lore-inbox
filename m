Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVJ2F7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVJ2F7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJ2F7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:59:42 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:17576 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751356AbVJ2F7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:59:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Date: Sat, 29 Oct 2005 00:59:36 -0500
User-Agent: KMail/1.8.3
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, Greg K-H <greg@kroah.com>
References: <1130481024363@kroah.com> <20051028065522.GJ27184@lug-owl.de> <200510280205.35866.dtor_core@ameritech.net>
In-Reply-To: <200510280205.35866.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510290059.37135.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 02:05, Dmitry Torokhov wrote:
> On Friday 28 October 2005 01:55, Jan-Benedict Glaw wrote:
> > On Thu, 2005-10-27 23:30:24 -0700, Greg KH <gregkh@suse.de> wrote:
> > > diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
> > > index 098963c..7f06780 100644
> > > @@ -435,14 +434,14 @@ lkkbd_interrupt (struct serio *serio, un
> > >  
> > >  	switch (data) {
> > >  		case LK_ALL_KEYS_UP:
> > > -			input_regs (&lk->dev, regs);
> > > +			input_regs (lk->dev, regs);
> > >  			for (i = 0; i < ARRAY_SIZE (lkkbd_keycode); i++)
> > >  				if (lk->keycode[i] != KEY_RESERVED)
> > > -					input_report_key (&lk->dev, lk->keycode[i], 0);
> > > -			input_sync (&lk->dev);
> > > +					input_report_key (lk->dev, lk->keycode[i], 0);
> > > +			input_sync (lk->dev);
> > >  			break;
> > >  		case LK_METRONOME:
> > > -			DBG (KERN_INFO "Got LK_METRONOME and don't "
> > > +			DBG (KERN_INFO "Got %#d and don't "
> > >  					"know how to handle...\n");
> > >  			break;
> > >  		case LK_OUTPUT_ERROR:
> > 
> > The format change (%#d) should take an argument on stack, shouldn't
> > it? But there's nothing pushed? ...or is it just a typo?
> >
> 
> I think I messed it up... Was probably trying to do "default" case and then
> reverted back. Will fix.
> 

That's what I wanted to do...

-- 
Dmitry

Input: lkkbd - consolidate messages in lkkbd_interrup()

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/lkkbd.c |   28 +++++-----------------------
 1 files changed, 5 insertions(+), 23 deletions(-)

Index: work/drivers/input/keyboard/lkkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/lkkbd.c
+++ work/drivers/input/keyboard/lkkbd.c
@@ -440,38 +440,20 @@ lkkbd_interrupt (struct serio *serio, un
 					input_report_key (lk->dev, lk->keycode[i], 0);
 			input_sync (lk->dev);
 			break;
+
 		case LK_METRONOME:
-			DBG (KERN_INFO "Got %#d and don't "
-					"know how to handle...\n");
-			break;
 		case LK_OUTPUT_ERROR:
-			DBG (KERN_INFO "Got LK_OUTPUT_ERROR and don't "
-					"know how to handle...\n");
-			break;
 		case LK_INPUT_ERROR:
-			DBG (KERN_INFO "Got LK_INPUT_ERROR and don't "
-					"know how to handle...\n");
-			break;
 		case LK_KBD_LOCKED:
-			DBG (KERN_INFO "Got LK_KBD_LOCKED and don't "
-					"know how to handle...\n");
-			break;
 		case LK_KBD_TEST_MODE_ACK:
-			DBG (KERN_INFO "Got LK_KBD_TEST_MODE_ACK and don't "
-					"know how to handle...\n");
-			break;
 		case LK_PREFIX_KEY_DOWN:
-			DBG (KERN_INFO "Got LK_PREFIX_KEY_DOWN and don't "
-					"know how to handle...\n");
-			break;
 		case LK_MODE_CHANGE_ACK:
-			DBG (KERN_INFO "Got LK_MODE_CHANGE_ACK and ignored "
-					"it properly...\n");
-			break;
 		case LK_RESPONSE_RESERVED:
-			DBG (KERN_INFO "Got LK_RESPONSE_RESERVED and don't "
-					"know how to handle...\n");
+			DBG (KERN_INFO
+			     "Got 0x%02x and don't know how to handle...\n",
+			     data);
 			break;
+
 		case 0x01:
 			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
 			lk->ignore_bytes = LK_NUM_IGNORE_BYTES;
