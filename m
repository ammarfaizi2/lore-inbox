Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbRGPJDY>; Mon, 16 Jul 2001 05:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbRGPJDP>; Mon, 16 Jul 2001 05:03:15 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:58128 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267255AbRGPJC5>; Mon, 16 Jul 2001 05:02:57 -0400
Message-ID: <3B52ADC1.95012614@folkwang-hochschule.de>
Date: Mon, 16 Jul 2001 11:02:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netfilter@lists.samba.org
CC: nettings@folkwang-hochschule.de
Subject: kernel lockup in 2.4.5-ac3 and 2.4.6-pre7 (netfilter ?)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello everyone !

i have had reproducible lockups in 2.4.5-ac3.
the box is a cyrix@120 mhz with a via apollo chipset and two
ethercards.
it's used as a masquerading firewall/dsl router.

now when i have an ftp session from a machine on the private network
to the internet and it gets stuck or i ctrl-c out of it, this causes
the box to lock up hard. i was able to reproduce this a few times.
no syslog entries survive. alt-sysrq-sync seems to work, but
-killall and -umount don't, so after alt-sysrq-boot i have to go
through 20gigs of fsck.

i have upgraded to 2.4.7-pre6, and the problem has reappeared, this
time when closing a stuck ssh connection. same sysrq behaviour, no
logs.

when not forwarding ftp or ssh sessions, the box has had uptimes of
more than a week, so i think the problem may be netfilter related.
see below for my netfilter setting. (the same setting has run w/o
problems in earlier 2.4 kernels.)

i'd welcome hints to nail down the problem. if you want me to run
further tests or need more info, let me know.

yours,

jörn

ps: if possible, cc: me on followups, because i only read lkml
through the archive.


----

#iptables -L -v 
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source              
destination
67171   27M block      all  --  any    any     anywhere            
anywhere
 
Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source              
destination
  285 16924 TCPMSS     tcp  --  any    any     anywhere            
anywhere           tcp flags:SYN,RST/SYN TCPMSS clamp to PMTU
 6690 3628K block      all  --  any    any     anywhere            
anywhere
 
Chain OUTPUT (policy ACCEPT 67143 packets, 47732223 bytes)
 pkts bytes target     prot opt in     out     source              
destination
 
Chain block (2 references)
 pkts bytes target     prot opt in     out     source              
destination
71441   30M ACCEPT     all  --  any    any     anywhere            
anywhere           state RELATED,ESTABLISHED
 1848  152K ACCEPT     all  --  !ppp0  any     anywhere            
anywhere           state NEW
    0     0 ACCEPT     tcp  --  any    any     anywhere            
anywhere           tcp dpt:ssh
    0     0 ACCEPT     tcp  --  any    any     anywhere            
anywhere           tcp dpt:http
   38  1792 ACCEPT     tcp  --  any    any     anywhere            
anywhere           tcp dpts:1024:65535
  534 31915 DROP       all  --  any    any     anywhere            
anywhere

-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/
