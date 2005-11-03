Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVKCCxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVKCCxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVKCCxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:53:13 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:63931 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1030276AbVKCCxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:53:13 -0500
Message-ID: <38523.192.168.0.12.1130986361.squirrel@192.168.0.2>
In-Reply-To: <20051102213354.GO23316@pengutronix.de>
References: <20051101234459.GA443@elf.ucw.cz>
    <20051102202622.GN23316@pengutronix.de>
    <20051102211334.GH23943@elf.ucw.cz>
    <20051102213354.GO23316@pengutronix.de>
Date: Wed, 2 Nov 2005 20:52:41 -0600 (CST)
Subject: Re: best way to handle LEDs
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Robert Schwebel" <robert@schwebel.de>
Cc: "Pavel Machek" <pavel@suse.cz>,
       "Robert Schwebel" <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, "kernel list" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk@arm.linux.org.uk>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, November 2, 2005 3:33 pm, Robert Schwebel said:
> On Wed, Nov 02, 2005 at 10:13:34PM +0100, Pavel Machek wrote:
>> We have some leds that are *not* on GPIO pins (like driven by
>> ACPI). We'd like to support those, too.
>
> One more argument to have a LED framework which sits ontop of a lowlevel
> one.
>

Except the led code that is being proposed CAN sit on top of a generic
GPIO layer.  If a generic GPIO layer is created, you can create a led
driver that calls out to that GPIO layer.

You just need to fill in the following functions with some that raise and
lower the GPIO on the correct line....

int (*color_get)(struct device *, struct led_properties *props);
void (*color_set)(struct device *, struct led_properties *props, int value);

int (*brightness_get)(struct device *, struct led_properties *props);
void (*brightness_set)(struct device *, struct led_properties *props, int
value);

John

