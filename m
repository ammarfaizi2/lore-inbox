Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVJVV5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVJVV5A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 17:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVJVV5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 17:57:00 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:19905 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751152AbVJVV47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 17:56:59 -0400
Date: Sat, 22 Oct 2005 23:56:50 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with usb-audio introduced between 2.6.13 and 2.6.14-rc1
Message-ID: <20051022215649.GA7598@hansolo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After updating the kernel on one of my computers today I discovered that 
usb-audio via snd-pcm-oss over the snd-usb-audio ALSA drivers stopped 
working (worked with 2.6.13, doesn't with 2.6.14-rc[12345]).

The weird part is that it only stopped working when using the driver 
through the oss emulation and only for some programs. I've tried it with 
all apps with native alsa support that I had installed, and all of them 
worked. I also tried it with a few different apps with oss support, and 
most of them worked (xine and mplayer) while one failed (mythmusic).

The symptoms is that no sound is heard while the app seems to believe 
that everything is just fine. It also progresses through the song at 
about 20x normal speed (i.e. it thinks its done playing a 4 minute song 
after 12 seconds). The only difference I can come up with is that xine 
and mplayer probably up-sample the audio to 48.000Hz while MythMusic 
tries to play at 44.100Hz (the device is a TerraTec external USB <-> 
SPDIF interface).

I've used git's bisect command to try to find the exact problem, and it 
seems to have been introduced by this commit:	
7efd8bc800324a967a37e8a425433468b7f06adb
see also:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7efd8bc800324a967a37e8a425433468b7f06adb
patch name: [ALSA] usb-audio: double-buffer all playback data

I'm not sure on how to fix it since the commit is quite big and cannot 
be simply reversed with the current tree as there have been other 
patches applied to the file afterwards. Comments/suggestions welcome...

Regards,
David Härdeman
david (at) 2gen (dot) com

PS
Please CC me on any replies
