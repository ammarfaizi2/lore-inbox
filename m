Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290725AbSAYQzx>; Fri, 25 Jan 2002 11:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290726AbSAYQzo>; Fri, 25 Jan 2002 11:55:44 -0500
Received: from mail.udm.ru ([217.14.192.20]:15121 "EHLO aps.mark-itt.ru")
	by vger.kernel.org with ESMTP id <S290725AbSAYQzg>;
	Fri, 25 Jan 2002 11:55:36 -0500
Date: Fri, 25 Jan 2002 20:58:22 +0400
From: ASA <llb@udm.net.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: ASA <llb@udm.net.ru>
Organization: LLB, LLC
X-Priority: 3 (Normal)
Message-ID: <1038781885.20020125205822@udm.net.ru>
To: linux-kernel@vger.kernel.org
Subject: Too big EBDA issue
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

My system is embedded PC/104 and has C&T 65545 videochip and DiskOnChip
flash device. I'm developing a special linux-based application.

Today I had to upgrade DiskOnChip BIOS extender and after that I could not
boot linux anymore. After digging hard in problem I found that EBDA was
enlarged to 33KB so remaining conventional memory was reduced to 607KB but
normal booting proccess bzImage loading requires at least 608 KB. After
checking on other systems with DiskOnChip I found their EBDA have sizes
typically of 29-31 KB.

Yeah, it is very large EBDA (normal PC's I checked just have only 1 KB
EBDA). It seems DickOnChip BIOS requires much space on irder to store own
temporary data to implement their TrueFFS.

But I guess that there will be some other BIOS extensions that will require
another EBDA space. As far as bzImage loading model requires space of 32 K
between 576K (0x90000) and 608K (0x98000) but almost no other place I think
there is necessity to extend boot protocol in order to relocate 16-bit mode
loader closer to the lowest memory bound, not to the upper one.

I also reported that issue to DiskOnChip developers (www.m-sys.com) but
there is a possibility that other hardware developers can extend EBDA also.

So extending boot protocol in order to move far away of cancer of growing
EBDA would be worthly of note. As a new feature for 2.5/2.6 kernels by
example.

-- 
Best regards,
 ASA                          mailto:llb@udm.net.ru

