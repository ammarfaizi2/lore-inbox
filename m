Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUGHPHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUGHPHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUGHPHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:07:19 -0400
Received: from web51801.mail.yahoo.com ([206.190.38.232]:22940 "HELO
	web51801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263626AbUGHPGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:06:23 -0400
Message-ID: <20040708150543.29156.qmail@web51801.mail.yahoo.com>
Date: Thu, 8 Jul 2004 08:05:43 -0700 (PDT)
From: Tejas Vora <voratejasa@yahoo.com>
Subject: BAD TCP CHECKSUM over PPP
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am facing a starnge problem regaridng PPP connection
from Windows machine to the linux server.

I am seeing lots of Incorrect TCP Checksum packets on
the PPP windows client. I am connecting from the
Windows 2000 machine.
I am trying to connect using PPP connection and
connecting to the FTP server on the Linux machine.

The problem is once in a while on the client machine I
see lots of packet with Incorrect TCP checksum error.
Normally I receive the TCP packets properly, but
suddenly it starts showing the packet with having
WRONG TCP checksum.

And this continues until the receive window size - and
all those packets willbe shown as having WRONG TCP
checksum. And then FTP Server on linux machine will
start retransmission of all those lost packets - and
due to what my downloading BW is going down.

I read so many mails in the previous mailing list and
found out that this problem is due to the VJ
Compression - and if I turn of this feature in Windows
machine - then everything seems to be working fine  -
except little bit lower downloading speed. 

Now this is a very strange problem. The project we are
working requires the FTP DOWNLOADING TESTING with IP
Compression on on the client side while connecting to
the server. So I have to resolve this problem without
disabling the IP Compression on Windows client
machine.

Alos - one INTERESTING observation I have made is - if
we TURN ON the tcp_timesstamps flag in
/proc/sys/net/ipv4 then everything seems to be working
fine - bi=ut if we TURN OFF the flag then only this
INCORRECT (BAD) TCP CHECKSUM error will show up on the
client side. But somehow we have to TURN THIS OFF - as
enabling it would cost some time and we dont want
that.

I have taken a TCP dump on the client machine and
found out that - the first packet it evaluates as
havin BAD CHECKSUM - has the CORRECT CHECKSUM of the
folloing packets and so on unitl the whole chunk of
BAD CHECKSUM finishes. I mean the checksum of the
first BAD CHECKSUM PACKET is the correct checksum of
the THIRD BAD CHECKSUM PACKET, checksum of 2nd if the
correct checksum of 4th paqcket and so on...

Now this is a kind of big trouble for us - as we have
to overcome this problem and show the downloading
performace without turning of the IP COMPRESSION AND
WITH DISABLING THE tcp_timestamps flag.

So, not the problem is whaqt can be wrong and how to
deal with this issue....

Our configuration of the Linux machine is :
----------------------------------------------

RedHat 7.3
Kernel - 2.4.18-3smp
initrd - 2.4.18-3smp.img
1 GB RAM
Machine is running with SCSI Hardisks.

Client Side
--------------------
Windows 2000 
Dial-up conection using Cellular phone (with IP
COMPRESSION ON) - we have to turn this on only -
requirement
We rae using the Cellular phone as we are working on
improving the perfornce over Wireless NW.

Also below is the copy of the dump having this problem
----------------------------------------------------------
10.100.5.1 - Linux FTP server
10.103.33.16 - Windows Client

18:15:41.775278 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 826177:827637(1460) ack 1 win 5840 (DF)
(ttl 59, id 33654, len 1500)
18:15:41.795307 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 827637:829097(1460) ack 1 win 5840 (DF)
(ttl 59, id 33655, len 1500)
18:15:41.795307 10.103.33.16.1100 > 10.100.5.1.2369: .
[tcp sum ok] 1:1(0) ack 829097 win 64512 (DF) (ttl
128, id 4657, len 40)
18:15:41.805321 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 829097:830557(1460) ack 1 win 5840 (DF)
(ttl 59, id 33656, len 1500)
18:15:41.805321 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 830557:832017(1460) ack 1 win 5840 (DF)
(ttl 59, id 33657, len 1500)
18:15:41.805321 10.103.33.16.1100 > 10.100.5.1.2369: .
[tcp sum ok] 1:1(0) ack 832017 win 64512 (DF) (ttl
128, id 4658, len 40)
18:15:42.536372 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 832017:833477(1460) ack 1 win
5840 (DF) (ttl 59, id 33658, len 1500)
18:15:42.576430 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 833477:834937(1460) ack 1 win
5840 (DF) (ttl 59, id 33659, len 1500)
18:15:42.576430 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 834937:836397(1460) ack 1 win
5840 (DF) (ttl 59, id 33660, len 1500)
18:15:42.576430 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 836397:837857(1460) ack 1 win
5840 (DF) (ttl 59, id 33661, len 1500)
18:15:42.586444 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 837857:839317(1460) ack 1 win
5840 (DF) (ttl 59, id 33662, len 1500)
18:15:42.586444 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 839317:840777(1460) ack 1 win
5840 (DF) (ttl 59, id 33663, len 1500)
18:15:42.586444 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 840777:842237(1460) ack 1 win
5840 (DF) (ttl 59, id 33664, len 1500)
18:15:42.606473 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 842237:843697(1460) ack 1 win
5840 (DF) (ttl 59, id 33665, len 1500)
18:15:42.606473 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 843697:845157(1460) ack 1 win
5840 (DF) (ttl 59, id 33666, len 1500)
18:15:42.606473 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 845157:846617(1460) ack 1 win
5840 (DF) (ttl 59, id 33667, len 1500)
18:15:42.626502 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 846617:848077(1460) ack 1 win
5840 (DF) (ttl 59, id 33668, len 1500)
18:15:42.626502 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 848077:849537(1460) ack 1 win
5840 (DF) (ttl 59, id 33669, len 1500)
18:15:42.626502 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 849537:850997(1460) ack 1 win
5840 (DF) (ttl 59, id 33670, len 1500)
18:15:42.626502 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 850997:852457(1460) ack 1 win
5840 (DF) (ttl 59, id 33671, len 1500)
18:15:42.626502 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 852457:853917(1460) ack 1 win
5840 (DF) (ttl 59, id 33672, len 1500)
18:15:42.626502 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 853917:855377(1460) ack 1 win
5840 (DF) (ttl 59, id 33673, len 1500)
18:15:42.646531 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 855377:856837(1460) ack 1 win
5840 (DF) (ttl 59, id 33674, len 1500)
18:15:42.646531 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 856837:858297(1460) ack 1 win
5840 (DF) (ttl 59, id 33675, len 1500)
18:15:42.656545 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 858297:859757(1460) ack 1 win
5840 (DF) (ttl 59, id 33676, len 1500)
18:15:42.656545 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 859757:861217(1460) ack 1 win
5840 (DF) (ttl 59, id 33677, len 1500)
18:15:42.656545 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 861217:862677(1460) ack 1 win
5840 (DF) (ttl 59, id 33678, len 1500)
18:15:42.666560 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 862677:864137(1460) ack 1 win
5840 (DF) (ttl 59, id 33679, len 1500)
18:15:42.666560 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 864137:865597(1460) ack 1 win
5840 (DF) (ttl 59, id 33680, len 1500)
18:15:42.666560 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 865597:867057(1460) ack 1 win
5840 (DF) (ttl 59, id 33681, len 1500)
18:15:42.666560 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 867057:868517(1460) ack 1 win
5840 (DF) (ttl 59, id 33682, len 1500)
18:15:42.666560 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 868517:869977(1460) ack 1 win
5840 (DF) (ttl 59, id 33683, len 1500)
18:15:42.686588 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 869977:871437(1460) ack 1 win
5840 (DF) (ttl 59, id 33684, len 1500)
18:15:42.686588 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 871437:872897(1460) ack 1 win
5840 (DF) (ttl 59, id 33685, len 1500)
18:15:42.686588 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 872897:874357(1460) ack 1 win
5840 (DF) (ttl 59, id 33686, len 1500)
18:15:42.706617 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 874357:875817(1460) ack 1 win
5840 (DF) (ttl 59, id 33687, len 1500)
18:15:42.706617 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 875817:877277(1460) ack 1 win
5840 (DF) (ttl 59, id 33688, len 1500)
18:15:42.706617 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 877277:878737(1460) ack 1 win
5840 (DF) (ttl 59, id 33689, len 1500)
18:15:42.706617 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 878737:880197(1460) ack 1 win
5840 (DF) (ttl 59, id 33690, len 1500)
18:15:42.706617 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 880197:881657(1460) ack 1 win
5840 (DF) (ttl 59, id 33691, len 1500)
18:15:42.726646 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 881657:883117(1460) ack 1 win
5840 (DF) (ttl 59, id 33692, len 1500)
18:15:42.726646 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 883117:884577(1460) ack 1 win
5840 (DF) (ttl 59, id 33693, len 1500)
18:15:42.726646 10.100.5.1.2369 > 10.103.33.16.1100: P
[bad tcp cksum 680b!] 884577:885913(1336) ack 1 win
5840 (DF) (ttl 59, id 33694, len 1376)
18:15:42.726646 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 885913:887373(1460) ack 1 win
5840 (DF) (ttl 59, id 33695, len 1500)
18:15:43.617928 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 887373:888833(1460) ack 1 win
5840 (DF) (ttl 59, id 33696, len 1500)
18:15:45.480606 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 888833:890293(1460) ack 1 win
5840 (DF) (ttl 59, id 33697, len 1500)
18:15:48.364753 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 890293:891753(1460) ack 1 win
5840 (DF) (ttl 59, id 33698, len 1500)
18:15:51.359059 10.100.5.1.2369 > 10.103.33.16.1100: .
[bad tcp cksum 680b!] 891753:893213(1460) ack 1 win
5840 (DF) (ttl 59, id 33699, len 1500)
18:15:54.363379 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 832017:833477(1460) ack 1 win 5840 (DF)
(ttl 59, id 33702, len 1500)
18:15:54.563667 10.103.33.16.1100 > 10.100.5.1.2369: .
[tcp sum ok] 1:1(0) ack 833477 win 64512 (DF) (ttl
128, id 4659, len 40)
18:15:55.084416 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 833477:834937(1460) ack 1 win 5840 (DF)
(ttl 59, id 33703, len 1500)
18:15:55.094430 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 834937:836397(1460) ack 1 win 5840 (DF)
(ttl 59, id 33704, len 1500)
18:15:55.094430 10.103.33.16.1100 > 10.100.5.1.2369: .
[tcp sum ok] 1:1(0) ack 836397 win 64512 (DF) (ttl
128, id 4660, len 40)
18:15:55.104444 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 836397:837857(1460) ack 1 win 5840 (DF)
(ttl 59, id 33705, len 1500)
18:15:55.224617 10.100.5.1.2369 > 10.103.33.16.1100: .
[tcp sum ok] 837857:839317(1460) ack 1 win 5840 (DF)
(ttl 59, id 33706, len 1500)

Does anybody have any ide regarding this issue and
what could be wrong and what could be solution for
this.

Tejas Vora

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
