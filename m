Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVDXHRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVDXHRm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDXHRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:17:42 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:46667 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262277AbVDXHRZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:17:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kbC8QxLHz8jivIrl2PKA3zrN8/ZyqB7jzHAwIRkY44QBzzal64+37zaZHJjc5Y1ZgJ4khSpspKEacPPkzacXZYK6zqoa7Tpo3UI7DOXSoJqDBWtuKXmDvb0ddcRKFUsaVP6LwpMIELDfTu7jAsYKtkG1rRHy/8C0UKgvN+IXxCE=
Message-ID: <17d798805042400172846fd54@mail.gmail.com>
Date: Sun, 24 Apr 2005 03:17:24 -0400
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Page table question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to read the kernel page table. I use the swapper_pg_dir to
get the root of the table and I get  the following information in the
table. The first 0-767 entries are all zeroes. And then the table has
the following values.

[PGD 768]= 0x000001e3
[PGD 769]= 0x004001e3
[PGD 770]= 0x008001e3
entries in between here are incremented by 4MB
[PGD 992]= 0x0
[PGD 993]= 0x0
[PGD 994]= 0x01c32067
[PGD 995]= 0x36dad067
[PGD 996]= 0x36dac067
[PGD 997]= 0x3721c067
[PGD 998]= 0x37155067
[PGD 999]= 0x3721d067
entries here in between are 0x0
[PGD 1016]= 0x00002063
entries here in between are 0x0
[PGD 1023]= 0x00001063


The entries from 768 upto 991 are understandable as they are incremented by 4MB.
I assume that the entries from 994 to 999 , 1016 and 1023 are entries
for dynamic kernel memory.  Please correct me if I am wrong here.

Now, I try to go to the second level. (I have a Pentium processor, 1
GB of memory)
Essentially what I am trying to do is, take a symbol from /proc/ksyms
and using the page tables, find the correct page and page offset.

I started with a virtual address 0xf89b5640.
If I consider the most significant 10 bits, it maps to the 994th entry
in the PGD and 437th entry in the page table.
Using the address at that location in the PGD, which is the physical
address (0x01c32067),
I fetch the page table which kind of looks weird. These look like
virtual addresses. The 437th entry is a  virtual address. What is it
that I am doing wrong here?

[PGT 415]= 0x38
[PGT 416]= 0xf3007300
[PGT 417]= 0xf31073fc
[PGT 418]= 0xf32073fc
[PGT 419]= 0xf33073fc
[PGT 420]= 0xf34073fc
[PGT 421]= 0xf35073fc
[PGT 422]= 0xf36073fc
[PGT 423]= 0xf37073fc
[PGT 424]= 0xf38073fc
[PGT 425]= 0xf39073fc
[PGT 426]= 0xf3a073fc
[PGT 427]= 0xf3b073fc
[PGT 428]= 0xf3c073fc
[PGT 429]= 0xf3d073fc
[PGT 430]= 0xf3e073fc
[PGT 431]= 0xf3f073fc
[PGT 432]= 0xfc
[PGT 433]= 0xf1007300
[PGT 434]= 0xf11073fc
[PGT 435]= 0xf12073fc
[PGT 436]= 0xf13073fc
[PGT 437]= 0xf14073fc
[PGT 438]= 0xf15073fc
[PGT 439]= 0xf16073fc

Any help is greatly appreciated.
Thanks,
Allison
