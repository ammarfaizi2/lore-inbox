Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUFLCsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUFLCsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 22:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUFLCsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 22:48:16 -0400
Received: from out-of-band.media.mit.edu ([18.85.16.22]:53255 "EHLO
	out-of-band.media.mit.edu") by vger.kernel.org with ESMTP
	id S264561AbUFLCsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 22:48:04 -0400
Date: Fri, 11 Jun 2004 22:47:36 -0400 (EDT)
Message-Id: <200406120247.WAA05324@out-of-band.media.mit.edu>
From: Lenny Foner <foner+x-forcedeth@media.mit.edu>
To: c-d.hailfinger.kernel.2004@gmx.net
CC: smolny@o2.pl, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       adq@lidskialf.net, netdev@oss.sgi.com, foner+x-forcedeth@media.mit.edu
In-reply-to: <40C0863E.9070508@gmx.net> (message from Carl-Daniel Hailfinger
	on Fri, 04 Jun 2004 16:25:02 +0200)
Subject: Forcedeth and vesa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Date: Fri, 04 Jun 2004 16:25:02 +0200
    From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>

[Note---if any discussion from the original message didn't CC me, I
haven't seen it, because I'm not on these lists.  If there has been,
can someone clue me in?  Tnx.]

[Also, for those who may have seen the original messages from late
May, I sent a long followup with many logfiles, but it wasn't
delivered to anyone who was reading it on the mailing list, because it
tripped the > 100K message limit on the lists.  You can find it in
http://foner.www.media.mit.edu/people/foner/Sys/forcedeth-stuff.txt
if you'd like to see logfiles for working & nonworking cases.  The
subject line for the entire thread at that point was:
  forcedeth breaks X in Debian-testing 2.4.25 on MSI K7N2 Delta-L mobo]

    Hi,

    [foner: I included you in the CC because your problem seems similar.]

It does.

    smolny@o2.pl wrote:
    > Hi,
    > Sorry if you get this post by mistake. I found your address googling
    > for "forcedeth vesa".

    Well, you reached the right person.

    > When i use forcedeth module, both with 2.4.26 and 2.6.6 kernels, i
    > can't access vesa with mplayer. Just loading the module doesn't
    > cause the problem, only after i configure the net with ifconfig i
    > can't use vesa.

    This is interesting. Does the problem persist if you ifdown the interface?

In my case, the problem persists -forever- until reboot (I don't need
to powercycle to fix it).  It only happens once the interface gets
used (e.g., if I just "insmod forcedeth", things are okay---but of
course I don't have a network until I then do "ifdown eth0; ifup
eth0", at which point X breaks the next time it's restarted, e.g.,
if I log out).

However---when I first got your message a few days ago, while trying
to figure out what made it break, I realized I was in a mode where I
-did- have a network and could restart X successfully.  Nothing I did
made it break (un/reloading forcedeth, ifup/ifdown on the interface, etc).
There was nothing out-of-the-ordinary about my session:  I'd started
it, did some light networking, and then left it alone for about a day
and a half before I tried to debug.  However, repeating this behavior
after a reboot (over the last 2-3 days) hasn't managed to reproduce it
---instead, I'm back to the old behavior of X-broken-if-forcedeth-has
handled-a-packet.  (I -did- save a copy of the XF86 logfile from the
working case, just in case anyone thinks it'd be enlightening, but
wasn't sure what else I could possibly save that would be at all
helpful.)  So my guess is that there's some flakiness to this
behavior, although I've only had the "working" situation once in
thirty or more nonworking cases, so it's not -very- flaky.

    > If i use nvnet NVidia driver with 2.4.26, everything goes fine (no
    > nvnet for 2.6.x kernels). 

    That is even more interesting. So the bug affects forcedeth, but not
    nvnet. Hmmm. We'll have to review the code again.

[Note that I haven't tried this.]

    > It's an EPOX 8RDA+ motherboard.

    Foner: Do you see similarities between your problem and this one?

Sure, given that he's complaining about VESA and that's why my X is dying.

    Janusz, Foner: Are you willing to test forcedeth with a few dozen
    iterations of
    patch, recompile, install, power down, power up and test again?

I'm perfectly willing to do this.

    I would send you patches to binary search the offending code.

    Regards,
    Carl-Daniel
