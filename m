Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271140AbTHCKRw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271141AbTHCKRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:17:52 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:52747 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S271140AbTHCKRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:17:50 -0400
To: linux-kernel@vger.kernel.org
Cc: ollie@sis.com.tw
Subject: [BUG] 2.6.0-t1 sis900 timeout
Mail-Copies-To: nobody
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sun, 03 Aug 2003 12:21:35 +0200
Message-ID: <plopm3smoj11ow.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm  running 2.6.0-test1-ac3  on my  sis-based laptop,  and  I've some
problems with  the sis  900 networking card:  in a  low-bandwith usage
(like a ssh to another computer,  or a copy from another computer with
a 10Mbps card), I get some network freezes, and after a few seconds it
starts again (with the following messages in the syslog):

Aug  3 11:55:13 kesto kernel: eth0: Media Link Off
Aug  3 11:55:22 kesto kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug  3 11:55:22 kesto kernel: eth0: Transmit timeout, status 00000004 00000000 
Aug  3 11:55:23 kesto kernel: eth0: Media Link On 100mbps full-duplex 

When I  copy files  to another 100  Mbps laptop (with  a cross-cable),
after a short while the network  stops completly to work, and I cannot
even rmmod sis900 (device or ressource busy).

If you want the /proc/pci entry for the network card:

  Bus  0, device   1, function  1:
    Ethernet controller: Silicon Integrated S SiS900 10/100 Ethern (rev 130).
      IRQ 10.
      Master Capable.  Latency=128.  Min Gnt=52.Max Lat=11.
      I/O at 0x3200 [0x32ff].
      Non-prefetchable 32 bit memory at 0x44000000 [0x44000fff].

I've enabled preempt and local  APIC in my kernel configuration, but I
used to patch my 2.4 kernels  with preempt before switching to 2.6 and
I never had any network-related problem.

As a side-node,  I can tell you  that when we (a friend  and I) ported
the sis900  driver to GNU Mach,  we had to  add a delay loop  (I know,
it's ugly, but it's just a quick-and-dirty patch while waiting for the
OSKit-based GNU Mach) in the sis900_start_xmit function. With no delay
at  all  the  driver  stopped  to  work  after  one  packet  has  been
transmitted, with  a small delay  it worked for  low-bandwidth program
(say, a "ping 192.168.1.1") but not for a file transfert, I had to add
a bigger one to make it work fine.

I'm available if you need additional informations.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
