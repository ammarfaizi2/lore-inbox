Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTKIKIU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTKIKIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:08:20 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:64220
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262310AbTKIKIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:08:17 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mochel@osdl.org
Subject: Patrick's Test9 suspend code.
Date: Sun, 9 Nov 2003 04:04:40 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311090404.40327.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So a few idiosyncrasies using patrick's suspend code (I.E. the one that 
actually works for me.  Mostly).

1) If you suspend a process (ctrl-z), suspend to disk, and the resume, the 
suspended process is unfrozen.  (Needless to say, this confuses bash job 
control a bit, since my shell is also unfrozen, so ctrl-c isn't doing 
anything here...)  Try it with a big make, it's fun. :)

2) "Snapshotting memory" is _really_slow_ for a CPU bound task on a 900 mhz 
celeron scanning the memory of a machine that has less than 200 megs of ram.  
My guess is that the "suspend all the hardware" phase accidentally put the 
CPU (or memory bus or some such) into a low-power state where it's still 
running, but at maybe 1/10th normal speed.

3) Suspend works about 90% of the time (echo -e "disk" > /sys/blah), but every 
once in a while I have one of two failure cases:

A) Either it panics (and then blanks the screen on my a few seconds later, yes 
I've tried switching that off with setterm -blank, if anything that made it 
happen faster after a panic.)

B) Or it resumes after the snapshot, booting back up to the desktop.  No 
"writing pages to disk" phase (that I've noticed).  Repeatedly telling it to 
suspend when it does this fails the same way, although I got it to suspend by 
exiting X afterwards and suspending from the console.  It's like there's an 
uninitialized variable on the stack that's getting crap in it, or something.  
(Nothing in the log about snapshotting having failed...)

This brings us to 2B) Snapshotting is way too opaque.  It sits there for 15 
seconds sometimes doing inscrutable things, with no progress indicator or 
anything, and then either suspends, panics, or fails and fires the desktop 
back up with no diagnostic message.

On the whole, this is really really cool, and if you have any suggestions how 
I could help, I'm all ears.  (I'm unlikely to poke into the code too 
extensively this week, converting the bzip compression-side code to C is 
still taking up my free time.  I may take a whack at it for kicks if there's 
some low hanging fruit, though.  But that tends to lead me down ratholes (see 
"bzip")...)

Rob

P.S.  Is there a mailing list to discuss this on?  I asked on the swsusp list 
and they said no, that was for discussing the work of nigel and pavel, and 
their stuff doesn't work for me.  I'm happy to be a guinea pig to test out 
new versions.  I backup my laptop regularly. :)
