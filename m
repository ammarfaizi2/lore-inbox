Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbUBYFLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 00:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbUBYFLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 00:11:33 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:17091 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262619AbUBYFLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 00:11:22 -0500
Message-ID: <403C2E56.2060503@blue-labs.org>
Date: Wed, 25 Feb 2004 00:10:46 -0500
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403C014F.2040504@blue-labs.org> <1077674048.10393.369.camel@cube>
In-Reply-To: <1077674048.10393.369.camel@cube>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

>On Tue, 2004-02-24 at 20:58, David Ford wrote:
>  
>
>>Kernel 2.6.3, procps 3.2.0
>>
>># while [ 1 ]; do (ps aux|grep "grep ps aux" && date) ; sleep 1; done
>>root     20043  0.0  0.0  1504  456 pts/0    R    20:45   0:00 grep grep ps aux
>>Tue Feb 24 20:45:25 EST 2004
>>root     20062  0.0  0.0  1504  460 pts/0    S    20:45   0:00 grep grep ps aux
>>Tue Feb 24 20:45:26 EST 2004
>>root     20081  0.0  0.0  1504  460 pts/0    S    20:46   0:00 grep grep ps aux
>>Tue Feb 24 20:45:27 EST 2004
>>
>>Note the change in the timestamp as reported by 'ps' v.s. the time 
>>reported by 'date'.
>>
>>Repeatable every time at 26 seconds after the minute +/- a portion of a 
>>second.
>>    
>>
>
>I'm not seeing it, with:
>
>procps    both 3.1.8 and procps 3.2.0+
>kernel    2.6.0-test11
>library   glibc 2.3
>hardware  uniprocessor G4 Mac
>ntp       none (and you can tell by my email!)
>
>Run "ps --info" to gather much of this data.
>
>Note that time is a very awkward thing. You boot up,
>with some incorrect clock. Then you adjust the time.
>Later, you may discover that your clock has been
>running too slow. So you adjust the frequency, but
>what about the time that has already passed? Should
>you change the boot time to represent what is now
>known about your clock? What if, by doing so, you
>cause some processes to have started before boot?
>Then again, perhaps due to temperature change, you
>discover that your clock frequency is wrong... This
>is without even getting into the concept of leap
>seconds, which are determined a few months in advance.
>
>Two guesses:
>
>1. leap seconds
>2. SMP, with cycle counters out of sync
>  
>

I'm seeing it on two machines now, I'm going to test on more machines as 
I get access.  The second machine is my notebook with procps 3.1.15 on 
it, and it does it at the 46 second mark, also 2.6.3.

I can see if a process long in the past would have a different time set 
on it, but shouldn't the entry in /proc coincide with the system clock 
that date is accessing?  Or how many different "clocks" does the kernel 
have going?

powerix conf.d # ps --info
BSD j    OL_j
BSD l    OL_l
BSD s    OL_s
BSD u    OL_u
BSD v    OL_v
SysV -f  (none)
SysV -fl (none)
SysV -j  (none)
SysV -l  (none)

procps version 3.1.15
Linux version 2.6.3
Compiled with: glibc 2.3, gcc 3.3

header_gap=-1 lines_to_next_header=1
screen_cols=91 screen_rows=29

personality=0x00000000 (from "unknown")
EUID=0 TTY=136,3 Hertz=100 PAGE_SIZE=4096 page_size=4096
sizeof(proc_t)=492 sizeof(long)=4 sizeof(KLONG)=4
archdefs: i386
namelist_file="<no System.map file>"

Actually, it seems that there is a -significant- time difference in this 
phantom clock now, I suspended my notebook to bring it home from the 
station, and now this time difference is greater than 9 minutes.  I 
suspect it's roughly 46 seconds plus the amount of time that my notebook 
was suspended.  Yes, I'm running ntpd.

root     16894  0.0  0.0  1544  484 pts/3    S    Feb24   0:00 grep grep ps
Wed Feb 25 00:09:09 EST 2004

David

