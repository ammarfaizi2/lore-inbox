Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbTFWK16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 06:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbTFWK16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 06:27:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:41856 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265982AbTFWK15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 06:27:57 -0400
Date: Mon, 23 Jun 2003 11:50:08 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306231050.h5NAo8EE000843@81-2-122-30.bradfords.org.uk>
To: felipe_alfaro@linuxmail.org, helgehaf@aitel.hist.no
Subject: Re: O(1) scheduler & interactivity improvements
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe I have different a different idea of what "interactive" should be.

[snip]

> moving windows around the screen do feel jerky and laggy at best
> when the machine is loaded. For a normal desktop usage, I prefer all
> my intensive tasks to start releasing more CPU cycles so moving a
> window around the desktop feels completely smooth

That's fine for a desktop box, but I wouldn't really want a heavily
loaded server to have database queries starved just because somebody
is scrolling through a log file, or moving windows about doing admin
work.

The wordprocessor example is an interesting one - if the user is
changing fonts, re-flowing text and generally using it like a DTP
application, then I'd agree that it needs to have a more CPU.

If I was simply typing a letter, I wouldn't really care about
interactivity.  If I was using a heavily loaded server to do it,
(unlikely), I'd rather the wordprocessor was starved, and updated the
screen once per second, and gave more time to the server processes,
because I don't need the visual feedback to carry on typing.  Screen
updates are a waste of CPU in that instance - it might look nice, but
all it's doing is starving the CPU even more.

I propose a radically different approach to scheduling, why not
favour processes that cause the fewest cache faults?  I.E. if a
process that gets more done in it's timeslice is more deserving of
it.  It might look ugly with screen updates being starved, but it
would probably get more work done :-).

John.
