Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275247AbTHSAN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275248AbTHSAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:13:58 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:7040 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S275247AbTHSAN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:13:56 -0400
Message-ID: <3F416BD4.3040302@sbcglobal.net>
Date: Mon, 18 Aug 2003 19:14:12 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
References: <20030817003128.04855aed.voluspa@comhem.se> <200308171142.33131.kernel@kolivas.org> <20030817073859.51021571.voluspa@comhem.se> <200308172336.42593.kernel@kolivas.org>
In-Reply-To: <200308172336.42593.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That makes sense, I was running a program that I found on IBM's website 
that's supposed to test context switching speed this weekend.  It has 1 
free lock and passes them around the group.  If I put it up to 32 
threads or so with one spare lock, I can start to see the starvation.  
When running vmstat, it's apparent when the the starvation occurs as the 
context switching sky-rockets.  I was going to add to the example code 
to check for how many times a thread wakes up waiting for the lock and 
can't get it after reading that message about locks in the list.  I 
guess I won't have to do that now.  Anyway, that'll bring my system to a 
halt when the thread count gets up over 256.  Still, it's usuable as 
long as I'm not doing something else that makes heavy use of the processor.

I also had a nasty experience with a nautilus crash today that caused 
this problem with X, I'm sure much similar to the results from Blender.  
Obviously,  X keeps getting expired because I was forced to reset after 
waiting 1 1/2 hours for the system to shutdown (i.e. after the runlevel 
changed to 6 to the actual rebooting of the system).  Even after I 
managed to get out of X (though I don't know if the process was able 
ever to actually exit) the system took 5 minutes to get from "Stopping 
sound services" to the next message.  After that, I got a cursor that 
didn't flash, then a blank screen but no reboot.  I don't think X ever 
exited since it never took me back to VT7, and the XDM shutdown comes 
shortly before killing cron.  The last message I saw indicated it was 
shutting down service at...  At that point, I could no longer change 
between terminals though I could see continuing activity on my hard 
drive.  I waited 30 minutes from when I had exited X until I finally 
reset.  I had just clicked on the debug information button in bug buddy 
when this started.

I think this problem is exacerbated when another app is competing for 
the processor.  The machine just pauses unless I'm also doing something 
else, in this case compiling XINE.  Once something is competing, it 
looks like X takes an extraordinarily long time to come back into the 
running queue.

Is there a way to figure out when a process is spinning on a wait and 
exponentially decrease it's bonus if they are consecutive?  I should 
probably read through the source and some of these posts before I make 
suggestions though, because I don't currently know much about how all 
that works.

Wes

Con Kolivas wrote:

>Second, any applications that exhibit this should be fixed since it is a bug. 
>
>Finally I still need to find a way to prevent this from transiently starving 
>the system without undoing the interactive improvements to normal 
>applications; I certainly don't intend to make them "work nicely" just for 
>the sake of it.
>
>I do have some ideas about how to progress with this (some Mike has suggested 
>to me previously), but so far most of them involve some detriment to the 
>interactive performance on other apps. So I'm appealing to others for ideas.
>
>Comments?
>
>Con
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

