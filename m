Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUANDQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 22:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUANDQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 22:16:17 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:27071 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S266289AbUANDQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 22:16:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: Re: ANother debugging Q
Date: Tue, 13 Jan 2004 22:16:10 -0500
User-Agent: KMail/1.5.1
References: <200401131243.27614.gene.heskett@verizon.net> <200401131817.44856.gene.heskett@verizon.net> <400494FB.7040709@vgertech.com>
In-Reply-To: <400494FB.7040709@vgertech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401132216.10149.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.56.190] at Tue, 13 Jan 2004 21:16:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 20:01, Nuno Silva wrote:
>Gene Heskett wrote:
>> Unforch, that seems to shut down the opening of the error advisory
>> window.  It just sits there showing a blank (data wise) screen.
>> And extensive scrolling back thru about 5 megs of the output
>> doesn't disclose a missing file that I can see.  How would I go
>> about redirecting that output to grep, it seems to bypass an
>>
>>  "strace -f ksysguard|grep open"
>
>Do "man strace" again :-)
>
>Then see the -o option or the -e option.
>
>(Or "man bash" and read about output redirection 2>&1 )
>
I did that last, almost automaticly, and got nothing, not even an 
invocation of ksysguard.  I think I should have.  However in another 
day or so I should have enough of kde-3.2-beta built to switch and 
see if that works.

However, this finally spit out something, but I don't know what to do 
about it:
----------------------
[root@coyote usr]# strace -f -e trace=network ksysguard
[pid 23529] socket(PF_UNIX, SOCK_STREAM, 0) = 3
[pid 23529] connect(3, {sin_family=AF_UNIX, path="/tmp/.X11-unix/X0"}, 
19) = 0
Xlib:  extension "GLX" missing on display ":0.0".
Xlib:  extension "GLX" missing on display ":0.0".
[pid 23529] socket(PF_UNIX, SOCK_STREAM, 0) = 5
[pid 23529] connect(5, {sin_family=AF_UNIX, 
path="/tmp/.ICE-unix/1367"}, 21) = 0
[pid 23529] socket(PF_UNIX, SOCK_STREAM, 0) = 10
[pid 23529] connect(10, {sin_family=AF_UNIX, 
path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No        such file 
or directory)
[pid 23529] socket(PF_UNIX, SOCK_STREAM, 0) = 10
[pid 23529] connect(10, {sin_family=AF_UNIX, 
path="/tmp/.ICE-unix/dcop1326-1073910398"}, 37) = 0
[pid 23529] getsockopt(10, SOL_SOCKET, SO_PEERCRED, [1326], [12]) = 0
socketpair(PF_UNIX, SOCK_STREAM, 0, [4, 11]) = 0
socketpair(PF_UNIX, SOCK_STREAM, 0, [12, 13]) = 0
socketpair(PF_UNIX, SOCK_STREAM, 0, [14, 15]) = 0
[pid 23530] setsockopt(13, SOL_SOCKET, SO_LINGER, [0], 8) = 0
[pid 23530] setsockopt(15, SOL_SOCKET, SO_LINGER, [0], 8) = 0
[pid 23530] getpeername(0, {sin_family=AF_UNIX, path="ÿ¿/"}, [2]) = 0
[pid 23532] socket(PF_UNIX, SOCK_STREAM, 0) = 3
[pid 23532] connect(3, {sin_family=AF_UNIX, 
path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No        such file 
or directory)
[pid 23534] socket(PF_UNIX, SOCK_STREAM, 0) = 3
[pid 23534] connect(3, {sin_family=AF_UNIX, 
path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No        such file 
or directory)
--- SIGPIPE (Broken pipe) ---
[root@coyote usr]#
-------------------
I closed the ksysguard window, which made the broken pipe.
AFAIK, nscd is not running, and hasn't in years, I'm using a hosts 
file on this teeny network.

Also, changing it to look at opens, libsensors.so.1 failed, but it 
hasn't existed since lm_sensors-2.7.0 was fresh.  Thats at least 
collecting social security by now.  I have lots of libsensors.so.3's 
though :)

>Regards,
>Nuno Silva

-- 
Cheers & thanks Nuno, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

