Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTDPTSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbTDPTSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:18:15 -0400
Received: from AMarseille-201-1-5-18.abo.wanadoo.fr ([217.128.250.18]:13095
	"EHLO debian") by vger.kernel.org with ESMTP id S264546AbTDPTSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:18:14 -0400
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304161124400.912-100000@cherise>
References: <Pine.LNX.4.44.0304161124400.912-100000@cherise>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050521391.644.5.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Apr 2003 21:29:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 20:31, Patrick Mochel wrote:

> This is not necessarily a slot-by-slot question, but whether the entire 
> PCI/AGP buses will lose power during the sleep state, right? 

This is really per-slot. Especially on embedded or laptops, you really
don't know how each slot is wired regarding the power planes.

> There are a couple of things to note. 
> 
> This is only an issue when doing suspend-to-RAM. Suspend-to-disk, and
> power-on suspend will definitely lose power and definitely not lose any
> power, respectively. So, you need a mechanism to determine what state the 
> system is entering. 

Yes.

> Next, once you determine that we're entering suspend-to-RAM, you need to
> know if the buses will lose power. In order to have a generic suspend
> sequence, there must be a set of platform-specific methods to do all the
> fun platform things that must be done. In that object, we can easily add a
> flag that specifies whether or not the platform will lose power. This flag
> can be initialized based on platform knowledge on startup.

It's individual to each device though. And we must also have a flag the
platform can use to indicate it can/will re-POST the card (by re-running
the BIOS or whatever firmware)... 

> In short, there should be no problems. Hopefully, I should have something 
> within the week to review/test. (Yeah yeah, talk is cheap, but I'm getting 
> there).

Good :) I'm getting there too for the pmac implementation finally...

Ben.

