Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTFYCNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 22:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFYCNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 22:13:37 -0400
Received: from user-vc8fdp3.biz.mindspring.com ([216.135.183.35]:27655 "EHLO
	mail.nateng.com") by vger.kernel.org with ESMTP id S263459AbTFYCNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 22:13:35 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: mail.nateng.com
Date: Tue, 24 Jun 2003 19:27:14 -0700 (PDT)
From: Sir Ace <chandler@nateng.com>
X-X-Sender: chandler@jordan.eng.nateng.com
To: linux-kernel@vger.kernel.org
Subject: Re: i2c fix?
In-Reply-To: <Pine.LNX.4.53.0306241855410.596@jordan.eng.nateng.com>
Message-ID: <Pine.LNX.4.53.0306241926100.596@jordan.eng.nateng.com>
References: <Pine.LNX.4.53.0306241821230.596@jordan.eng.nateng.com>
 <Pine.LNX.4.53.0306241836510.596@jordan.eng.nateng.com>
 <Pine.LNX.4.53.0306241843570.596@jordan.eng.nateng.com>
 <Pine.LNX.4.53.0306241850070.596@jordan.eng.nateng.com>
 <Pine.LNX.4.53.0306241855410.596@jordan.eng.nateng.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I doubled the original lines to this:
#define I2C_ALGO_MAX    8               /* control memory consumption   */
#define I2C_ADAP_MAX    32
#define I2C_DRIVER_MAX  32
#define I2C_CLIENT_MAX  64
#define I2C_DUMMY_MAX 8

and it did not fix my problem....  This is starting to appear
non-trivial..

Help?

  -- Sir Ace

On Tue, 24 Jun 2003, Sir Ace wrote:

>
> Ok, wrong again, the line directly above it:
> #define I2C_ALGO_MAX    4               /* control memory consumption   */
>
> That is my problem, so is it safe to up that value.
>   {Yes my final answer}
>
> {grin}
>
>   -- Sir Ace
>
> On Tue, 24 Jun 2003, Sir Ace wrote:
>
> >
> > Man how many times can I reply to my own post?
> > Anyway I found this:
> >
> > linux/i2c.h:#define I2C_ADAP_MAX        16
> >
> > Is there a danger is setting it to say 32?
> > {or 31 if there is a high bit problem}?
> >
> >
> >
> > On Tue, 24 Jun 2003, Sir Ace wrote:
> >
> > >
> > > Nope sory, that was wrong... I should have read the rest of the code...
> > > Any ideas yet? {grin}
> > >
> > > On Tue, 24 Jun 2003, Sir Ace wrote:
> > >
> > > >
> > > > It looks like the offending code might be in:
> > > > i2c-algo-bit.c
> > > >
> > > > in function:
> > > > static int test_bus(struct i2c_algo_bit_data *adap, char* name) {
> > > >
> > > >
> > > > I'm no coder but it looks like it is limited to 4 devices as a hardcode?
> > > > anyone know of a way to do it so that it does:
> > > >
> > > > for x := {n devices} do
> > > >   crap
> > > >
> > > > On Tue, 24 Jun 2003, Sir Ace wrote:
> > > >
> > > > >
> > > > > I have 5 vidcapture cards, all of which show up in /proc/pci
> > > > > Only the first 4 show up in /proc/bus/i2c*
> > > > >
> > > > > I tried this on 2 completely unidentical systems, and both 2.4.21, and
> > > > > 2.4.20
> > > > >
> > > > > I verified that all 5 cards are actually good... {before people start
> > > > > pointing fingers}
> > > > >
> > > > > Where do I need to start looking to fix it?
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > >
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
