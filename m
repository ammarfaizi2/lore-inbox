Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbTC1VuB>; Fri, 28 Mar 2003 16:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263163AbTC1VuB>; Fri, 28 Mar 2003 16:50:01 -0500
Received: from freeside.toyota.com ([63.87.74.7]:56456 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263160AbTC1Vt7>; Fri, 28 Mar 2003 16:49:59 -0500
Message-ID: <3E84C624.90003@tmsusa.com>
Date: Fri, 28 Mar 2003 14:01:08 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: very poor performance in 2.5.66[-mm1]
References: <Pine.LNX.4.44.0303281641320.11928-100000@admin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just out of curiosity, does it help to say:

export LANG=en_US

?


David Mansfield wrote:

>On Fri, 28 Mar 2003, Andrew Morton wrote:
>  
>
>>>After all of the rave reviews about the interactivity fixes (both regular 
>>>and I/O scheduler related), I decided to give the 2.5.latest a try on my 
>>>desktop machine (system described below)
>>>
>>>I started X, everything seemed fine, maybe a bit faster.  I opened a 
>>>'gnome-terminal' and typed 'ls -ltr'.  Wow, it was 20x slower.
>>>
>>>Here are the timings for 'ls -ltr':
>>>
>>>2.5.66-mm1:      'ls -ltr'         31 seconds
>>>2.5.66-mm1:      'ls -ltr | cat'   2 seconds
>>>2.4.18-rhlatest: 'ls -ltr'         1.14 seconds
>>>      
>>>
>>How many files were there?
>>    
>>
>
>1337 files.
>
>  
>
>>My /usr/bin contains 3168 files.  An `ls -ltr' in gnome-terminal takes 9.6
>>seconds.  In rxvt it takes 0.5 seconds.  That's an 850MHz P3.
>>
>>So gnome-terminal appears to be a pretty slow application.  My guess would be
>>that something in the 2.5 kernel has exposed a marginality or an outright
>>bug in it.
>>    
>>
>
>Yes. gnome-terminal is godawful slow on RHAT 8.0 (it does Xrender
>alpha-channel crap for every character to get the anti-aliasing).  But I
>think the problem has to do with the pipe/pty wakeups.  After 'ls' writes
>a line to the pty, it seems as though the gnome-terminal is being woken up
>(even though 'ls' has more to write), it's generating the Xrender 
>X-command and sending it to X.  X is waking up and rendering it (which 
>forces a complete update of the screen).
>
>Under 2.4.18-whatever, it would seem as though 'ls' is generating a large
>number of lines of output before the gnome-terminal is waking up, causing
>a dramatically fewer number of redraws.
>
>  
>
>>It would be interesting to edit include/asm-i386/param.h and set HZ to 100.
>>
>>    
>>
>
>I'll try to check this out over the weekend.
>
>David
>
>  
>


