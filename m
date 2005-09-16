Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbVIPPZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbVIPPZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbVIPPZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:25:16 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:60751 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161152AbVIPPZP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:25:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NFhmeAfSi5IZAlz4Psc+kaUR01lltia5Goy2wPRy0mlKXnSZbtwcymjsDHPxISz8it8e7Zjf/tw5ipRtQ0kRtGBB8xzTXeV1J816/9xbIGMXFxVpv8aP4Z3A3xkXHJwHLPkPT7WZH/DAwYjlsGsuEWFoNXLBZw/tGnS0uJm2reI=
Message-ID: <d120d500050916082519c660e6@mail.gmail.com>
Date: Fri, 16 Sep 2005 10:25:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
Cc: linux-kernel@vger.kernel.org, caphrim007@gmail.com
In-Reply-To: <20050916025356.0d5189a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432A4A1F.3040308@gmail.com>
	 <200509152357.58921.dtor_core@ameritech.net>
	 <20050916025356.0d5189a6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Andrew Morton <akpm@osdl.org> wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > On Thursday 15 September 2005 23:29, Tim Rupp wrote:
> > > I just recently went to upgrade to 2.6.13 from 2.6.12.3 and after
> > > re-compiling with a clean .config, I've hit a snag.
> > >
> > > I'm pretty sure I've got the config script down right, but upon reboot,
> > > I no longer have a keyboard.
> > >
> > > I checked to see if this had crept up between 2.6.12.3 and 2.6.13.1. It
> > > seems that >2.6.13 are the versions that do this.
> > >
> > > Attached are dmesgs from my 2.6.13.1 and 2.6.12.3 kernels. In the
> > > 2.6.13.1 kernel I noticed this line.
> > >
> > >     i8042.c: Can't read CTR while initializing i8042
> > >
> >
> > The kernel failed to talk to your keyboard controller. Try booting with
> > "usb-handoff" and also try "acpi=off"
> >
> 
> This is of course not an acceptable solution.  A machine which worked
> without funky commandline parameters should continue to work in later
> kernels.
> 
> How come it broke?
> 

Interdependencies between ACPI, PNP, USB Legacy emulation and I8042 is
very delicate and quite often changes in ACPI/PNP break that balance.
USB legacy emulation is just evil. We need to have "usb-handoff" thing
enabled by default, it fixes alot of problems.

-- 
Dmitry
