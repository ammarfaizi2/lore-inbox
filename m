Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbREYS1Y>; Fri, 25 May 2001 14:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbREYS1O>; Fri, 25 May 2001 14:27:14 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:35935 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261423AbREYS1E>; Fri, 25 May 2001 14:27:04 -0400
Date: Fri, 25 May 2001 13:27:03 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105251827.NAA21092@tomcat.admin.navo.hpc.mil>
To: ishikawa@yk.rim.or.jp, linux-kernel@vger.kernel.org
Subject: Re: OOM process killer: strange X11 server crash...
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ishikawa <ishikawa@yk.rim.or.jp>:
....
>Anyway, this time, here is what was printed on the screen (the tail end
> of it).
> --- begin quote ---
>     ... could not record the above. they scrolled up and disapper...
> Out of Memory: Killed process 4550 (XF8_SVGA.ati12).
> __alloc_pages: 0-order allocation failed.
> VM: killing process XF86_SVGA.ati12
> --- end quote
> 
> And before the message disappeared, I think I saw the
> netscape process was killed, too.
> I checked the log message and looked for "Memory"
> Sure enough I foundnetscapewas killed, too, in this case.
> 
> May 25 09:16:46 duron kernel: Memory: 255280k/262080k available (978k
> kernel cod
> e, 6412k reserved, 378k data, 224k init, 0k highmem)
>     ...
> May 25 10:45:31 duron kernel: Out of Memory: Killed process 5562
> (netscape).
> May 25 10:45:31 duron kernel: Out of Memory: Killed process 5450
> (XF86_SVGA.ati1
> 2).
>      ...

Something I have noticed with netscape is that if the X server is
killed out from under it (user logout, or kill X11 manually) is that
it continues to run. The process appears to be looping around select
and attempting to reconnect to the (now dead) X server, and not exiting
like it should.

Other times it seems to terminate properly. The problem may exhibit itself
if netscape is waiting for some asynchronous event (like the name service
lookup maybe) and misses the/a signal that it's socket to the X server
has failed. If a kill -15 doesn't terminate the rogue netscape, then it
takes a kill -9 . In my expierence it is in a tight loop, and ignoring
normal user input. It could still be expanding memory consumption...


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
