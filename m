Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTH1S4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbTH1S4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:56:06 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:2005 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264163AbTH1S4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:56:03 -0400
Message-ID: <3F4E503F.6070703@wmich.edu>
Date: Thu, 28 Aug 2003 14:55:59 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mem issues with G450 and matroxfb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted this mail to xfree86.org's public mailing list and surprise, 
not a lot of activity on the mailing list.  I suspect more people use 
matroxfb and X and read this list than people who dont even know what 
they are on the other list.  This has to do mostly with the mm series of 
2.6 kernels


I'm aware that the accel features of matroxfb (ala 2.5/2.6) can only
take advantage of the lower 16MB of a 32MB G450 card.  My question
revolves around the fact that fbset -i tells me my card has 16MB even
though dmesg reports the driver detecting 32MB like it should.  I hacked
mga_vid (mplayer's video kernel device driver for matroxfb) so that it
works with 2.6 and it also detects 32MB.
Now all of this would be ok because the comments in matroxfb says the
accel features is all that is limited by 16MB and that it can still use
all 32MB for display and such while accelerated. The problem is X only
reports detecting what fbset reports as my video card's memory size and
because i have matroxfb loaded, it ignores videoram directives in the
config file. xaa isn't using the same amount of cache that it normally
would without the framebuffer driver loaded so i am assuming X is not
seeing 32MB like the matroxfb driver says it should be able to do.

Now on top of this. X seems to not be using the mtrr's that the matroxfb
driver setup.
mtrr: no MTRR for e4000000,1000000 found
is what X reports according to dmesg.  and xfree86.log shows this as
what is being requested.

This is what is in my /proc/mtrr file for the video card.
reg02: base=0xe4000000 (3648MB), size=  32MB: write-combining, count=3
reg05: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=1

One appears to be the video card's memory, the other agp's access to
system memory.

Perhaps this is due to the 16MB visible thing? Is fbset just reporting 
wrong? How can i tell if i'm really only accessing 16MB of my card's 
memory or if i actually am utilizing all of it?

I'm using matroxfb simply for the mplayer driver because it does triple 
buffering which makes the video look noticably better than simple xv.




