Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276095AbRI1OzI>; Fri, 28 Sep 2001 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276090AbRI1Oyy>; Fri, 28 Sep 2001 10:54:54 -0400
Received: from [217.6.75.131] ([217.6.75.131]:55532 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S276094AbRI1OyJ>; Fri, 28 Sep 2001 10:54:09 -0400
Message-ID: <3BB4912A.414B809A@internetwork-ag.de>
Date: Fri, 28 Sep 2001 17:03:06 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG]: 2.4.10 lockup using ppp on SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.10 (and all its 2.4.x predecessors) lock up in ppp_destroy_interface. Thanks
to the kdb I got the two tracebacks below - the all_ppp_lock interferes with
some other (socket?!) lock...
Any help is VERY much appreciated!
Thanks

Immanuel

output from kdb:

    EBP       EIP         Function(args)
           0xc02ed78a stext_lock+0x4bce
                               kernel .text.lock 0xc02e8bbc 0xc02e8bbc 0xc02f20e

0
0xf63edf3c 0xc0205698 ppp_destroy_interface+0x38 (0xf63f1800)
                               kernel .text 0xc0100000 0xc0205660 0xc0205b28
0xf63edf94 0xc02018f0 ppp_ioctl+0x2e8 (0xf6c34100, 0xf64025e0, 0x4004743c, 0x22)

                               kernel .text 0xc0100000 0xc0201608 0xc0202304
0xf63edfbc 0xc0154e39 sys_ioctl+0x239 (0x4, 0x4004743c, 0x22, 0xbffff6e4, 0x804d

f40)
                               kernel .text 0xc0100000 0xc0154c00 0xc0154ed0
           0xc01076ef system_call+0x33
                               kernel .text 0xc0100000 0xc01076bc 0xc01076f4
[0]kdb> cpu 1

Entering kdb (current=0xf61a0000, pid 525) on processor 1 due to cpu switch
[1]kdb> bt
    EBP       EIP         Function(args)
           0xc02eeae0 stext_lock+0x5f24
                               kernel .text.lock 0xc02e8bbc 0xc02e8bbc 0xc02f20e

0
0xf61a1f94 0xc0276157 sock_ioctl+0xe3 (0xf61da760, 0xf61a2da0, 0x8914, 0xbffff42

c)
                               kernel .text 0xc0100000 0xc0276074 0xc0276170
0xf61a1fbc 0xc0154e39 sys_ioctl+0x239 (0x5, 0x8914, 0xbffff42c, 0x4, 0xbffff44c)

                               kernel .text 0xc0100000 0xc0154c00 0xc0154ed0
           0xc01076ef system_call+0x33
                               kernel .text 0xc0100000 0xc01076bc 0xc01076f4


--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



