Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUFAXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUFAXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUFAXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:04:29 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:8294 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265263AbUFAXE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:04:26 -0400
Message-ID: <40BD0B67.4070907@microgate.com>
Date: Tue, 01 Jun 2004 18:04:07 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird M6a (Windows/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 synclink_cs.c
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com> <20040528160612.306c22ab.akpm@osdl.org> <1086123182.2171.15.camel@deimos.microgate.com> <20040601220051.G31301@flint.arm.linux.org.uk>
In-Reply-To: <20040601220051.G31301@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>To put my PCMCIA hat on,
>
Is that the one with a propeller and flashing LEDs?
I'm jealous.

> are you sure you should be registering with
>a subsystem which can cause you to create tty devices before you've
>registered with the tty subsystem?
>
>Eg, what could happen if you register with PCMCIA, PCMCIA hands you
>a card to drive and register a tty for, and you do all of that
>_before_ you've registered with the tty subsystem?
>  
>
Nothing.

Devices can come and go. Until the driver
registers with the tty subsystem they are not
externally accessible.  The driver itself does
nothing tty related until it registers with the
tty subsystem and an external entity opens
the device as a tty device.

I believe what you describe happens with the 1st card insertion:
1. cardmgr loads the driver
2. driver registers with pcmcia
3. pcmcia creates device
4. driver registers with tty

Registering with pcmcia first makes cleanup a little easier
if it fails for some reason. This scheme has worked so far.

--
Paul Fulghum
paulkf@microgate.com

