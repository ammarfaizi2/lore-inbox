Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSEHPTS>; Wed, 8 May 2002 11:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314453AbSEHPTS>; Wed, 8 May 2002 11:19:18 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:20849 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S313563AbSEHPTQ>; Wed, 8 May 2002 11:19:16 -0400
Message-ID: <3CD941F0.3030805@blue-labs.org>
Date: Wed, 08 May 2002 11:19:12 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] PPPoE again.  2.4.19-pre6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens every few days, no apparent ill effect, pppd restarts fine 
and runs for a few more days.  This happens within a few seconds of pppd 
losing connection for some reason.  The events leading up to this are as 
follows.  I walk in in the morning and the ppp0 interface is dead, not 
passing any packets.  It looks perfectly fine save for that which I know 
is wrong because I have a near constant 10Kbps flow of data.

kill -1 of pppd shuts it down and when it does, the OOPS hits.  I then 
run rc.restartnetwork which does it's magic and all is well again for a 
while.  This is abnormal.  pppd reconnects every day or so but the 
interface hang only happens once in a while.

-d

May 08 10:45:03 Booterz pppd[30054]: Hangup (SIGHUP)
May 08 10:45:03 Booterz pppd[30054]: Couldn't increase MTU to 1500
May 08 10:45:03 Booterz pppd[30054]: Couldn't increase MRU to 1500
May 08 10:45:09 Booterz pppd[30054]: Connection terminated.
May 08 10:45:09 Booterz pppd[30054]: Connect time 31624.8 minutes.
May 08 10:45:09 Booterz pppd[30054]: Sent 3791766158 bytes, received 
1924515486 bytes.
May 08 10:45:09 Booterz pppd[30054]: Exit.
May 08 10:45:24 Booterz pppd[28676]: Warning: plugin rp-pppoe.so has no 
version information
May 08 10:45:24 Booterz pppd[28676]: Plugin rp-pppoe.so loaded.
May 08 10:45:24 Booterz pppd[28676]: RP-PPPoE plugin version 3.3 
compiled against pppd 2.4.2b1
May 08 10:45:24 Booterz pppd[28677]: pppd 2.4.2b1 started by root, uid 0
May 08 10:45:24 Booterz dhcpcd[30077]: terminating on signal 15
May 08 10:45:24 Booterz dhcpcd[28683]: broadcasting DHCP_REQUEST for 
68.14.9.32
May 08 10:45:25 Booterz dhcpcd[28683]: recvfrom: Network is down
May 08 10:45:25 Booterz pppd[28677]: PPP session is 9765
May 08 10:45:25 Booterz pppd[28677]: Using interface ppp0
May 08 10:45:25 Booterz pppd[28677]: Connect: ppp0 <--> eth0
May 08 10:45:25 Booterz pppd[28677]: Couldn't increase MTU to 1500
May 08 10:45:25 Booterz pppd[28677]: Couldn't increase MRU to 1500
May 08 10:45:25 Booterz dhcpcd[28683]: broadcasting DHCP_DISCOVER
May 08 10:45:25 Booterz dhcpcd[28683]: sendto: Network is down
May 08 10:45:25 Booterz pppd[28677]: Couldn't increase MRU to 1500
May 08 10:45:26 Booterz pppd[28677]: local  IP address 64.252.54.60
May 08 10:45:26 Booterz pppd[28677]: remote IP address 64.252.54.2


Unable to handle kernel NULL pointer dereference at virtual address 000000d8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c024fc1f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c57140e0   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00002526   ebp: c31773e0   esp: c0917e90
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 28677, stackpage=c0917000)
Stack: c0917f00 00000000 00000003 c601f150 0807fa74 00000001 c5e31ba0 
c05911e0
       c0127ab8 c5e31ba0 c05911e0 0807fa74 c0a3a1fc 00000000 c5c221e8 
00000246
       c6568690 c0917f00 c6568690 c0917f00 0000001e bffff7d8 c0311ac3 
c6568690
Call Trace: [<c0127ab8>] [<c0311ac3>] [<c0147ac0>] [<c03123eb>] 
[<c0143f77>]
   [<c0108bb3>]
Code: ff 8a d8 00 00 00 0f 94 c0 84 c0 74 07 52 e8 3e 96 0c 00 59

 >>EIP; c024fc1f <pppoe_connect+13f/270>   <=====
Trace; c0127ab8 <handle_mm_fault+98/e0>
Trace; c0311ac3 <sys_connect+53/70>
Trace; c0147ac0 <fcntl_setlk+a0/200>
Trace; c03123eb <sys_socketcall+7b/210>
Trace; c0143f77 <sys_fcntl64+47/90>
Trace; c0108bb3 <system_call+33/40>


