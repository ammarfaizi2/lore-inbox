Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTJPIVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbTJPIVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:21:34 -0400
Received: from ogi.bezeqint.net ([192.115.106.14]:13793 "EHLO ogi.bezeqint.net")
	by vger.kernel.org with ESMTP id S262767AbTJPIVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:21:32 -0400
Message-ID: <3F8E552B.3010507@users.sf.net>
Date: Thu, 16 Oct 2003 10:22:03 +0200
From: Eli Billauer <eli_billauer@users.sf.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] frandom - fast random generator module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

Frandom is the faster version of the well-known /dev/urandom random 
number generator. Not instead of, but rather as a supplement, when 
pseudorandom data is needed at high rate. Few tests so far show that 
frandom is 10-50 times faster than urandom.

The project's home page: http://frandom.sourceforge.net.

The module works on 2.2, 2.4 and 2.6 kernels. A few straightforward 
#ifdef's handle compatability (easy to remove to match common coding style).

Purpose
=======

(1) Frandom is a handy source of bulk random data.
(2) It is *not* intended for encryption and security-related applications.
(3) frandom is intended for (scientific) simulations, wiping the disk, 
stress tests on algorithms and so on.
(4) It is more of an /dev/zero than /dev/random

Quality of random numbers
=========================

(1) The module has been tested for random number quality with the 
"diehard" set of tests, and passed them all. This indicates that the 
bytes are random enough for most scientific purposes.
(2) Additional tests results are welcomed.
(3) The core of frandom is based upon RC4. frandom is exactly RC4, minus 
the XOR operation with the data. So if frandom doesn't generate good 
random numbers, I would wonder why RC4 is considered safe.
(4) The random generator is seeded with 256 bytes of the kernel's 
get_random_bytes() for every file opened on /dev/frandom. This is 
equivalent to a 2048-bit random key on RC4.
(5) I don't see frandom fit for crypto purposes, mainly because the 
module was naively written. I won't fall off my chair if it turns out to 
be crypto-safe, but I wouldn't trust it either. Not yet, anyhow.
(6) Those who read the source and feel that such a simple algorithm 
can't create good random: That's exactly the beauty of RC4: It's simple 
and it works.

frandom and the linux kernel tree
=================================

(1) Occasionally, people complain that /dev/urandom is too slow, wishing 
for something faster.
(2) Other argue that a random generator can be written in user space.
(3) I agree with both. And I use /dev/zero a lot. I know how to write a 
zero-generating application in user space.
(4) The module is small: 6kB of source code as a standalone module, and 
2.3 kB of kernel memory.

Test results and comments will be appreciated.

    Eli


