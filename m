Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267975AbTAMR5i>; Mon, 13 Jan 2003 12:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267976AbTAMR5i>; Mon, 13 Jan 2003 12:57:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16403 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267975AbTAMR5g>; Mon, 13 Jan 2003 12:57:36 -0500
Date: Mon, 13 Jan 2003 10:01:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042482811.19497.10.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301130956150.9314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Jan 2003, Alan Cox wrote:
> 
> Lots of serial activity (standard PC serial ports) with carrier drops 
> present and random oopses appear.

Well, that would kind of match the locking place - the hangup might well
race with IO activity on another CPU. That's exactly the sequence that was
protected by the global irq lock.

> I tried duplicating it with pty/tty traffic on a dual PPro200 and
> suprisingly that did the same.

Just regular IO on its own shouldn't trigger this, I _think_ (no hangup
event).

Although I can actually imagine the "flush_to_ldisc()" racing with itself
on a pty (with the master flushing the slave as the slave flushes itself),
so maybe it could actually happen.. But if your pty tests closed the
master and forced hangups that way, the race would be more likely.

Do you still have the pty stress-test program? 

> Ages ago I chased serial bugs down by doing data transfers between two
> PC's while one of them was strobing the carrier up and down on the test
> PC with varying frequencies

Yeah, that hangup path is one of the nastier tty events, and it's also oen 
that doesn't get much testing in many "normal" loads.

		Linus

