Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbTGBWMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGBWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:12:08 -0400
Received: from buerotecgmbh.de ([217.160.181.99]:25489 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S264924AbTGBWME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:12:04 -0400
Date: Thu, 3 Jul 2003 00:26:28 +0200
From: Kay Sievers <lkml001@vrfy.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why does sscanf() does not interpret number length attributes?
Message-ID: <20030702222628.GA15836@vrfy.org>
References: <20030702203433.GA14854@vrfy.org> <Pine.LNX.4.53.0307021644550.26973@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307021644550.26973@chaos>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 04:55:44PM -0400, Richard B. Johnson wrote:
> On Wed, 2 Jul 2003, Kay Sievers wrote:
> 
> > I needed a conversion from hex-string to integer and found
> > this mail from Linus suggesting sscanf:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=101414195507893&w=2
> >
> > but sscanf in linux-2.5/lib/vsprintf.c interpretes length attributes
> > only when the type is a string. It uses simple_strtoul() and it will
> > read the buffer until it finds a non-(hex)digit.
> >
> > int i;
> > char str[] ="34AFFE45XYZ";
> > sscanf(str, "%1x", &i);
> >
> > i will be '0x34AFFE45' instead of the expected '3'.
> >
> > Is this behaviour intended or is just nobody caring about?
> >
> 
> The in-kernel vsprintf() is very primative, used for very simple
> things. Note that it doesn't even have "%f". You should just
> do something like:
> 
> 	i = (int) *str + '0';

And what about hex lowercases ?
Do you meant  "- '0'" :-)


> 
>       ... if you need to read part of a number.
> 
> You don't really wany to increase the size of the permanent
> in-kernel stuff if you can help. You add any increased functionality
> to your modules so it is used only when needed.

Sure, but the length attribute is already available in a var at processing
and all what is needed is one extra parameter for escaping from the char read loop.

i wouldn't call this "increase of permanent stuff".

thanks
Kay
