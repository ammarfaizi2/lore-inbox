Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271959AbRIDMjq>; Tue, 4 Sep 2001 08:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRIDMjg>; Tue, 4 Sep 2001 08:39:36 -0400
Received: from CPE-203-45-215-234.qld.bigpond.net.au ([203.45.215.234]:4760
	"EHLO monkeyiq.dnsalias.org") by vger.kernel.org with ESMTP
	id <S271959AbRIDMj2>; Tue, 4 Sep 2001 08:39:28 -0400
Date: Tue, 4 Sep 2001 22:39:40 +1000
Message-Id: <200109041239.f84CdeJ26575@monkeyiq.dnsalias.org>
To: linux-kernel@vger.kernel.org
Cc: monkeyiq@users.sourceforge.net
Subject: /proc/net/tcp && udp formats
From: monkeyiq <monkeyiq@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Is the format of these two files fixed? I think there
was talk on the files in /proc on the list a while ago,
but there seemed to be no resolution as to that format
was going to be sought in the future.

I ask because in ferris I parse these files to get a 
"directory" of sockets, from which soon one will be
able to "create" a new socket. 

Also, where is the 'st' state enum defined for this file? 
I'd like to look it up and provide EA for it too.

...

Also as an RFC on any ideas for improvements that others may
have, I take the following

$ head -2 /proc/net/tcp
  sl  local_address rem_address   st tx_queue rx_queue \
tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 6300A8C0:008B 00000000:0000 0A 00000000:00000000 \
00:00000000 00000000     0        0 2571091 1 c90db7e0 300 0 0 2 -1 

And generate a context with EA in ferris:

./ls --root-context-class=socket \
--show-columns="name,local_address,local-ip,local-port,remote-ip,remote-port,path,local-hostname,ea-names" \
--ferris-logging-off /tcp

name	local_address	local-ip	local-port	\
remote-ip	remote-port	path	local-hostname	ea-names	

0	6300A8C0:008B	192.168.0.99	139	\
0.0.0.0	0	/tcp/0	myhost	attribute-count,dss,dss1,ea-names,head,head-radix,inode,local-hostname,local-ip,local-port,local_address,md2,md4,md5,mdc2,name,path,rem_address,remote-hostname,remote-ip,remote-port,retrnsmt,ripemd160,rx_queue,sha,sha1,sl,st,subcontext-count,timeout,tm->when,tr,tx_queue,uid,	

where ea-names are all the attributes for this fake file. I basically take
every line and make a fake file for it, and add new EA for ip, reverse lookups,
and port in decimal. Sorry about the formatting... 
I could maybe send CSV for future posts :|

-------------------------------------------
is that you ferrese?
http://witme.sourceforge.net/libferris.web/

