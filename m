Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbUJ0FrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUJ0FrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUJ0FrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:47:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:640 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S261653AbUJ0FrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:47:08 -0400
Date: Wed, 27 Oct 2004 07:47:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Input: sunkbd concern
Message-ID: <20041027054706.GA1211@ucw.cz>
References: <200410221833.04057.dtor_core@ameritech.net> <20041026180622.14fc6268.davem@davemloft.net> <200410262032.27938.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410262032.27938.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:32:27PM -0500, Dmitry Torokhov wrote:
> On Tuesday 26 October 2004 08:06 pm, David S. Miller wrote:
> > On Fri, 22 Oct 2004 18:33:04 -0500
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > 
> > > I have been looking at sunkbd.c and it seems that it attaches not only to
> > > ports that speak SUNKBD protocol but also to ports that do not specify any
> > > protocol:
> > > 
> > > 	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
> > > 		return;
> > > 
> > > Was that an oversight or it was done intentionally?
> > 
> > I believe it is intentional.
> > 
> > If SERIO_PROTO bits are all clear, this is supposed to have
> > a special meaning in that any keyboard driver can claim
> > the serio line.
> > 
> > So if it's the "wildcard" zero value, or specifically SERIO_SUNKBD,
> > we'll attach to it.
> > 
> 
> I would buy if I see another keyboard doing this, but so far only sunkbd
> does this. The rest of keyboards connecting to a RS232-type ports require
> exact protocol match...
> 
> The background is that I am trying to create a bus "match" function for
> serio and trying to understand the requirements... 
 
IIRC my intention was that if the driver can autoprobe for the device,
it shouldn't require 'inputattach' to specify the protocol, which is the
case of sunkbd, but not other serial port keyboards.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
