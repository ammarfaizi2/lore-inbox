Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTJDTnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTJDTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:43:47 -0400
Received: from andromeda.oftc.net ([80.190.233.18]:36785 "EHLO
	andromeda.oftc.net") by vger.kernel.org with ESMTP id S262720AbTJDTno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:43:44 -0400
Date: Sat, 4 Oct 2003 15:17:38 -0400
From: David B Harris <david@eelf.ddts.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 scheduler goodness
Message-Id: <20031004151738.789d8ad9.david@eelf.ddts.net>
Organization: Tachyon Systems
X-Mailer: Sylpheed version 0.9.5claws28 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mail-Copies-To: nobody
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__4_Oct_2003_15_17_38_-0400_h0D5oaVOsd=K8xEL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__4_Oct_2003_15_17_38_-0400_h0D5oaVOsd=K8xEL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hey guys. Using Linux 2.6.0-test6, and have a few scheduler comments
(first though, good work! :) see below):

1) I'm a fairly heavy user/developer. 2.4.x's stock scheduler has always
been excellent for me. Just in case I was missing out, I tried preempt
patches, lowlatency patches, different VMs/schedulers and such. All of
them reduced throughput and responsiveness noticeably.

2) I've been tracking 2.5.x/2.6.0-test* for a while, and up to and
including 2.6.0-test4, I had the same problems as I did with non-stock
2.4.x schedulers; in other words, both throughput and responsiveness
were worse than I needed (in other words, they weren't as good as what I
was used to).

3) I'm aware of how easy it is to create a world-class workstation
scheduler, and how hard it is to make a scheduler that's excellent in
all workload cases ;)

4) In either 2.6.0-test5, or 2.6.0-test6 (I'm using 2.6.0-test6, I
skipped test5), responsiveness was magically fixed for my workload case.
I still have lower throughput, apparently (big compiles and whatnot take
about 20% longer), but I recently got a CPU upgrade so I don't
particularily notice it - the CPU upgrade was a pretty major one.

Allright, so, in that context, here are some excerpts form a
conversation I had on IRC:

[14:42:14] <ElectricElf> Heh, impressive:                                     
[14:42:14] <ElectricElf>  14:41:55 up 14:58,  6 users,  load average: 171.82, 319.28, 475.21
[14:44:51] <ElectricElf> Oh, heh, that explains why:
[14:44:59] <ElectricElf> [ david@willow: ~/ ]$ ps auwwx | wc -l
[14:44:59] <ElectricElf> 3381
[14:45:22] <steve> mothers of christ
[14:45:31] <ElectricElf> They're all procmail instances.
[14:45:34] <ElectricElf> formail/procmail sucks.
[14:45:40] <ElectricElf> Highest loadavg I've ever seen though.
[14:45:47] <steve> same.
[14:46:40] <ElectricElf> In 2.6.x's defence, though, I didn't even notice it
                         was that bad.
[14:46:51] <ElectricElf> Still web browsing fairly normally.
[14:47:04] <ElectricElf> Disk was thrashing, but I just assumed it was
                         slugging through all the mails sequentially.
[14:47:50] <ElectricElf> I think I have about 3200 procmail processes polling
                         for a lockfile every second.
[14:48:02] <ElectricElf> ... and one of 'em died, not releasing lockfile :)
[14:48:33] <steve> hahaha
[14:48:46] <ElectricElf> [ david@willow: ~/ ]$ ps auwwx | wc -l
[14:48:46] <ElectricElf> 3379
[14:48:51] <ElectricElf> Yah. They're all just kind of sitting there.
[14:48:59] *  ElectricElf removes the lock and waits for the shitstorm
[14:49:15] <ElectricElf> Heh. Didn't do much at all.
[14:49:18] <ElectricElf> *sigh*
[14:49:24] *  ElectricElf killalls procmail
# Annotation:
# I had suspended the formail process which had all the procmails traced.
#
# A few processes were very, very unhappy at this point: notably, my Screens 
# and X were unable to process keyboard/mouse input. There was quite the 
# swapstorm as procmail processes which had been swapped out were brought back
# in and killed. However, it passed in about 30 seconds, and I was able to
# watch the progress as my pretty much everything appeared to at least be able
# to continue with output; gkrellm and X didn't appear to be struggling in 
# that manner.
[14:50:42] <ElectricElf> Heh
[14:50:47] <ElectricElf> Okay. There's the shitstorm :)
[14:51:13] <ElectricElf>  14:50:53 up 15:07,  7 users,  load average: 522.04, 452.36, 418.54
[14:51:18] <ElectricElf> Yah. Didn't like that one bit.
[14:52:13] <ElectricElf> Colour me impressed though, it made it through pretty
                         good.

So, all in all, good work guys - I don't doubt that my 2.4.x
installation, even if it seems to have better throughput at the moment,
would have fallen flat on its ass and required Alt-SysRq-SUB. Even if
the throughput can't be improved, I'm still quite happy with the
tradeoff. Except for the 30-second period mentioned above, when I did
'killall procmail', I was using my machine fairly normally.

P.S.: I'm not subscribed, but nor do I particularly want to be CC:'d on
replies. If somebody who works on the scheduler wants to get in touch
with me because they want some clarification on something or other,
that's just fine though. Just wanted to let the people involved know :)

--Signature=_Sat__4_Oct_2003_15_17_38_-0400_h0D5oaVOsd=K8xEL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/fxzSuCQ/g7GxJcARAnYeAJ9g2Ll4rLZqvVa/qhJnsChPMEWnhQCbBpEz
YlDOWTnQZxR422qOrtwfV7E=
=AGYh
-----END PGP SIGNATURE-----

--Signature=_Sat__4_Oct_2003_15_17_38_-0400_h0D5oaVOsd=K8xEL--
