Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286099AbRLIAJM>; Sat, 8 Dec 2001 19:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286096AbRLIAIw>; Sat, 8 Dec 2001 19:08:52 -0500
Received: from vp242.dmp01.sea.blarg.net ([206.124.142.242]:34184 "EHLO
	mail.rudedog.org") by vger.kernel.org with ESMTP id <S286090AbRLIAIr>;
	Sat, 8 Dec 2001 19:08:47 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.16: Bizarre TCP throughput problems
From: Dave Carrigan <dave@rudedog.org>
Organization: Rudedog.org
Date: 08 Dec 2001 16:08:45 -0800
Message-ID: <87d71pl0fm.fsf@cbgb.rudedog.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I am not subscribed, so please CC me with any responses)

I am having a very problem with TCP throughput between two systems
running on my LAN. The problem system works fine with 2.4.14, but has
abysmal TCP throughput under 2.4.16, but only when talking to some
systems on the LAN. Here is a chart with some tests that I made:

 Client		Server	Protocol	Throughput
 cbgb-2.4.16	pern	NFS/UDP		~12 MB/s, .5s to copy a 5MB file
 cbgb-2.4.14	pern	HTTP/TCP	 12 MB/s, .5s to copy a 5MB file
 cbgb-2.4.16	pern	HTTP/TCP	7.45 KB/s, 300s to copy a 2MB file
 cbgb-2.4.16	pern	SCP/TCP		(Very poor; I was too impatient to measure)
 cbgb-2.4.16	heechee	SCP/TCP		  84 KB/s, 1 minute to copy a 5MB file
 cbgb-2.4.16	idoru	HTTP/TCP	  54 KB/s, 21s to copy a 1.2MB file
 heechee-2.4.16	pern	HTTP/TCP	1024 KB/s, 5s to copy a 5MB file
 vmware-2.2.19	pern	HTTP/TCP	 297 KB/s, 18s to copy a 5MB file
 pern		cbgb	SCP/TCP		 297 KB/s, 19s to copy a 5MB file

- cbgb is the problem system; with a tulip card.
- pern is the problem server; also with a tulip card.
- heechee is my firewall with a 8139too card.
- idoru is a server on the other end of a SSH VPN (DSL at both ends).
- vmware is a virtual vmware machine running inside of cbgb.

As you can see from the chart, NFS over UDP between cbgb and pern is
fine. However HTTP over TCP has terrible performance; 2.4.14 has orders
of magnitude better performance. It's not pern's problem, because
heechee has no trouble transferring the same file. It's also not
exclusively cbgb's fault, because it doesn't seem to have any problems
talking to idoru or to heechee. Nor are there any problems going the
other way (copying from cbgb to pern). The most bizarre thing is my test
on the vmware machine. It also doesn't seem to have problems
communicating with pern, even though it's a virtual machine that is
obviously using cbgb's hardware to do the copying. I should also add
that interactive ssh from cbgb to pern seems fine.

Pern's card is a 'Lite-On Communications Inc LNE100TX (rev 32)'.
Cbgb's card is a 'Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100] (rev 37)'.

Does anyone have any suggestions as to what's going on here?

-- 
Dave Carrigan (dave@rudedog.org)            | Yow! These PRESERVES should be
UNIX-Apache-Perl-Linux-Firewalls-LDAP-C-DNS | FORCE-FED to PENTAGON
Seattle, WA, USA                            | OFFICIALS!!
http://www.rudedog.org/                     | 
