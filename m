Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbTHHOBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271356AbTHHOBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:01:20 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6272 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S271353AbTHHOBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:01:17 -0400
Date: Fri, 8 Aug 2003 15:09:04 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308081409.h78E94k5000239@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, zippel@linux-m68k.org
Subject: Re: 2.6: Problem multiple bool/tristate prompts
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My problem isn't that important to satisfy such a complicated construct,
> > I can accept that there's no easy way to express this and live without
> > it.
>
> Dynamically changing the symbol type isn't possible and usally not needed, 
> if the driver can't be compiled as module, it has to use 'bool'. I'm 
> planning to add tags (e.g. for EXPERIMENTAL), maybe in this context it 
> will be easier, to better classify the brokenness of a driver, but this 
> will definitively not happen for 2.6.

Couldn't each config option simply have a flags byte, thus:

00000000
||||||||
|||||||\ Not applicable to servers
||||||\- Not applicable to desktops
|||||\-- Not applicable to embedded systems
||||\--- Not extensively tested by developers
|||\---- Not extensively tested by end users
||\----- Obsolete
|\------ Appears to compile, but known to be broken in a subtle way
\------- Does not copmile

Then we could just have a menu with:

[X] Exclude options not applicable to servers
[X] Exclude options not applicable to desktops
[X] Exclude options not applicable to embedded systems
[X] Exclude options not extensively tested by developers
[X] Exclude options not extensively tested by endusers *
[X] Exclude options marked as obsolete
[X] Exclude options which compile, but are actually broken
[X] Exclude non-compiling options

* I.E. what is currently CONFIG_EXPERIMENTAL

The flags byte could be optional, with a default value of 0.

Seems more practical than using config options, and it would make some
interesting statistics easily available.

John.
