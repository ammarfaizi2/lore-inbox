Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSBGHd2>; Thu, 7 Feb 2002 02:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbSBGHdO>; Thu, 7 Feb 2002 02:33:14 -0500
Received: from boden.synopsys.com ([204.176.20.19]:17550 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S285666AbSBGHcu>; Thu, 7 Feb 2002 02:32:50 -0500
Date: Thu, 7 Feb 2002 08:32:39 +0100
From: Alex Riesen <riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre1: zombies in exit()
Message-ID: <20020207083239.B26413@riesen-pc.gr05.synopsys.com>
Reply-To: riesen@synopsys.COM
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

what i did is:
$ find /some/nfs/volume -type f -print0 | xargs -0 cat > /dev/null &
$ find /some/nfs/volume -type f -print0 | xargs -0 cat > /dev/null &
$ find /some/nfs/volume -type f -print0 | xargs -0 cat > /dev/null &
$ find /some/nfs/volume -type f -print0 | xargs -0 cat > /dev/null &
$ wait

and on other xterm:
~/some-kernel$ make dep bzImage modules -j2

and another one:
~/some-kernel$ make dep bzImage modules

kernels finished, i've pressed Ctrl-C on the console with wait
(i wanted check interactivity, and was pretty amazed).
Started QPS(a tool like gtop) just to see two of the find's
are still there. Zombies, yes, sleeping in exit().
Closing the console removed the zombies. That's stock bash-2.05a,
and it hadn't such problems before (although i'm going to try to
reproduce that situation in exactly same way under 2.4.18-pre8-K2
todays night).

-alex
