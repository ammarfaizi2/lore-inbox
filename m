Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVA2EvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVA2EvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVA2EvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:51:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1223 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262852AbVA2Eu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:50:56 -0500
Date: Sat, 29 Jan 2005 04:50:55 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050129045055.GS8859@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home> <20050128105937.GA5963@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128105937.GA5963@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 11:59:37AM +0100, Vojtech Pavlik wrote:
> I'm very sorry about the locking, but the thing grew up in times of
> kernel 2.0, which didn't require any locking. There are a few possible

Incorrect.  You have blocking allocations in critical areas and they
required locking all way back.

> races with device registration/unregistration, and it's on my list to
> fix that, however under normal operation there shouldn't be any need for
> locks, as there are no complex structures built that'd become
> inconsistent. 

Um-hm...  Vojtech, meet USB mouse; USB mouse, meet Vojtech.  Now watch
a disconnect and reconnect happening when luser suddenly gets overexcited
and jerks the wrong hand a bit too hard while browsing the most profitable
sort of website...

> If you find scenarios which will lead to trouble in the event delivery
> system, please tell me, and I'll try to fix that as soon as possible.

See above.  Devices appearing and disappearing *are* normal.  
