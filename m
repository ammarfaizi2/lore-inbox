Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbVLAD7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbVLAD7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 22:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVLAD7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 22:59:23 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:22620 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751428AbVLAD7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 22:59:22 -0500
Message-ID: <438E7552.5050505@m1k.net>
Date: Wed, 30 Nov 2005 23:00:18 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Don Koch <aardvark@krl.com>
CC: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       kirk.lapray@gmail.com, video4linux-list@redhat.com, CityK@rogers.com,
       perrye@linuxmail.org
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	<c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>	<438CFFAD.7070803@m1k.net>	<200511300007.56004.gene.heskett@verizon.net>	<438D38B3.2050306@m1k.net> <200512010320.jB13KoH4009443@p-chan.krl.com>
In-Reply-To: <200512010320.jB13KoH4009443@p-chan.krl.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Koch wrote:

>On Wed, 30 Nov 2005 00:29:23 -0500
>Michael Krufky wrote:
>
>  
>
>>Gene Heskett wrote:
>>
>>    
>>
>>>On Tuesday 29 November 2005 20:26, Michael Krufky wrote:
>>>
>>>[...]
>>>
>>>      
>>>
>>>>ll I can think of doing next is to have Gene, Don or Perry do a
>>>>bisection test on our cvs repo.... checking out different cvs revisions
>>>>until we can narrow it down to the day the problem patch was applied.
>>>>
>>>>::sigh::
>>>>   
>>>>
>>>>        
>>>>
>>>A sigh?  More like an 'oh fudge' or whatever your fav expletive deleted
>>>is...
>>>
>>>      
>>>
>>>>Who wants to do it?  I'll give you detailed instructions if you're
>>>>willing.
>>>>   
>>>>
>>>>        
>>>>
>>>Can you farm it out, one set of patches to each of us?  Or do you want
>>>to setup a seperate cvs tree based on the v4l code in 2.6.14.3, and
>>>incrementally patch it as we each report its still ok, until it breaks
>>>again?  I think I'd prefer the latter so we are all near the same
>>>page even if it takes 3x longer to arrive at the answer.  How many
>>>actual patches in terms of dependency groups are there?  I know, I
>>>coulda went all week without asking that :(
>>>
>>>      
>>>
>>Actually, cvs has a parameter that lets you specify cutoff dates...
>>
>>This is what I am suggesting that you do... Base this on my previous cvs 
>>instructions....
>>
>>reminder: http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS
>>
>>so....
>>
>>1st:
>>
>>cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux login
>>cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux co v4l-dvb
>>cd v4l-dvb
>>make clean
>>make
>>make install
>>
>>test
>>
>>(you already did this - you said doesnt work)
>>    
>>
>[...]
>  
>
>>cvs up -D 2005-10-15
>>make clean
>>make
>>make install
>>
>>doesnt work?  1 week earlier:
>>
>>cvs up -D 2005-10-07
>>make clean
>>make
>>make install
>>    
>>
>
>Let's put it this way: for me, 2005-10-10 doesn't work and anything earlier doesn't build.  I've tried building against 2.6.15-rc3, 2.6.14 and 2.6.13.  The card doesn't
>work against the built-in 2.6.13 code, but the tuner is sending bizarre stuff
>to it (channel 2 is *not* at 97.25 MHz).  2.6.14 kept spewing:
>
>CORE IOCTL: 0xc054561d
>cx88[0]: ioctl 0xc054561d (v4l2, rw, VIDIOC_G_TUNER)
>
>all over the syslog.
>
>Build issues include broken Makefiles (around 10-08) and missing header files.
>
>  
>
>>Cheers,
>>
>>Mike
>>    
>>
hmm... would those be unresolved symbols in relation to dvb frontends?

This would be because we only recently merged the cvs trees, and the 
older builds dont include the dvb frontends in the v4l build.  You can 
fix it by doing the following:

Be sure to "make clean" before and after each checkout -- it's necessary 
because of what the scripts below do to the build configuration.

Before running make (EACH TIME) do this:

1- edit v4l-dvb/v4l/scripts/merge-trees.sh   ... delete everything 
BETWEEN these two lines... being sure to leave both of them intact.:

#!/bin/sh

...

patch -p2 <<'DIFF'




...do the same thing to v4l-dvb/v4l/scripts/unmerge-trees.sh

You will have to do it for each checkout, unfortunately.  If you are 
using a more recent checkout (past few days) then you do not have to 
edit these files, as they have been deleted when the build was updated 
for the merger of v4l+dvb cvs.


2) make merge-trees

3) make

4) make install

...because of the "merge-trees" command, you'll have to run "make clean" 
each time before you cvs check out  (cvs co) again.

I hope this works........


-Mike
