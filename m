Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271312AbTHCVR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTHCVR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:17:56 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:25564
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S271312AbTHCVRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:17:53 -0400
Date: Sun, 3 Aug 2003 23:19:49 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-Id: <20030803231949.3ca947f6.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-03 10:14:00 Con Kolivas wrote:

> Please note if you do test the interactivity it would be most valuable
> if you test Ingo's A3 patch first looking for improvements and
> problems compared to vanilla _first_, and then test my O12.2 patch on
> top of it. Hopefully there has been no regression and only
> improvement in going to Ingo's new infrastructure.

I can hardly spot any difference between 2.6.0-test2, A3 and A3-O12.2
while running the test as outlined in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105956126017752&w=2

I'll never do such a three hours again... All was equally well, which
probably just means that my environment is too lightweight during
"normal" operation. So I had to focus on the taxing game scenario.

XFree86 Version 4.3.99.9 compiled against my glibc 2.2.4, and the same
story with winex 3.1 running "Baldurs Gate I":

_2.6.0-test2_

Animations have cyclic hacking like --- . --- . --- . (dots are pauses).
Ambient sound hacks in concert, with an almost oscillating quality.
Mouse pointer is impossible to place since movement can mean a few
pixels or a full screen. Panning the play area is, of course, a real
pain. Playability = 0 (on a scale from 0 to 10)

_2.6.0-test2-A3_

All problems gone. Just slight bumps (very short graphic pauses) when
doing a long play area panning. Sound is not perceptibly disturbed by
any graphic bumps. Playability = 9.

_2.6.0-test2-A3-O12.2_

Regression compared to plain A3, both in sound and animations. Mouse and
panning seem less regressed. For example, a character can take four
steps, freeze for half a second, take another four steps, freeze etc.
Playablility = 8.

I did the game-test two times with each A3 and A3-O12.2 (alternating
boots) and the results were persistent. Looking at a "top" terminal
while in the game, I couldn't spot any striking differences between the
numbers. Just one oddity - and now I'm uncertain of its validity - as
can be seen on the screencaps below. In A3 wine had a PRI of 25,
wineserver had 15. In A3-O12.2 the numbers were reversed. I can redo the
test if necessary.

( the niced process is foldingathome, always running on my system)

--A3--
20:15:01 up 23 min, 4 users, load average: 2.86, 3.09, 2.46
58 processes: 53 sleeping, 4 running, 0 zombie, 1 stopped
CPU states: 53.7% user 42.1% system 4.1% nice 0.0% iowait 0.0% idle
Mem: 127032k av, 123384k used, 3648k free, 0k shrd, 732k buff
86876k active, 28660k inactive
Swap: 489940k av, 0k used, 489940k free 49436k cached

PID USER PRI NI SIZE RSS SHARE STAT %CPU %MEM TIME CPU COMMAND
209 loke 25  0 75316  46M 14284 R    56.6 37.2 10:40 0 wine
216 loke 15  0  2712  992  2388 S    34.4 0.7  5:42  0 wineserver
147 loke 34  19 33220 2388 24144 S N 4.3  1.8  2:02  0 FahCore_ca.ex
252 loke 16  0  1820  968  1664 R    1.7  0.7  0:01  0 top
172 root 16  0 27652  16M 13884 R    1.3 13.1  4:04  0 X
178 loke 15  0  5752  3428 5200 S    1.1  2.6  0:13  0 gkrellm
175 loke 15  0  8056  5936 4528 S    0.3  4.6  0:06  0 enlightenment
--

--A3-O12.2--
20:53:19 up 14 min, 4 users, load average: 3.57, 2.52, 1.27
58 processes: 52 sleeping, 5 running, 0 zombie, 1 stopped
CPU states: 60.3% user 36.5% system 3.1% nice 0.0% iowait 0.0% idle
Mem: 127032k av, 123672k used, 3360k free, 0k shrd, 640k buff
87996k active, 27860k inactive
Swap: 489940k av, 0k used, 489940k free 50664k cached

PID USER PRI NI SIZE RSS SHARE STAT %CPU %MEM TIME CPU COMMAND
193 loke 15  0 66548  37M 14284 S   60.3 30.2 2:36   0 wine
200 loke 25  0  2704  984  2388 R   31.7 0.7  1:24   0 wineserver
150 loke 39  19 37248  10M 28172 S N 3.1 8.2  8:49   0 FahCore_ca.ex
220 loke 18  0  1820  968  1664 R   1.9  0.7  0:03   0 top
175 root 15  0 27492  16M 13872 S   1.3  13.0 0:31   0 X
181 loke 16  0  5752 3428  5200 S   0.9  2.6  0:03   0 gkrellm
178 loke 16  0  8232 6084  4520 S   0.3  4.7  0:03   0 enlightenment
--

Mvh
Mats Johannesson
