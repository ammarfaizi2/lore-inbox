Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTFRATW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFRATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:19:22 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:21201 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265030AbTFRATN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:19:13 -0400
Date: Tue, 17 Jun 2003 20:30:23 -0400
From: rmoser <mlmoser@comcast.net>
Subject: How do I make this thing stop laging?  Reboot?  Sounds like  Windows!
To: linux-kernel@vger.kernel.org
Message-id: <200306172030230870.01C9900F@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Figured this one out.  I had the issue where xmms was skipping a
lot and my system was lagging wasy too much.  Rebooted to fix it
(WTF?!) whenever it happened.  Couldn't understand why.  Hard disk
light flashing, but no programs that read from the HDD all that much
(xmms doesn't do it THAT much).

I got rid of htdig.  It stopped.

So I ran GIMP recently and caused it again.  Clicked in the wrong
place and BOOM!  Gradient needs too much RAM and CPU and time.
Killed gimp.  Suddenly, my system is lagging.

Ten minutes later I get the brains to run top.  It seems I have about
50 MB in swap, and 54 MB free memory.  So I wait ten minutes more.

No change.

% swapoff -a; swapon -a

Fixes all my problems.

Now this long story shows something:  The kernel appears to be unable
to intelligently pull swap back into RAM.  What gives?

I'm poking around in linux/mm and can't find the code to control this.  I
want to make it swap back in any page that it reads, even if it has to
swap out another page (preferably one which hasn't been used for very
long).  Also, a more aggressive thing, kswapd should have freepages.max
in there, to force it to pull in pages from swap aggressively if there's a lot
of free RAM and a lot of swap used.

Uhh, I'm lost... how does this stuff work?  I'm... really lost.  Should I be
doing this?  Tell me where to start maybe?

--Bluefox Icy

