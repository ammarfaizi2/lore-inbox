Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVCXVje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVCXVje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCXVje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:39:34 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:20569 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261467AbVCXVjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Or+edyheBwXwrTSKWElPGHe4ltV6xS5Hq/uIhO+dsL4zweAP3SgPk66sDIsg6wRB3TSPxyQi5c7ExyDU+yAq119qwO/ta47Ie/jQCrn9Id0E1iHRKYDqaEFG0ypWv9v0GfNjijzD4iMXD8MR0qDBJhHpodnmbikVPR9u0ehyJJU=
Message-ID: <d120d5000503241339b0b5312@mail.gmail.com>
Date: Thu, 24 Mar 2005 16:39:31 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/input/serio/libps2.c: ps2_command: add a missing check
Cc: linux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050324212602.GD3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050324031447.GY1948@stusta.de>
	 <200503240013.16573.dtor_core@ameritech.net>
	 <20050324212602.GD3966@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 22:26:02 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Mar 24, 2005 at 12:13:16AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 23 March 2005 22:14, Adrian Bunk wrote:
> > > The Coverity checker noted that while all other uses of param in
> > > ps2_command() were guarded by a NULL check, this one wasn't.
> > >
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > >
> > > --- linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c.old      2005-03-24 02:37:08.000000000 +0100
> > > +++ linux-2.6.12-rc1-mm1-full/drivers/input/serio/libps2.c  2005-03-24 02:38:28.000000000 +0100
> > > @@ -106,9 +106,10 @@ int ps2_command(struct ps2dev *ps2dev, u
> > >                     command == PS2_CMD_RESET_BAT ? 1000 : 200))
> > >                     goto out;
> > >
> > > -   for (i = 0; i < send; i++)
> > > -           if (ps2_sendbyte(ps2dev, param[i], 200))
> > > -                   goto out;
> > > +   if (param)
> > > +           for (i = 0; i < send; i++)
> > > +                   if (ps2_sendbyte(ps2dev, param[i], 200))
> > > +                           goto out;
> > >
> >
> > I somewhat disagree on this one. If caller specified that command requires
> > arguments to be sent and it does not provide them I'd rather had it OOPS on
> > the spot. With receiving, however, caller does not really have control over
> > number of characters coming from the device so specifying NULL allows just
> > ignore whatever response there is.
> 
> Understood.
> 
> Could this be handled with a BUG_ON?
>

Yes, if it will make the checker happy. Although I (and this is
probably just me) use BUG_ON only if kernel would not OOPS otherwise,
to avoid scribbling over random memory and such.

-- 
Dmitry
