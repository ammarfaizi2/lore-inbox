Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbTCJWuQ>; Mon, 10 Mar 2003 17:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTCJWuP>; Mon, 10 Mar 2003 17:50:15 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:33511 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262242AbTCJWuN>; Mon, 10 Mar 2003 17:50:13 -0500
Message-ID: <20030310230012.26391.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org, phoebe-list@redhat.com
Date: Tue, 11 Mar 2003 00:00:12 +0100
Subject: Stack growing and buffer overflows
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi `who | cut -f1 d' '`, 
 
Lately, I have been reading some articles on buffer overflows. Many of them seem to be caused by using local 
variables that are allocated on the stack and then written to with no proper bounds checking. I don't know of 
other architectures, but on x86, the stack grows downwards (from higher memory addresses to lower memory 
addresses). This makes buffer overflows attacks easy to exploit: if a function uses strcpy() instead of strncpy() to 
copy data (or memset or anything else that normally works upwards), due to the downwards nature of the stack 
implementation, it's possible to overwrite the function's return address, or even another function local data 
waiting in the call stack -> the stack grows downwards, but strcpy() works upwards, thus being able to cross 
stack function boundaries (overwritting other functions local data or even its return address). 
 
However, what would happen if the stack was implemented to grow upwards (from lower memory addresses to 
higher memory addresses)? With this kind of implementation, if the last function in the call stack invokes 
strcpy() over a local variable (allocated onto the stack) without checking bounds, the extra data would not 
overwrite neither the own function's return address nor any other function waiting onto the call stack -> the 
stack grows upwards and so does strcpy() when writting memory. 
 
I know there are hardware implementation details involved in this issue, like the way PUSH and POP work, but 
this is just an idea :-) 
 
Comments on this? Could this be viable? Is the whole idea stupid in general? 
 
Thanks! 
 
   Felipe Alfaro 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
