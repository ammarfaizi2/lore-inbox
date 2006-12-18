Return-Path: <linux-kernel-owner+w=401wt.eu-S1752816AbWLRELi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbWLRELi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 23:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbWLRELi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 23:11:38 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:1126 "EHLO ore.jhcloos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbWLRELh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 23:11:37 -0500
From: James Cloos <cloos@jhcloos.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pavel Machek <pavel@ucw.cz>, James Lockie <bjlockie@lockie.ca>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: escape key]
In-Reply-To: <Pine.LNX.4.61.0612161922530.30896@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Sat\, 16 Dec 2006 19\:34\:13 +0100 \(MET\)")
References: <1166058290.2964.15.camel@monteirov>
	<20061213214140.df6111f5.randy.dunlap@oracle.com>
	<4580E985.2090208@lockie.ca> <20061216084542.GD4049@ucw.cz>
	<Pine.LNX.4.61.0612161922530.30896@yvahk01.tjqt.qr>
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:061218:pavel@ucw.cz::uOmebjPRGKGOmJjU:00000AvZM
X-Hashcash: 1:23:061218:bjlockie@lockie.ca::zQunegbRFhUQ9snV:0000000000000000000000000000000000000000000HCn1
X-Hashcash: 1:23:061218:jengelh@linux01.gwdg.de::OZS/qYgd2NRxZyzE:00000000000000000000000000000000000000YCcx
X-Hashcash: 1:23:061218:linux-kernel@vger.kernel.org::RtuPtOr/2RT8u3NE:000000000000000000000000000000001cGdm
Date: Sun, 17 Dec 2006 20:21:08 -0500
Message-ID: <m3bqm20zj8.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jan" == Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

Jan> HOWEVER, unix people probably _had a reason_ to make ESC generate
Jan> part of what function keys do.

You are looking at it backwards.  The Escape key generates an ASCII
escape.  The funtion keys (including the cursor keys) generate escape
sequences because the vt100 won out the title as the most ubiquitous
async serial terminal, and linux devs chose to have the console be
(mostly) vt100 compatable.  As xterm, et al had done before.

The terminals (the actual hardware) used ASCII, so it was normal to
use Escape to initiate the sequences used by the function keys.

And that concept goes back a *lot* longer than unix.  (Hmm.  I can't
remember.  Did TOPS-20 or its predecessor have glass terminals in the
day?  I did get to use a DEC paper terminal a couple of times, but
that was connected to a VMS box back in the '80s; most of the time it
sat in the corner collecting dust....)

At any rate, given that Escape was used to initiate sequences sent to
the terminal for funtions such as moving the cursor around the screen,
clearing rows or cols, et al it must have only seemed natural to also
have it initiate sequences /from/ the terminal which did not fit into
standard ASCII.  That was after all Escape's purpose in the ASCII std.

If you do want to change the console's terminal emulation, a good
first step would be to check whether any existing terminal already
uses something other than Escape to initiate function key sequences,
and, if so, promote that as the alternative to vt100-esque emulation.

Finally, note that the reason vt100 was chosen for the console was to
make it more useful for users who were physically at a linux box, were
logged in on the console, and from there logged in to remote servers.
That does remain something which the console *must* support.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
