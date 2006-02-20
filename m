Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWBTWCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWBTWCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWBTWCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:02:12 -0500
Received: from styx.suse.cz ([82.119.242.94]:2470 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932631AbWBTWCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:02:10 -0500
Date: Mon, 20 Feb 2006 23:02:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: pc keyboard driver spewing "Unknown key released"
Message-ID: <20060220220217.GA31968@suse.cz>
References: <20060220210240.GA15408@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220210240.GA15408@kvack.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:02:40PM -0500, Benjamin LaHaise wrote:

> With 2.6.16-rc4 on my laptop, I seem to be getting a lot of the following 
> spewed onto the console.  It's not reproducible on demand, but seems to be 
> related to multi-key press/release sequences when banging away a bit too 
> quickly...
> 
> 		-ben
> 
> atkbd.c: Unknown key released (translated set 2, code 0x7f on isa0060/serio0).
> atkbd.c: Use 'setkeycodes 7f <keycode>' to make it known.
 
Interesting. This is the '0xff' code sent by the keyboard (meaning "I'm
confused, someone pressed too many keys or is banging on me way too
quickly - I don't guarantee to send all keypresses or keyreleases
anymore") and is interpreted incorrectly by atkbd.c.

It should spew a different message ("Too many keys pressed") to your
console. 

If you can, please enable debugging for i8042, using

	echo -n 1 > /sys/module/i8042/parameters/debug

then try to reproduce it, and send your 'dmesg' to me.

-- 
Vojtech Pavlik
Director SuSE Labs
