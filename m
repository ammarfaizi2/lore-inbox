Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbREEO15>; Sat, 5 May 2001 10:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbREEO1s>; Sat, 5 May 2001 10:27:48 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:60921 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S132561AbREEO13>; Sat, 5 May 2001 10:27:29 -0400
Message-Id: <l03130306b719ba7ef592@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.10.10105050155020.15185-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <3AF389BD.81F9B398@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 5 May 2001 15:19:15 +0100
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Seth Goldberg <bergsoft@home.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:20 am +0100 5/5/2001, Mark Hahn wrote:
>On Fri, 4 May 2001, Seth Goldberg wrote:
>
>> Hi,
>>
>>   Before I go any further with this investigation, I'd like to get an
>> idea
>> of how much of a performance improvement the K7 fast_page_copy will give
>> me.
>> Can someone suggest the best benchmark to test the speed of this
>> routine?
>
>Arjan van de Ven did the code, and he wrote a little test harness.
>I've hacked it a bit (http://brain.mcmaster.ca/~hahn/athlon.c);
>on my duron/600, kt133, pc133 cas2, it looks like this:
>
>clear_page by 'normal_clear_page'        took 7221 cycles (324.6 MB/s)
>clear_page by 'slow_zero_page'           took 7232 cycles (324.1 MB/s)
>clear_page by 'fast_clear_page'          took 6110 cycles (383.6 MB/s)
>clear_page by 'faster_clear_page'        took 2574 cycles (910.6 MB/s)
>
>copy_page by 'normal_copy_page'  took 7224 cycles (324.4 MB/s)
>copy_page by 'slow_copy_page'    took 7223 cycles (324.5 MB/s)
>copy_page by 'fast_copy_page'    took 4662 cycles (502.7 MB/s)
>copy_page by 'faster_copy'       took 2746 cycles (853.5 MB/s)
>copy_page by 'even_faster'       took 2802 cycles (836.5 MB/s)
>
>70% faster!


On my Athlon 1GHz, Abit KT7, PC133 set to "Turbo" (not quite sure what the
actual CAS rating is, but it works):
[chromi@beryllium compsci]$ ./athlon
1000.047 MHz
clear_page by 'normal_clear_page'        took 10769 cycles (362.7 MB/s)
clear_page by 'slow_zero_page'           took 10349 cycles (377.5 MB/s)
clear_page by 'fast_clear_page'          took 10868 cycles (359.4 MB/s)
clear_page by 'faster_clear_page'        took 4345 cycles (899.1 MB/s)

copy_page by 'normal_copy_page'  took 11242 cycles (347.5 MB/s)
copy_page by 'slow_copy_page'    took 11245 cycles (347.4 MB/s)
copy_page by 'fast_copy_page'    took 7951 cycles (491.3 MB/s)
copy_page by 'faster_copy'       took 4765 cycles (819.7 MB/s)
copy_page by 'even_faster'       took 4955 cycles (788.3 MB/s)

My wild guess is that with the "faster" code, the K7 is avoiding loading
cache lines just to write them out again, and is just writing tons of data.
The PPC G4 - and perhaps even the G3 - performs a similar trick
automatically, without special assembly...

Perhaps the IWILL m/board doesn't like this behaviour, and somehow assumes
that all written cachelines have been read beforehand.  I heard of some
m/boards - particularly those with more than 3 DIMM slots - using a "helper
chip" to boost the signal to the last slot or two, so maybe that is a
problem?  How many slots does the IWILL have?

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


