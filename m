Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbQLMMil>; Wed, 13 Dec 2000 07:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131135AbQLMMic>; Wed, 13 Dec 2000 07:38:32 -0500
Received: from Nabiki.Mountain.Net ([198.77.1.5]:40091 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S131153AbQLMMiT>; Wed, 13 Dec 2000 07:38:19 -0500
Message-ID: <3A37667E.F70C215B@mountain.net>
Date: Wed, 13 Dec 2000 07:07:26 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Jasper Spaans <jasper@spaans.ds9a.nl>
Subject: [OOPS] nfs, similar to raid5 bug reports
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This from attempting to read a nfs mounted directory. ext2 in this case,
also had one with isofs over nfs.

This looks suspiciously like Jasper Spaans' current report on raid5.

Tom


Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c01c0c32
*pde = 00000000

Entering kdb (current=0xc1abc000, pid 481) Panic: Oops
due to panic @ 0xc01c0c32
eax = 0x00000000 ebx = 0x00000000 ecx = 0xc3544fb0 edx = 0x0000048c 
esi = 0xc25d64f0 edi = 0x00000000 esp = 0xc1abdc24 eip = 0xc01c0c32 
ebp = 0xc1abdc40 xss = 0x00000018 xcs = 0xc3540010 eflags = 0x00010246 
xds = 0x31010018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1abdbf0
kdb> bt
    EBP       EIP         Function(args)
0xc1abdc40 0xc01c0c32 ip_frag_queue+0x222 (0xc3544fb0, 0xc25d64f0)
                               kernel .text 0xc0100000 0xc01c0a10 0xc01c0c90
0xc1abdc6c 0xc01c1004 ip_defrag+0xc4 (0xc25d64f0)
                               kernel .text 0xc0100000 0xc01c0f40 0xc01c1070
0xc1abdc84 0xc4093365 [ip_conntrack]ip_ct_gather_frags+0x25 (0xc25d64f0)
                               ip_conntrack .text 0xc4091060 0xc4093340
0xc40933e0
0xc1abdccc 0xc40924cd [ip_conntrack]ip_conntrack_in+0x3d (0x3, 0xc1abdd54,
0x0, 0xc20ea800, 0xc01c3560)
                               ip_conntrack .text 0xc4091060 0xc4092490
0xc40927b0
0xc1abdce8 0xc4094666 [ip_conntrack]ip_conntrack_local+0x56 (0x3,
0xc1abdd54, 0x0, 0xc20ea800, 0xc01c3560)
                               ip_conntrack .text 0xc4091060 0xc4094610
0xc4094670
0xc1abdd10 0xc01b2d98 nf_iterate+0x28 (0xc0320cd8, 0xc1abdd54, 0x3, 0x0,
0xc20ea800)
                               kernel .text 0xc0100000 0xc01b2d70 0xc01b2e00
0xc1abdd44 0xc01b3001 nf_hook_slow+0x71 (0x2, 0x3, 0xc25d64f0, 0x0,
0xc20ea800)
                               kernel .text 0xc0100000 0xc01b2f90 0xc01b3080
0xc1abddb4 0xc01c2c27 ip_build_xmit_slow+0x387 (0xc1a757f0, 0xc01d74d0,
0xc1abde5c, 0x1030, 0xc1abde74)
                               kernel .text 0xc0100000 0xc01c28a0 0xc01c2d00
0xc1abddf4 0xc01c2d4b ip_build_xmit+0x4b (0xc1a757f0, 0xc01d74d0,
0xc1abde5c, 0x1030, 0xc1abde74)
                               kernel .text 0xc0100000 0xc01c2d00 0xc01c2ff0
0xc1abde80 0xc01d78f3 udp_sendmsg+0x313 (0xc1a757f0, 0xc1abdf04, 0x1014)
                               kernel .text 0xc0100000 0xc01d75e0 0xc01d7970
0xc1abde98 0xc01dc9e9 inet_sendmsg+0x39 (0xc1a09834, 0xc1abdf04, 0x1014,
0xc1abdec8, 0xc1abc000)
more> 
                               kernel .text 0xc0100000 0xc01dc9b0 0xc01dc9f0
0xc1abdedc 0xc01b104a sock_sendmsg+0x7a (0xc1a09834, 0xc1abdf04, 0x1014)
                               kernel .text 0xc0100000 0xc01b0fd0 0xc01b1070
0xc1abdf20 0xc4054832 [sunrpc]svc_sendto+0x82 (0xc1abf000, 0xc1abf14c, 0x1)
                               sunrpc .text 0xc404e060 0xc40547b0 0xc4054880
0xc1abdf3c 0xc4054cd7 [sunrpc]svc_udp_sendto+0x37 (0xc1abf000)
                               sunrpc .text 0xc404e060 0xc4054ca0 0xc4054d00
0xc1abdf58 0xc4055a66 [sunrpc]svc_send+0x76 (0xc1abf000)
                               sunrpc .text 0xc404e060 0xc40559f0 0xc4055b20
0xc1abdfb0 0xc405442c [sunrpc]svc_process+0x31c (0xc3544570, 0xc1abf000)
                               sunrpc .text 0xc404e060 0xc4054110 0xc4054640
0xc1abdfec 0xc4071332 [nfsd]nfsd+0x192
                               nfsd .text 0xc4071060 0xc40711a0 0xc40714a0
           0xc0107843 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0107820 0xc0107860
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
