Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131652AbRALAIo>; Thu, 11 Jan 2001 19:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbRALAIf>; Thu, 11 Jan 2001 19:08:35 -0500
Received: from mailhost2.dircon.co.uk ([194.112.32.66]:48390 "EHLO
	mailhost2.dircon.co.uk") by vger.kernel.org with ESMTP
	id <S129631AbRALAI1>; Thu, 11 Jan 2001 19:08:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14942.18985.174437.785751@starfruit.iwks.multi.local>
Date: Fri, 12 Jan 2001 00:04:57 +0000 (GMT)
From: Mark Longair <list-reader@ideaworks3d.com>
To: linux-kernel@vger.kernel.org
Subject: [2.2.18] outgoing connections getting stuck in SYN_SENT
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem where twice a day or so, any new tcp connection
it gets stuck in SYN_SENT.  Eventually this situation rights itself,
but obviously in the meantime many services (e.g. squid, X) are
broken.  The machine does IP masquerdading with ipchains, and
masqueraded connections through it seem to be unaffected.  The kernel
version is 2.2.18, although the same happened with 2.2.17.

I can't work out what's causing this to happen, or how to fix it when
it occurs, short of rebooting.  (Killing off daemons, lowering and
raising the network interfaces, etc. have no effect on the problem.)
It is still possible to connect to the computer (e.g. with ssh) while
the problem is happening.  I'm logging all packets that are rejected
by the ipchains setup, but no rejected packets appear in the logs when
you attempt an outgoing connection.

I've included a tcpdump of an attempt to `wget http://www.yahoo.com/'
while the problem is occuring.  (This is a dump of the external
network interface, an EtherExpress Pro100.)  AIUI, the first two lines
are as you would expect, but then it tells the server that the
external interface is unreachable.  I'm not sure what this means; that
address can still be pinged from everywhere.

I've searched around for similar problems on this list, the web and
dejanews, but I haven't found anything that has helped.  I'd be very
grateful for any suggestions - my apologies if I've missed something
obvious.

cheers
mark

This output is from `tcpdump -i eth0 -vvv | grep yahoo' just before
`wget http://www.yahoo.com/':

18:38:15.361774 starfruit.iw3d.co.uk.2327 > www9.dcx.yahoo.com.www: S 2996758185:2996758185(0) win 32120 <mss 1460,sackOK,timestamp 1360740[|tcp]> (DF) (ttl 64, id 14541)
18:38:15.465524 www9.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2327: S 3898083689:3898083689(0) ack 2996758186 win 17520 <mss 1460> (DF) [tos 0x60] (ttl 44, id 51680)
18:38:15.472910 starfruit.iw3d.co.uk > www9.dcx.yahoo.com: icmp: host starfruit.iw3d.co.uk unreachable [tos 0xc0] (ttl 255, id 14557)
18:38:15.472943 starfruit.iw3d.co.uk > www3.dcx.yahoo.com: icmp: host starfruit.iw3d.co.uk unreachable [tos 0xc0] (ttl 255, id 14558)
18:38:18.352908 starfruit.iw3d.co.uk.2327 > www9.dcx.yahoo.com.www: S 2996758185:2996758185(0) win 32120 <mss 1460,sackOK,timestamp 1361040[|tcp]> (DF) (ttl 64, id 14564)
18:38:18.456461 www9.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2327: . ack 1 win 17520 (DF) [tos 0x60] (ttl 44, id 57794)
18:38:18.463769 www9.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2327: S 3898083689:3898083689(0) ack 2996758186 win 17520 <mss 1460> (DF) [tos 0x60] (ttl 44, id 57809)
18:38:20.602904 starfruit.iw3d.co.uk.2325 > www3.dcx.yahoo.com.www: S 2983862334:2983862334(0) win 32120 <mss 1460,sackOK,timestamp 1361265[|tcp]> (DF) (ttl 64, id 14569)
18:38:20.729037 www3.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2325: . ack 2983862335 win 17520 (DF) [tos 0x60] (ttl 44, id 49883)
18:38:21.145902 www3.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2325: S 992130302:992130302(0) ack 2983862335 win 17520 <mss 1460> (DF) [tos 0x60] (ttl 44, id 50913)
18:38:21.452904 starfruit.iw3d.co.uk > www3.dcx.yahoo.com: icmp: host starfruit.iw3d.co.uk unreachable [tos 0xc0] (ttl 255, id 14570)
18:38:21.452920 starfruit.iw3d.co.uk > www3.dcx.yahoo.com: icmp: host starfruit.iw3d.co.uk unreachable [tos 0xc0] (ttl 255, id 14571)
18:38:24.352902 starfruit.iw3d.co.uk.2327 > www9.dcx.yahoo.com.www: S 2996758185:2996758185(0) win 32120 <mss 1460,sackOK,timestamp 1361640[|tcp]> (DF) (ttl 64, id 14573)
18:38:24.457700 www9.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2327: . ack 1 win 17520 (DF) [tos 0x60] (ttl 44, id 4335)
18:38:24.468653 www9.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2327: S 3898083689:3898083689(0) ack 2996758186 win 17520 <mss 1460> (DF) [tos 0x60] (ttl 44, id 4354)
18:38:24.727569 www3.dcx.yahoo.com.www > starfruit.iw3d.co.uk.2326: S 1025447007:1025447007(0) ack 2988099611 win 17520 <mss 1460> (DF) [tos 0x60] (ttl 44, id 59842)
18:38:25.092905 starfruit.iw3d.co.uk > www3.dcx.yahoo.com: icmp: host starfruit.iw3d.co.uk unreachable [tos 0xc0] (ttl 255, id 14574)
18:38:25.092924 starfruit.iw3d.co.uk > www9.dcx.yahoo.com: icmp: host starfruit.iw3d.co.uk unreachable [tos 0xc0] (ttl 255, id 14575)

This is the start of the output of `netstat -ape' from another
occasion when the problem occurred - I've snipped most of the (very
similar) output; any new outgoing connections get into the same
SYN_SENT, one byte in Send-Q state that the fetchmail daemons at the
top are in.

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name   
tcp        0      1 starfruit.iw3d.co.:2391 mango.iw3d.co.uk:pop3   SYN_SENT    mark       11996      828/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2387 eidosnet.co.uk:pop3     SYN_SENT    mjs        11739      493/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2384 mango.iw3d.co.uk:pop3   SYN_SENT    mjs        11594      493/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2383 mango.iw3d.co.uk:pop3   SYN_SENT    mark       11590      828/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2382 *:*                     CLOSE       mjs        11561      493/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2381 *:*                     CLOSE       mark       11533      828/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2380 *:*                     CLOSE       root       11528      279/stunnel         
tcp        0      0 starfruit.iw3d.co.u:ssh modem-246.elros.di:3841 ESTABLISHED root       11493      2123/sshd           
tcp        0      1 starfruit.iw3d.co.:2378 *:*                     CLOSE       mark       11457      828/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2377 *:*                     CLOSE       mjs        11420      493/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2376 *:*                     CLOSE       mark       11411      828/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2372 *:*                     CLOSE       mjs        11374      493/fetchmail       
tcp        0      1 starfruit.iw3d.co.:2359 *:*                     CLOSE       mjs        10866      493/fetchmail       
[...]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
