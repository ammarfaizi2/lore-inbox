Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbTKAMte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 07:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTKAMte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 07:49:34 -0500
Received: from pa-steclge-cmts2a-19.stcgpa.adelphia.net ([68.168.167.19]:32497
	"EHLO potassium.stop.dyndns.org") by vger.kernel.org with ESMTP
	id S263770AbTKAMtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 07:49:33 -0500
Message-ID: <3FA3AB99.1060408@nodivisions.com>
Date: Sat, 01 Nov 2003 07:48:25 -0500
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
References: <3FA34523.30902@nodivisions.com> <20031101062050.GA13731@alpha.home.local> <3FA353E4.60906@nodivisions.com> <20031101071907.GA6300@alpha.home.local>
In-Reply-To: <20031101071907.GA6300@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
>>Actually, I don't scan the disk to find random albums; I have a text file 
>>that contains a list of every album's full path, and I pick a random line 
>>from that file.  So only the selected album's directory gets scanned.  And 
>>the mp3 partition is mounted read-only (I should have mentioned that 
>>before), so the atimes shouldn't be getting written as it is.
> 
> 
> OK, so it's not a disk IO problem at all. It's really related to the sound
> driver it seems. Now that you say it, I remember having noticed skips on
> my laptop with a via 82cxxx chip after tens of minutes playing. At first
> I thought it was related to other activity on the system, but it did exactly
> what you describe, play seconds 1, 2, then 5 without a hole between them.
> There may be a problem with the way the audio buffer gets allocated or freed.

Yeah... in my experience, the whole ac'97 deal is pretty buggy (for one 
thing, with both ALSA and OSS drivers, output is distorted unless I keep the 
volume below ~70%...).  But as I said, the skipping only happens when the 
memory is full, or getting close to full.  If I select specific albums to 
play instead of using my random function, I can usually play a few albums 
and there aren't any skips, not until the memory gets pretty full.

>>So I'm guessing that there isn't actually a way to manually move 
>>buffer-data out of RAM?
> 
> 
> Yes, there is. I have a quick'n'dirty program which does exactly that.
> Basically, you tell it how many kB you want to free, then it allocates
> and uses that amount of memory, frees it and exits. Buffered data gets
> flushed very quickly. I sometimes give it a try before starting to work
> on large kernel trees, because it helps the entire directories to fit in
> cache.
> 
> Here it is if you're interested. Don't start it without an argument, it
> will try to allocate 4G !

4G!! (Note to self: s/ffffffff/0000ffff/...)  Thanks a lot, I'll give this a 
try.  It certainly works here on my home system.

-Anthony
http://nodivisions.com/
