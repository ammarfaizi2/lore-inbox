Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSIEBuk>; Wed, 4 Sep 2002 21:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSIEBuk>; Wed, 4 Sep 2002 21:50:40 -0400
Received: from [199.26.153.9] ([199.26.153.9]:50875 "EHLO smtp.fourelle.com")
	by vger.kernel.org with ESMTP id <S316594AbSIEBuj>;
	Wed, 4 Sep 2002 21:50:39 -0400
Message-ID: <3D76B970.8080709@fourelle.com>
Date: Wed, 04 Sep 2002 18:54:56 -0700
From: Adam Scislowicz <adams@fourelle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dead programs LISTEN sockets remain in netstat (Kernel Version 2.4.18-rc4
 SMP)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick Summary: Rarely, but several times in the past few weeks now after 
I kill off a process nicely(SIGTERM) its LISTEN sockets remain open...

Some Detail: Because of this, Squid or our server side app cannot 
respawn(cannot bind to socket as it's in use), sometimes its squid's 
socket that remains in the LISTEN state and other times it's been out 
server side app. These are the apps running on our servers which are 
restarted most often. I don't see how an application could be 
responsible for this behaviour after it is dead. So now I look to the 
kernel ;)

My diagnostics below:

lsof -n -P | grep 9000 finds nothing, however netstate shows TCP/9000 in 
listen state w/ no parent program?
**** NETSTAT OUTPUT ****
bash-2.04# netstat -antp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         
State       PID/Program name  
tcp        0      0 0.0.0.0:8001            0.0.0.0:*               
LISTEN      -                  
tcp        0      0 127.0.0.1:9666          0.0.0.0:*               
LISTEN      9826/lcdd          
tcp        0      0 0.0.0.0:9000            0.0.0.0:*               
LISTEN      -                  
tcp        0      0 0.0.0.0:8008            0.0.0.0:*               
LISTEN      -                  
tcp        0      0 127.0.0.1:9875          0.0.0.0:*               
LISTEN      -                  
...
**** END OF NETSTAT OUTPUT ****

ps aux reports no zombie processes...

any help? do you need more info? I have a system in this state now.

thank you :)
/)dam.. .  . d o n ' t   s t o p.

