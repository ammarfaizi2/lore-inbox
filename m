Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTKMLLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTKMLLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:11:39 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:27064 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263930AbTKMLL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:11:27 -0500
Message-ID: <3FB366DB.80508@cyberone.com.au>
Date: Thu, 13 Nov 2003 22:11:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Guy <fsos_guy@earthlink.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6 scheduler and "fast user switching"
References: <200311130430.06882.fsos_guy@earthlink.net>
In-Reply-To: <200311130430.06882.fsos_guy@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Guy wrote:

>Scenario:
>
>I typically log in as 'root' on the first console. I then invoke 
>fluxbox as the GUI.
>
># XSESSION=fluxbox startx -- :0
>
>I then ctl-alt-F2 another console and login as 'user1'. I then 
>invoke KDE as the GUI.
>
>$ XSESSION=kde-3.1.4 startx -- :1
>
>I may or may not ctl-alt-Fn and login as 'usern' and repeat the 
>process.
>
>Several thoughts:
>
>1} I've seen Nick Piggin's suggestion of nicing X server to -10. 
>At the moment, the only way I know to do this is something like
>
># XSESSION=fluxbox nice --adjustment=-10 startx -- :N
>

If you're not using my patches then nice causes scheduling latency
problems so don't do this even if you can. Con's scheduler work actually
makes interactivity good at the default priority.

>
>A} My default security is that only 'root' can perform nice with 
>negative values. I am reluctant to play with security for such a 
>crticial command.
>

Debian does this for you. I guess X runs as suid root anyway so
its not a big security problem.

>
>B} All child threads inherit the new nice value. So in the example 
>just above, this means all applications started from the GUI 
>desktop run at a nice value of -10. I believe enhancing the X 
>server nice value this way defeats the purpose of nicing it to 
>begin with. Obviously, despite my readings and attempts at 
>research, I'm must be missing something here.
>

Debian manages to only renice the X server. If something like
this were required in a distro kernel I guess they would do it
for you nicely.

>
>2} I expect to travel down to Florida for Xmass to visit family. 
>One of the things I had hoped to do was to set up my mother's 
>computer as an X server and hang a thin client terminal {read: 
>older PC} off of it. This would allowed my mother and brother to 
>share a reasonably modern system at the same time.
>
>This is not me just being cheap. I'm interested in setting up 
>diskless workstations aound a good central X server. I see such 
>setups as appropriate for a number of situations. If the X server 
>requires 'nicing' in a single user environment, what happens in 
>an LTSP environment?
>

I think the server runs on the clients... or something ;)

>
>My base reference environment is 2.4.20. I still actively use it 
>for everything I do as everything works as expected. 
>
>Despite my enthusiasm for 2.6, I find it difficult to get 
>everything to 'just work'. I still see problems in the area of 
>nForce based mobos {stupid proprietary nVidia!}, broken BIOSes, 
>and scheduler issues like the above.
>

Obviously make sure all your software is up to date with
Documentation/Changes, and remember we can't help with closed drivers.
If you still have problems please send in a report. Hope this helps

Nick


