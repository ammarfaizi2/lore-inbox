Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTHXLiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTHXLiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:38:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43237 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263432AbTHXLiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:38:22 -0400
Date: Sun, 24 Aug 2003 13:32:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0-test3 zoran driver update
Message-ID: <20030824133225.A24289@electric-eye.fr.zoreil.com>
References: <1061414594.1320.97.camel@localhost.localdomain> <20030821010812.A6961@electric-eye.fr.zoreil.com> <1061684006.4302.251.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061684006.4302.251.camel@localhost.localdomain>; from rbultje@ronald.bitfreak.net on Sun, Aug 24, 2003 at 06:23:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje <rbultje@ronald.bitfreak.net> :
[avoid code duplication in {adv7170/adv7175/bt819/saa7111/saa7185}_write_block]
> I'm wondering how. I could make an inline function that each of them
> includes (but that doesn't decrease binary size, code is still
> duplicated), or I could make a parent module (and I don't want to do
> that). The only bad thing of the current way is the maintainance, but I
> don't really mind.

These functions differ only in:

struct XXX *encoder = i2c_get_clientdata(client);
       ^^^
[...]
                        do {
                                block_data[msg.len++] =
                                    encoder->reg[reg++] = data[1];
                                    ^^^^^^^^^ 
[...]
                        if ((ret =
                             XXX_write(client, reg, *data++)) < 0)
                             ^^^^^^^^^

Make i2c_get_clientdata() return a generic container struct which
provides instance specific methods to retrieve the "reg" member and
the XXX_write() function. Init these in XXX_detect_client() just
before i2c_set_clientdata() and it is done.

Patches that remove code used to make Penguin #0 happy. We want an happy
Penguin #0, don't we ? :o)

> Does it matter if I just keep it the way it is right now? I don't really
> mind at all.

Your choice. As a maintainer, you can say "It would be great. Volunteer
anyone ?" and see voluteer appearing.

[...]
> I'm moving some things explicitely to the long-term list, btw, that's on
> purpose. It'd be cool to handle the new DMA/PCI subsystem, but we've got
> many things to work on, some of which are more important than this.

Ok, I'll check http://mjpeg.sourceforge.net/driver-zoran/development.php and
try to kill one or two simple, self-contained, tasks.

[part-time kernel involvement]

Same thing here.

Regards

--
Ueimor
