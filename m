Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUDEG4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 02:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDEG4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 02:56:19 -0400
Received: from rrcs-midsouth-24-172-39-10.biz.rr.com ([24.172.39.10]:21893
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id S262136AbUDEG4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 02:56:08 -0400
From: Mark Rutherford <mark@maunzelectronics.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5 forcedeth sending .. trash? / intel 82540EM dropping packets?
Date: Mon, 5 Apr 2004 02:55:56 +0000
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404050255.56342.mark@maunzelectronics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
before I get into this, since I am not on list, I would appreciate any 
response be CC'd. thanks!

I started having problems with my onboard intel gigabit controller, and 
decided to fire up the nforce ethernet driver in an attempt to isolate the 
problem. I was trying to determine if its a kernel setup, or something on the 
machine.. who knows.... I am trying to find out.

but, the nforce ethernet driver appears to be inop. ( or the interface is 
hosed...)
I tried compiling it in at first, it finds the interface and I can configure 
it.
however I cannot use the interface...
according to ifconfig, its transmitting the packets, its just not recieving 
any.
now, the real fun is when I happened to look at my switch and note that the 
activity light is rapidly flashing.
so, I telnet into the switch to find out that its rather upset about this and 
has isolated that port...
when I unload the module it continues to send .. random stuff out, and the 
only way to stop this is to shut it down, and start the machine back up.

I try using a different port, and cable and I get the same results.
since I dont have Window$ I cant see if its actually working or not. (at least 
in Window$)

however, that leads me to another question. I have this other interface, the 
intel gigabit that I used for the last few months just fine until the other 
day I noticed something odd start to happen.
basically, what happens is anything that sends data rapidly, tends to 'vanish'
for example, if I were to fire up a game browser and search for a server it 
would 'lose' chunks of the queries to other servers. 
in one in-game browser it makes the game flat out crash, and so I started 
trying to figure out why this all is happening....
what I see a ton of in the strace for the game, before it dies is the 
following:
gettimeofday({1081103264, 263945}, NULL) = 0
ioctl(6, FIONREAD, [0])                 = 0
read(0, 0xbfff754f, 1)                  = -1 EAGAIN (Resource temporarily 
unavailable)
recvfrom(13, 0x93848c0, 32768, 0, 0xbfff75a0, 0xbfff759c) = -1 EAGAIN 
(Resource temporarily unavailable)

now, I googled around about this EAGAIN (Resource temporarily unavailable) 
error and came to some conclusion it had to do with the networking.
correct me if im wrong.

so, what im asking, am I having a problem with the card, the kernel, or both?
(with regards to the intel)
whats odd about it, is that im just noticing this problem. but it only occurs 
when a lot of connections out are made. 
some more interesting things, are: 
I ran sniffit on the linux nat box, and these packets never made it there.
and, I run ping -f and ping the hell out of another machine, and it always got 
a response. I let it run for 2 hours, and when I ctrl+c'd it, it only lost 1 
response, out of like 10 million.
and, the last interesting thing...
I can try rapidly connecting to the machine with the intel nic from another 
machine and it seems to lose it then, as well.
an example of how I can reproduce this is as follows:
traceroute google.com, hit ctrl+c, uparrow, and enter rapidly.
but not so fast you cant see the first 2 or 3 hops...
every second or third try it will drop out on you. and its almost ALWAYS the 
second or third try.
ex:

traceroute: Warning: google.com has multiple addresses; using 216.239.37.99
traceroute to 216.239.37.99 (216.239.37.99), 30 hops max, 40 byte packets
 1  192.168.0.1 (192.168.0.1)  0.239 ms  0.167 ms  0.207 ms
traceroute: Warning: google.com has multiple addresses; using 216.239.39.99
traceroute to 216.239.39.99 (216.239.39.99), 30 hops max, 40 byte packets
 1  192.168.0.1 (192.168.0.1)  0.230 ms *  0.241 ms

it lost the second response there....

im lost.

and as far as the forcedeth, I dont know what to do with that one. 

someone, please give me some advice here. throw the board out? :)

-- 
Regards,
mark@freequest.net
Server Admin, FreeQuest IRC Network
http://www.freequest.net



