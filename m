Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318700AbSHAKmQ>; Thu, 1 Aug 2002 06:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318701AbSHAKmQ>; Thu, 1 Aug 2002 06:42:16 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10501 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318700AbSHAKmP>; Thu, 1 Aug 2002 06:42:15 -0400
Message-ID: <3D49101C.4010608@evision.ag>
Date: Thu, 01 Aug 2002 12:40:28 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: eject causes null null deref in wait_for_completion
References: <Pine.LNX.4.44.0208010825080.2454-100000@linux-box.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> IIRC eject with a CD does this, Looks odd.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000011
> c011832a
> *pde = 0662e001
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c011832a>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: 00000000   ebx: 00000001   ecx: 00000000   edx: c5d7a000
> esi: c5d7bf28   edi: c5d7bf2c   ebp: c5d7befc   esp: c5d7beb0
> ds: 0018   es: 0018   ss: 0018
> Stack: 00000000 ce14e660 c0117f30 00000000 00000000 c026ab54 c047832c cf5e5e04
>        00000001 ce14e660 c0117f30 c5d7bf34 c5d7bf34 c5d7a000 c5d7bf28 c0243839
>        00000000 c0478340 cf5e5e04 c5d7bf28 c024639f c0478340 00000000 00000001
> Call Trace: [<c0117f30>] [<c026ab54>] [<c0117f30>] [<c0243839>] [<c024639f>]
>    [<c011aa5f>] [<c0246433>] [<c0155a7a>] [<c015e687>] [<c014c5e6>] [<c010778f>]
> Code: ff 43 10 81 7f 04 ad 4e ad de 74 1a 68 24 83 11 c0 68 d3 43
> 
> 
>>>EIP; c011832a <wait_for_completion+11a/1d0>   <=====
>>
> Trace; c0117f30 <default_wake_function+0/40>
> Trace; c026ab54 <do_ide_request+364/420>
> Trace; c0117f30 <default_wake_function+0/40>
> Trace; c0243839 <generic_unplug_device+119/170>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is indeed puzzling me. In esp. Since it started to
appear at a time where there where no changes in code flow
in this area. Well I have to lookup the bd-claim
mechanisms. Perhaps doing what ide_spin_wait() does
by using only ll_rw_blk.c functions will actually help here.

