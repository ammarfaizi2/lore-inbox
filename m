Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVA1AoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVA1AoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVA1AlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:41:23 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:6052 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261347AbVA1AjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:39:09 -0500
Date: Fri, 28 Jan 2005 01:39:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Possible bug in keyboard.c (2.6.10)
In-Reply-To: <20050127125637.GA6010@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.61.0501272248380.6118@scrub.home>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
 <20050127125637.GA6010@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Jan 2005, Andries Brouwer wrote:

> In short - raw mode in 2.6 is badly broken.

I think not just that. The whole keyboard input layer needs some serious 
review. Just the complete lack of any locking is frightening, I'd really 
like to know how the input layer could become the standard. I tried to 
find a few times to find any discussion about the input layer design, but 
I couldn't find anything.

Some of my favourites in the input layer:
- the keyboard sound/led handling: the keyboard driver basically fakes 
events for the device and input_event() is "clever" enough to also tell 
the device about it. This is quite an abuse of event system for general 
device/driver communication.
- a single input device structure for all types: this structure is quite 
big, where most of its contents is irrelevant for most devices.
- fine grained matching/filtering: I have no idea why the input layer has 
to do this down to the single event instead of just the event type.

Vojtech, could you please explain a bit the reason for the above and what 
are your plans to e.g. fix the locking?

bye, Roman
