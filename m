Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277123AbRJHVCi>; Mon, 8 Oct 2001 17:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277134AbRJHVC3>; Mon, 8 Oct 2001 17:02:29 -0400
Received: from sndmz04e.vd.ch ([145.232.253.16]:63712 "EHLO sndmz04e.vd.ch")
	by vger.kernel.org with ESMTP id <S277123AbRJHVCR> convert rfc822-to-8bit;
	Mon, 8 Oct 2001 17:02:17 -0400
From: =?iso-8859-1?q?C=E9dric=20Rochat?= <crochat@younics.org>
Organization: ETSC
To: linux-kernel@vger.kernel.org
Subject: Kernel crash with ISDN MPPP
Date: Mon, 8 Oct 2001 22:57:11 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on PBC_DMZ04/externe-VD(Release 5.0.8 |June 18, 2001) at
 10/08/2001 11:02:47 PM,
	Serialize by Router on PBC_DMZ04/externe-VD(Release 5.0.8 |June 18, 2001) at
 10/08/2001 11:02:49 PM
Message-ID: <OF03ED3D32.32234D1C-ONC1256ADF.00739CA3@vd.ch>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!

I have a little problem with a Multilink ISDN connection (MPPP).

Hardware : ISDN Eicon.Diehl Diva 2.01 PCI
or              Elsa Microlink ISDN PCI

When i try to dial with just one ISDN link :

~# isdnctrl dial ippp0
ippp0: dialing 1 0840840321...
Dialing of ippp0 triggered
isdn_net: ippp0 connected
~# ping www.urbanet.ch
PING dolent.urbanet.ch (195.202.193.103): 56 data bytes
64 bytes from 195.202.193.103: icmp_seq=0 ttl=243 time=46.7 ms
64 bytes from 195.202.193.103: icmp_seq=1 ttl=243 time=69.9 ms
64 bytes from 195.202.193.103: icmp_seq=2 ttl=243 time=70.0 ms
64 bytes from 195.202.193.103: icmp_seq=3 ttl=243 time=45.0 ms
64 bytes from 195.202.193.103: icmp_seq=4 ttl=243 time=50.0 ms
 
--- dolent.urbanet.ch ping statistics ---
5 packets transmitted, 5 packets received, 0% packet loss
round-trip min/avg/max = 45.0/56.3/70.0 ms

Here, that's OK !! That works great !! But if i try to add a link :

~# isdnctrl addlink ippp0
Ok, added a new link. (dialing)
ippp1: dialing 1 0840840321...
isdn_net: ippp1 connected
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1

~# ping www.urbanet.ch
PING dolent.urbanet.ch (195.202.193.103): 56 data bytes
64 bytes from 195.202.193.103: icmp_seq=1 ttl=243 time=47.2 ms
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
64 bytes from 195.202.193.103: icmp_seq=3 ttl=243 time=42.6 ms
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
64 bytes from 195.202.193.103: icmp_seq=5 ttl=243 time=49.0 ms
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
64 bytes from 195.202.193.103: icmp_seq=7 ttl=243 time=46.8 ms
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
64 bytes from 195.202.193.103: icmp_seq=9 ttl=243 time=51.7 ms
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
64 bytes from 195.202.193.103: icmp_seq=11 ttl=243 time=65.5 ms
isdn_ppp_xmit: lp->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
 
--- dolent.urbanet.ch ping statistics ---
12 packets transmitted, 6 packets received, 50% packet loss
round-trip min/avg/max = 42.6/50.4/65.5 ms

50 % of the packets are losed !! That's better than nothing...

OK ! That was with 2.2.19pre17 kernel !!

With 2.4.9, or 2.4.10 (i tried both of them), that's a bigger problem :
the same thing before the second link connection, but when a packet is send, 
that's the crash :

isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1
Scheduling in interrupt
kernel BUG at sched.c:706!
invalid operand: 0000
CPU:       0
EIP:         0010:[<c0111a71>]
EFLAGS: 00010086
eax:  0000001b  ebx:  c3aa2000  ecx:  c76d4000  edx:  00000001
esi:   0016b0e7  edi:   c3aa2000  ebp:  c3aa3fbc   esp:  c3aa3f78
ds:   0018   es:   0018    ss:   0018
Process fetchnews (pid: 479, stackpage=c3aa3000)
Stack:  c021c7d4  c021c936  000002c2  c3aa2000  0016b0e7  606f746b  (and a 
long list of numbers for the state of the stack...)
Call Trace [<c01086bb>] [<c0106dc9>]

Code: 0f 0b 8d 65 c8 5b 5e 5f 89 ec 5d c3 8d 76 00 55 89 e5 83 ec
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

I tried with two different ISDN cards, and i tried with a PIII 550, and with 
an Athlon 1000.

What's this crazy crash ???
-- 

================================
Cédric Rochat
Ch. du Commonet 4
1341 L'Orient (CH - Switzerland)
mail: crochat@younics.org
homepage: http://www.younics.org

ICQ: 70815513
