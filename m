Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTAPADQ>; Wed, 15 Jan 2003 19:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTAPADQ>; Wed, 15 Jan 2003 19:03:16 -0500
Received: from adsl-109-100.gigavia.com.ar ([200.26.109.100]:49852 "EHLO
	morgoth.srv.sis.cooperativaobrera.com.ar") by vger.kernel.org
	with ESMTP id <S264867AbTAPACe>; Wed, 15 Jan 2003 19:02:34 -0500
Message-ID: <3E25F898.2010704@bblanca.com.ar>
Date: Wed, 15 Jan 2003 21:11:04 -0300
From: Gabriel Gomiz <gomita@bblanca.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NCR 7452/3 POS - Retail CMOS NVRAM Driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I say Hi to the greatests hackers!

I'm trying to build a kernel module driver to be able to access the CMOS 
NVRAM that the NCR 7452/3 POS (Point of Sale) has built-in on the 
motherboard. All the information that I could get from the manufacturers 
is that the memory works at I/O address 0x100. But later I found out 
that you can configure the I/O address using switches on the motherboard 
to one of the following ranges of addresses:
0x100-0x10F DEFAULT
0x120-0x12F
0x140-0x14F
0x160-0x16F

The memory chips that NCR uses are:
1) NEC D43256BGU - NCR POS Model 7452-1011
    The chip is 256KB, but NCR says they use only 128KB
2) NEC D431000AGW - NCR POS Model 7453-1011
    The chip is 1MB, but NCR says they use only 128KB

I've made a simple kernel module (based on drivers/char/nvram.c) to see 
if I can _test_ the memory (to see if it is there and read/write some 
bytes from 0x100 I/O Port) and I'm getting some confusing results.
In the end the module does the following:

#ifndef NVRAM_PORT
#define NVRAM_PORT(x)	(0x100 + (x))
#endif

#define NVRAM_READ(addr) ({ \
outb_p((addr),NVRAM_PORT(0)); \
inb_p(NVRAM_PORT(1)); \
})

#define NVRAM_WRITE(val, addr) ({ \
outb_p((addr),NVRAM_PORT(0)); \
outb_p((val),NVRAM_PORT(1)); \
})

The questions are:

* Has anyone worked with this kind of NVRAM before?
* Do you know how can the memory be programmed? Maybe you can enlight me 
with something... :)

I have some more details of the module and the tests I've been doing to 
send if someone is interested.

OBS: If this message is considered highly off-topic, please can you 
point me in the right direction to ask this questions? (Maybe linux-mtd???)

Many thanks in advance

-- 
    .^.    Gabriel Gomiz - Red Hat Certified Engineer (RHCE)
    /V\
   // \\
  /(   )\
   ^^-^^   s/Window[$s]/LINUX!!/g or die;

