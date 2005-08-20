Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVHTXd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVHTXd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 19:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVHTXd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 19:33:59 -0400
Received: from web30311.mail.mud.yahoo.com ([68.142.201.229]:14984 "HELO
	web30311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750719AbVHTXd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 19:33:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=azPL5c+A3vXcIGN2SpyV1vmlkeEUZAKYoK5iglSKAiEzO2H1qFFWvz6RsOl/ssYtTVroF+I/4+AaIkKAI8+ggxvoji1edAoyqLN07mQlBasAOeSsy5+oVvLZ5zeQVKo921oZIoS9q9xKCYeWRhxd7b67lajs0ufpJ8T+bOLd3Gg=  ;
Message-ID: <20050820233348.40226.qmail@web30311.mail.mud.yahoo.com>
Date: Sun, 21 Aug 2005 00:33:48 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH 0/5] improve i2c probing
To: David Brownell <david-b@pacbell.net>,
       Nathan Lutchansky <lutchann@litech.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050820174648.650B8E3259@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interestingly (we for me at least ;-) I have been
working on an SPI subsystem that was/is a copy of the
I2C subsystem with changes as SPI doesn’t have a
protocol like I2C. I am at the stage of tidying up the
structures in the head files and looking at where they
are used in the core layer.
To me, what I have, like I2C, doesn’t tie in very well
with the new driver model (although I’m not overly
familiar with it, I think I finally understand
platform devices :-). The current I2C core layer seems
to be only registering a bus type and devices so you
can see them in sysfs as none of the functions seem to
do anything.
I wonder how much work the new kernel subsystems can
do for us to cut down the size of i2c-core (and thus
also spi-core).
I guess there is no escaping the fact that I’m going
to gave to do some more homework and study the code.
Any thoughts or insights would be very welcome.

Mark

--- David Brownell <david-b@pacbell.net> wrote:

> Hmm, some of this resembles my prototype from last
> month:
> 
>   
>
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013012.html
> 
> Both ended up with new driver probe() methods
> attaching to *devices* not
> to busses, and used the probe signature the i2c core
> already handles.
> That helps eliminate one of the surprises hitting
> anyone starting to use
> the I2C driver stack.  But not the more fundamental
> one...
> 
> What would you think about actually making I2C
> probing work more like
> standard driver model probing, instead?  That is,
> have the probe method
> signature look like this:
> 
>     int probe(struct i2c_client *dev, void
> *driver_data)
> 
> In normal driver model usage, infrastructure creates
> the devices, and the
> device drivers just bind to them.  But I2C doesn't
> support that even for
> the submodel where it's very appropriate:  devices
> that have been probed,
> or which (as with platform_bus) were explicitly
> declared to exist.
> 
> I2C drivers would either continue the old school way
> ... or could start
> acting more like they do in other mainstream Linux
> driver frameworks.
> 
> - Dave
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
