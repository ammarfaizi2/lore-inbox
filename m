Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbRG3D1o>; Sun, 29 Jul 2001 23:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbRG3D1d>; Sun, 29 Jul 2001 23:27:33 -0400
Received: from server.igoweb.org ([206.129.95.116]:26849 "HELO
	server2.igoweb.org") by vger.kernel.org with SMTP
	id <S268285AbRG3D1O>; Sun, 29 Jul 2001 23:27:14 -0400
Message-ID: <3B64D418.3000608@igoweb.org>
Date: Sun, 29 Jul 2001 20:27:20 -0700
From: "William M. Shubert" <wms@igoweb.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010712
X-Accept-Language: en-US, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Leak in network memory?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi. I have an application that does a lot of nonblocking networking I/O 
and is fairly sensitive to how much data can be held in the output 
buffers of sockets. All sockets are set to have 64KB (the default) of 
output buffering. This application had been running well with very long 
uptimes for over a year in the 2.2 kernels.

A couple months ago I upgraded my server to RH 7.1 (with the 2.4.2-2 red 
hat kernel). At first it ran fine, but now after an uptime of 67 days 
I'm starting to see strange problems. It seems as if only a very small 
amount of memory can be held in the output buffer of each socket, even 
though they are still set to 64KB! There isn't a tremendous amount of 
network traffic going on (about 30-100 sockets open at a time, but 
rather low total bandwidth). The fact that each write to a socket only 
writes a few (<8) kbytes is really messing with my performance. I did 
not see this problem until the past week. I tried to trace through the 
kernel code to see why the kernel would be refusing to give me the 
buffering that I ask for, and it looks like if the network code thinks 
that it is using too much memory, then it will behave this way. I'm not 
100% sure of this, though...which is why I'm posting this message.

Does anybody have any hints on how I can track down exactly why my 
output buffers aren't working? I see lots of /proc info related to 
network parameters, but there is little documentation on them. Is there 
a known bug like this in the RH 2.4.2-2 kernel? Would a newer kernel 
help me? (I know, I could just try upgrading and waiting another 60 
days, but 24x7 reliability is very important to my users so I'd rather 
not reboot unless I know that it will help). I searched the archives of 
this mailing list, and found a few interesting references network memory 
consumption in the changelog of the Alan Cox series, but nothing that 
explicitly described a problem like this. Thanks to anybody who can help 
me out here.
-- 

Bill Shubert (wms@igoweb.org) <mailto:wms@igoweb.org>
http://www.igoweb.org/~wms/ <http://igoweb.org/%7Ewms/>


