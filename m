Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSGAQXU>; Mon, 1 Jul 2002 12:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315794AbSGAQXT>; Mon, 1 Jul 2002 12:23:19 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:17081 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S315784AbSGAQXQ>;
	Mon, 1 Jul 2002 12:23:16 -0400
Message-ID: <3D208283.7010106@iram.es>
Date: Mon, 01 Jul 2002 18:25:39 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: willy tarreau <wtarreau@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
References: <200207010858.g618wdT17736@Port.imtp.ilyichevsk.odessa.ua> <20020701130327.38962.qmail@web20506.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

willy tarreau wrote:
> Hello Denis,
> 
> 
>>This code is performance critical.
>>With this in mind,
> 
> 
> Yes and no. In fact, I first wanted to code some
> parts in assembler because GCC is sub-optimal
> on bit-fields calculations. But then, I realized that
> I could save, say 10 cycles, while the trap costs
> about 400 cycles.
> 
> 
>>+static void *modrm_address(struct pt_regs *regs,
>>unsigned char **from, char w, char bit32,
>>w seems to be unused
> 
> 
> Well, you're right, it's not used anymore. It was
> used to check if the instruction applies to a byte
> or a word.
> 
> 
>>Why? i86 can do unaligned accesses:
>>	offset = *(u32*)(*from); *from += 4;
> 
> 
> that's simply because I'm not sure if the kernel
> runs with AC flag on or off. I quickly checked
> that it's OK from userland.

AC is only checked when running at CPL==3, i.e.,
you'll never get an alignment trap in the kernel.

	Gabriel



