Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTLXBWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTLXBWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:22:14 -0500
Received: from relay01.kbs.net.au ([203.220.32.149]:38622 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S263062AbTLXBWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:22:11 -0500
Message-ID: <03b201c3c9bc$5d977ef0$7301a8c0@internal.kbs.net.au>
From: "Paul" <paul@kbs.net.au>
To: <linux-kernel@vger.kernel.org>
References: <E1AYl4w-0007A5-R3@O.Q.NET> <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net> <20031223173429.GA9032@mark.mielke.cc> <20031223220209.GB15946@kroah.com> <1072226715.6917.50.camel@nosferatu.lan> <20031224010728.GA20956@kroah.com>
Subject: memory mapping help - oracle stack dumps
Date: Wed, 24 Dec 2003 12:22:13 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am working on an oracle9i problem and have been liasing with their
support. However we keep seeing crashes for the oracle dispatcher process,
which is like a TCP port listener agent.
We've been working on this problem for around 6 months now and still yet to
have a solution. I have just noticed that in each of our core dump files
(20+) there is a pattern. Each time the problem occurs (crash) it references
the same code, function call and what appears to be a memory address, or a
register address.

I don't know memory/registers that well and was just wondering if there is a
way I can identify where this "memory" is, is it virtual/chips/registers if
so is there someway in /proc that I can identify what memory bank or chip is
it. Below is the core dump and the line which the core dump references each
time begins with "> ". It seems this function call (including the exact
paramters and memory addresses) is common in all core dumps. Has anyone seen
this kinda of situation before? Any ideas would be great :)

Dell PowerEdge 2600
Single Xeon 3.06GHZ
3GB of DDR ECC
2.4.19-64GB-SMP

Exception signal: 11 (SIGSEGV), code: 1 (Address not mapped to object),
addr: 0x4214, PC: [0x404c2746, chunk_free()+246]
Registers:
%eax: 0x0000420c %ebx: 0x4056cc90 %ecx: 0x0000420c
%edx: 0x0aa7a278 %edi: 0x00000a98 %esi: 0x0ab05da0
%esp: 0xbfffd3a4 %ebp: 0xbfffd3cc %eip: 0x404c2746
%efl: 0x00010206
  chunk_free()+234 (0x404c273a) mov 0x8(%ecx),%edx
  chunk_free()+237 (0x404c273d) mov %ecx,0xc(%esi)
  chunk_free()+240 (0x404c2740) mov %edx,0x8(%esi)
  chunk_free()+243 (0x404c2743) mov %esi,0xc(%edx)
> chunk_free()+246 (0x404c2746) mov %esi,0x8(%ecx)
  chunk_free()+249 (0x404c2749) mov 0xffffffe8(%ebp),%eax
  chunk_free()+252 (0x404c274c) cmp $15,0x4(%eax)
  chunk_free()+256 (0x404c2750) ja 0x404c2780
  chunk_free()+258 (0x404c2752) cmp 0xffffbe60(%ebx),%edi
*** 2003-11-10 06:39:34.720
ksedmp: internal or fatal error
ORA-07445: exception encountered: core dump [chunk_free()+246] [SIGSEGV]
[Address not mapped to object] [0x4214] [] []

Thanks,

Paul

