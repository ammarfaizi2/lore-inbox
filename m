Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTHWWEy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTHWWDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:03:18 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:56803
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S263417AbTHWWDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:03:00 -0400
Date: Sun, 24 Aug 2003 00:03:24 +0200
From: Voluspa <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Message-Id: <20030824000324.559cb9db.lista1@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-23 12:21:14 Con Kolivas wrote:

> On Sat, 23 Aug 2003 19:08, Thomas Schlichter wrote:
>> On Saturday 23 August 2003 07:55, Con Kolivas wrote:
[...]
>> First of all... Your interactive scheduler work is GREAT! I really
>> like it...!
[...]
> P.S. All this may be moot as it looks like I, or someone else, may
> have to start again.

If you do, please remember this report. Quick summary: All problem areas
I've seen are completely resolved - or at least to a major extent.
Blender, wine and "cp -a".

Andrew Mortons red flag was a good incentive to run my tests on a
pure 2.6.0-test4 and write down the outcome. Adding the O18.1int after
this really stand out.

I won't repeat all my hardware or software facts, but thought I'd add a
few words on tweaks that might have influence: File system is ext2 with
all partitions mounted "noatime". Disk readahead has been upped by
"hdparm -a 512". VM swappiness reduced to 50 (I've got 128 meg mem).
/dev/rtc is changed to 666, read/write for everybody, and
/proc/sys/dev/rtc/max-user-freq is at 1024.

***
_The game "Baldurs Gate I" under winex 3.1_

2.6.0-test4:
Loads but is seriously starved. Sound repeats and graphic freezes occur
with a wave-like frequency. Mouse pointer can hardly be controlled.
Playability 0 of 10.

2.6.0-test4-O18.1int:
Not starved for most of the time, and I can not cause "priority
inversion" on demand with my usual tricks. There _are_ random freezes
but the game recovers within 2 seconds. Playability 8.
***

***
_Blender 2.23 (standalone, and xmms 1.2.7 on a directory of mp3s)_

2.6.0-test4:
Doing a slow "world plane" rotate around the axes is in perfect sync. No
freezes (and no music skips).

2.6.0-test4-O18.1int:
The same as vanilla -test4.
***

***
_Blender 2.28_

2.6.0-test4:
The slow "world plane" rotate cause a 2 to 5 second freeze, quickly
repeating itself if I continue the rotate. Mouse pointer can become
invisible, freeze or jerk right across the screen while loosing its grip
of the world plane grid.

2.6.0-test4-O18.1int:
Perfect sync! How did you achieve this Con? No matter how long I do the
slow "world plane" rotate I can not get it to freeze. Same with a quick
rotate.
***

***
_Blender 2.28 plus xmms 1.2.7_

2.6.0-test4:
Short blackout, ca 3 seconds, at the beginning of a new song if I starve
xmms with the slow "world plane" rotate. Not during the song, only at
the beginning.

2.6.0-test4-O18.1int:
Music perfect during any rotation. Both beginning of songs and the rest.
***

***
_"cp -a" of /usr from hda to hdc and
using Opera 6.12 "software scrollwheel" on
svt.se (page has 70+ small graphics) or a
long slashdot.org comment page_

2.6.0-test4:
"cp" PRI is 15-16, Opera PRI is 15. Slight jerk every 5 second while
scrolling the page on lowest speed.

2.6.0-test4-O18.1int:
"cp" PRI is 17-18, Opera PRI is 15. Perfect smoothness while scrolling.
***

Mvh
Mats Johannesson
