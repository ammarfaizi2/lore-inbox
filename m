Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWJPSAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWJPSAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJPSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:00:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:29620 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161049AbWJPSAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:00:02 -0400
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <4533C6A1.40203@oracle.com>
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>
	 <4533C6A1.40203@oracle.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 10:59:46 -0700
Message-Id: <1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 10:51 -0700, Zach Brown wrote:
> > Can you take a look ? Failures look nasty ..
> 
> Yeah, it's right at the tippy top of my list.
> 
> - z

Here is the easiest case to fix first :)
simple DIO wrote more than asked for :(

elm3b29:~ # /root/fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
jnk
mapped writes DISABLED
truncating to largest ever: 0x32740
truncating to largest ever: 0x39212
truncating to largest ever: 0x3bae9
short write: 0x17000 bytes instead of 0x14000   <<<<<<
LOG DUMP (47 total operations):
1(1 mod 256): WRITE     0x1f000 thru 0x35fff    (0x17000 bytes) HOLE
2(2 mod 256): WRITE     0x10000 thru 0x2dfff    (0x1e000 bytes)
3(3 mod 256): READ      0xe800 thru 0xefff      (0x800 bytes)
4(4 mod 256): READ      0x800 thru 0x137ff      (0x13000 bytes)
5(5 mod 256): READ      0x2e800 thru 0x357ff    (0x7000 bytes)
6(6 mod 256): READ      0x23800 thru 0x357ff    (0x12000 bytes)
7(7 mod 256): READ      0x2f800 thru 0x357ff    (0x6000 bytes)
8(8 mod 256): READ      0x7000 thru 0xbfff      (0x5000 bytes)
9(9 mod 256): TRUNCATE DOWN     from 0x36000 to 0x32740
10(10 mod 256): READ    0xa800 thru 0x287ff     (0x1e000 bytes)
11(11 mod 256): WRITE   0x29000 thru 0x34fff    (0xc000 bytes) EXTEND
12(12 mod 256): TRUNCATE DOWN   from 0x35000 to 0x1977a
13(13 mod 256): READ    0xa800 thru 0xe7ff      (0x4000 bytes)
14(14 mod 256): TRUNCATE UP     from 0x1977a to 0x39212
15(15 mod 256): WRITE   0x28000 thru 0x3cfff    (0x15000 bytes) EXTEND
16(16 mod 256): READ    0xb000 thru 0xcfff      (0x2000 bytes)
17(17 mod 256): READ    0x38800 thru 0x3c7ff    (0x4000 bytes)
18(18 mod 256): TRUNCATE DOWN   from 0x3d000 to 0x2a2b5
19(19 mod 256): READ    0xf800 thru 0x167ff     (0x7000 bytes)
20(20 mod 256): READ    0x15000 thru 0x19fff    (0x5000 bytes)
21(21 mod 256): TRUNCATE DOWN   from 0x2a2b5 to 0xa87
22(22 mod 256): TRUNCATE UP     from 0xa87 to 0x20108
23(23 mod 256): READ    0x4800 thru 0x15fff     (0x11800 bytes)
24(24 mod 256): READ    0x7000 thru 0x13fff     (0xd000 bytes)
25(25 mod 256): READ    0x0 thru 0x137ff        (0x13800 bytes)
26(26 mod 256): SKIPPED (no operation)
27(27 mod 256): WRITE   0x15000 thru 0x23fff    (0xf000 bytes) EXTEND
28(28 mod 256): WRITE   0x23000 thru 0x38fff    (0x16000 bytes) EXTEND
29(29 mod 256): WRITE   0x32000 thru 0x32fff    (0x1000 bytes)
30(30 mod 256): WRITE   0x10000 thru 0x16fff    (0x7000 bytes)
31(31 mod 256): TRUNCATE DOWN   from 0x39000 to 0x2fae1
32(32 mod 256): READ    0x13000 thru 0x2efff    (0x1c000 bytes)
33(33 mod 256): WRITE   0x3e000 thru 0x3efff    (0x1000 bytes) HOLE
34(34 mod 256): TRUNCATE DOWN   from 0x3f000 to 0x18d8b
35(35 mod 256): WRITE   0x7000 thru 0x10fff     (0xa000 bytes)
36(36 mod 256): READ    0x9000 thru 0x187ff     (0xf800 bytes)
37(37 mod 256): TRUNCATE DOWN   from 0x18d8b to 0x12111
38(38 mod 256): TRUNCATE UP     from 0x12111 to 0x2e931
39(39 mod 256): WRITE   0x38000 thru 0x3efff    (0x7000 bytes) HOLE
40(40 mod 256): WRITE   0x2c000 thru 0x3dfff    (0x12000 bytes)
41(41 mod 256): SKIPPED (no operation)
42(42 mod 256): TRUNCATE DOWN   from 0x3f000 to 0x15e10
43(43 mod 256): TRUNCATE UP     from 0x15e10 to 0x3bae9
44(44 mod 256): TRUNCATE DOWN   from 0x3bae9 to 0x3b4a3
45(45 mod 256): TRUNCATE DOWN   from 0x3b4a3 to 0x27d16
46(46 mod 256): WRITE   0x27000 thru 0x2ffff    (0x9000 bytes) EXTEND
47(47 mod 256): WRITE   0x10000 thru 0x23fff    (0x14000 bytes)
Correct content saved for comparison
(maybe hexdump "jnk" vs "jnk.fsxgood")
Segmentation fault


