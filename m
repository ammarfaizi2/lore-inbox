Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbSIZRLX>; Thu, 26 Sep 2002 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSIZRLX>; Thu, 26 Sep 2002 13:11:23 -0400
Received: from www.wotug.org ([194.106.52.201]:51261 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S261417AbSIZRLW>; Thu, 26 Sep 2002 13:11:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
Date: Thu, 26 Sep 2002 18:16:27 +0100
User-Agent: KMail/1.4.2
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
References: <Pine.LNX.4.44.0209252155210.18747-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0209252155210.18747-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209261816.27194.ruthc@sharra.ivimey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2002 20:56, Ingo Molnar wrote:
> ------------[ cut here ]------------
> kernel BUG at time.c:99!
> invalid operand: 0000
> CPU:    1
> EIP:    0060:[<c011bd14>]    Not tainted
> EFLAGS: 00010246
> EIP is at sys_gettimeofday+0x84/0x90
> eax: 0000004e   ebx: cef9e000   ecx: 00000000   edx: 00000068
> esi: 00000000   edi: 00000000   ebp: bffffad8   esp: cef9ffa0
> ds: 0068   es: 0068   ss: 0068
> Process gettimeofday (pid: 549, threadinfo=cef9e000 task=cf84d860)
> Stack: 4001695c bffff414 40156154 00000004 c0112a40 cef9e000 400168e4

Something that's been bugging me of late: the Oops output is quite expensive 
in lines on the terminal, which means if you get a couple of oops before the 
kernel stops, you're unlikely to see the one that fired first.

To help with this, would it be good to use the following form for the initial 
part:

 kernel BUG at time.c:99, invalid operand: 0000
 CPU 1: EIP:    0060:[<c011bd14>]    Not tainted
 EIP is at sys_gettimeofday+0x84/0x90
 eax: 0000004e   ebx: cef9e000   ecx: 00000000   edx: 00000068
 esi: 00000000   edi: 00000000   ebp: bffffad8   esp: cef9ffa0
 ds: 0068   es: 0068   ss: 0068   eflags: 00010246 [textflags]

Where [textflags] is some arch-specific representation of the flags word.

Also, in the same vein I would like to be able to say (as a kernel option):

if kernel-oops {
 copy console output to [printer|serial] port
}

[printer output == ascii only, of course]

Regards,

Ruth
