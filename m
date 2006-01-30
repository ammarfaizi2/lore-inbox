Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWA3WvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWA3WvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWA3WvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:51:11 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:51344 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030205AbWA3WvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:51:10 -0500
Message-ID: <43DE98B9.6010008@tmr.com>
Date: Mon, 30 Jan 2006 17:52:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmatthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr> <20060127080026.GR4311@suse.de>
In-Reply-To: <20060127080026.GR4311@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 26 2006, Jan Engelhardt wrote:
> 
>>>You just want the device naming to reflect that. The user should not
>>>need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
>>>likely be using k3b or something graphical though, and just click on his
>>>Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
>>>help do this dynamically even.
>>
>>And if you have multiple cdwriters? Then (cf. other posts) one has 
>>/dev/cdrecorder0 /dev/cdrecrder1, etc. To me, that's just as bad as having 
>>/dev/sg0 and /dev/sg1, because you don't have a clue at first sight what it 
>>maps to.
> 
> 
> /dev/plextorwriter and /dev/hpwriter or whatever, it's just naming.
> 
> 
>>"ls -l"? Sure, if cdrecorder0 was a symlink, but it does not work when it's 
>>not (= a block device in essence then).
>>And I'm sure there's an analog program to "ls" to find what sg0 maps to.
> 
> 
> You expect the gui user to follow symlinks to find out?
> 
As opposed to? That's not a rhetorical question, please don't blow it 
off, what is the way for a user to go from /dev/sg0 to find out what 
device is really there?

What is not easily available in Linux is a nice single place to find out 
what mass storage (disk/optical/floppy/ZIP/LS120/tape) devices are on 
the system, and what the system calls them. Because for low tech users 
udev is the problem, not the solution. The user doesn't want to tell the 
system what to call the device, he wants to see what's there, and that 
includes serial numbers of drives (where available) because if a user 
has several drives it's likely that they are identical.

Telling the users to "cat /proc/scsi/scsi" and
  for n in /proc/ide/hd?; do echo -n "$n: "; cat $n/model; done
is not a substitute for a presentation useful to programs and people 
alike. It could be in /proc or /sys or wherever is flavor of the day, 
but it would sure make things easier for the users. And before someone 
suggests that a program could generate this, a program would constantly 
chase the changing presentation of the information, a documented "file" 
in /proc or /sys would allow all applications to look in one place for 
the information.

Instead of having the user tell the system what to call a device, let 
the system tell the user what it is called. Then the kernel could change 
without breaking anything in application land.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
