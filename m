Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVA1NOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVA1NOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVA1NOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:14:53 -0500
Received: from styx.suse.cz ([82.119.242.94]:58555 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261360AbVA1NOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:14:32 -0500
Date: Fri, 28 Jan 2005 14:17:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Jaco Kroon <jaco@kroon.co.za>,
       sebekpi@poczta.onet.pl, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050128131728.GA11723@ucw.cz>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <20050127202947.GD6010@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127202947.GD6010@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 09:29:47PM +0100, Andries Brouwer wrote:

> > So what _might_ happen is that we write the command, and then 
> > i8042_wait_write() thinks that there is space to write the data 
> > immediately, and writes the data, but now the data got lost because the 
> > buffer was busy.
> 
> Hmm - I just answered the same post and concluded that I didnt understand,
> so you have progressed further. I considered the same possibility,
> but the data was not lost since we read it again later.
> Only the ready flag was lost.
 
What I believe is happening is that we're talking to SMM emulation of
the i8042, which doesn't have a clue about these commands, while the
underlying real hardware implementation does. And because of that they
disagree on what should happen when the command is issued, and since the
SMM emulation lazily synchronizes with the real HW, we only get the data
back with the next command.

I still don't have an explanation why both 'usb-handoff' and 'acpi=off'
help, I'd expect only the first to, but it might be related to the SCI
interrupt routing which isn't done when 'acpi=off'. Just a wild guess.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
