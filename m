Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTIJN2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTIJN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:28:43 -0400
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:53120 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S263078AbTIJN2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:28:41 -0400
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Adrian Bunk <bunk@fs.tum.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Date: Wed, 10 Sep 2003 15:23:48 +0200
User-Agent: KMail/1.5.3
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de>
In-Reply-To: <20030910110225.GC27368@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101523.48722.s.b.wielinga@student.utwente.nl>
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 September 2003 13:02, Adrian Bunk wrote:
> On Tue, Sep 09, 2003 at 09:40:15PM +1000, Eyal Lebedinsky wrote:
> >...
>
>  In -test4 I have:
> > CONFIG_SERIO=m
> > CONFIG_SERIO_I8042=m
> > CONFIG_SERIO_SERPORT=m
> > CONFIG_SERIO_CT82C710=m
> > CONFIG_SERIO_PARKBD=m
> > CONFIG_SERIO_PCIPS2=m
> >
> > but -test5 insists on:
> >
> > CONFIG_SERIO=m
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_SERPORT=m
> > CONFIG_SERIO_CT82C710=m
> > CONFIG_SERIO_PARKBD=m
> > CONFIG_SERIO_PCIPS2=m
> >
> > Removing the I8042 line and doing 'make oldconfig' does not even
> > ask about it but sets it to '=y'. As a result I get:
> > [...]

This is correct behaviour. Nobody building his kernel for a pc will ever want 
his keyboard not to function until the module is loaded; the 
CONFIG_SERIO_I8042 option is really only there for embedded devices based on 
x86 processors which don't have an i8042 keyboard controller, which is where 
the EMBEDDED option was made for. Modularizing this would effectively disable 
the possibility of booting with init=/bin/sh.

Sytse

> [patch...]

