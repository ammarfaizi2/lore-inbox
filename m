Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281138AbRKOWca>; Thu, 15 Nov 2001 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281132AbRKOWc2>; Thu, 15 Nov 2001 17:32:28 -0500
Received: from tourian.nerim.net ([62.4.16.79]:12046 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S281129AbRKOWcM>;
	Thu, 15 Nov 2001 17:32:12 -0500
Message-ID: <3BF44269.3000402@free.fr>
Date: Thu, 15 Nov 2001 23:32:09 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux i/o tweaking
In-Reply-To: <Pine.LNX.4.30.0111151930360.14530-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

>>I guess the question I'd ask would be what kinda number do you expect from
>>the raid 5 stripe. 107MB/s sounds like a reasonable number from a two
>>channel u160 controller...
>>
>
>I really don't know. My 'logical' mind told me I could get close-to
>speed-per-disk * number-of-disks, but it might be wrong.
>
>
>>my previous best is around 89MB/s with 4 cheetah 15K 18gb drives raid/0
>>
>
>I had 5 drives per SCSI bus and the controller was sitting alone on a
>66MHz/64bit PCI hose.  I really can't see where the bottleneck is!
>
# Hdparm
Do you use hdparm for your test ?

What gives hdparm -T (timing buffer-cache reading) ?
I believe it's kind of a hard ceiling...

<jealousy>
I use single channel PC66 sdram on a BX chipset here and have only 60 
MB/s from buffer-cache on a SMP 2.4.13-ac2 kernel. Seeing a complain for 
107 MB/s from a disk subsystem makes me feel somehow frustrated :-)
</jealousy>

# Hardware
Are all drives recognised as 160 MB/s capable devices ? SCSI is so 
touchy, you never know...
Look in /var/log/dmesg for the scsi adapter logs.

# Software
What's your kernel version. Any patch applied ?

# Looking for a clue
You may try to profile the kernel on arrays with different numbers of 
disks in raid 0 (to keep cpu out of equation at first).
It could help to find the bandwidth or the number of disks where the 
actual speedup begins to fall behind the theoritical speedup and then 
have the profiles at hand.

-- 
 Lionel Bouton

-
"I wanted to be free, so I opensourced my whole DNA code" Gyver, 1999.



