Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317518AbSFKTJG>; Tue, 11 Jun 2002 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317519AbSFKTJF>; Tue, 11 Jun 2002 15:09:05 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:10113 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317518AbSFKTJD>; Tue, 11 Jun 2002 15:09:03 -0400
Message-ID: <3D06495A.6030406@linuxhq.com>
Date: Tue, 11 Jun 2002 15:02:50 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 87
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D05AACD.2080504@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Sun Jun  9 15:31:56 CEST 2002 ide-clean-87
> 
> - Sync with 2.5.21
> 
> - Don't call put_device inside idedisk_cleanup(). This is apparently 
> triggering
>   some bug inside the handling of device trees. Or we don't register the 
> device
>   properly within the tree. Check this later.
> 
> - Further work on the channel register file access locking.  Push the 
> locking
>   out from __ide_end_request to ide_end_request.  Rename those functions to
>   respective __ata_end_request() and ata_end_request().
> 
> - Move ide_wait_status to device.c rename it to ata_status_poll().
> 
> - Further work on locking scope issues.
> 
> - devfs showed us once again that it changed the policy from agnostic 
> numbers
>   to unpleasant string names. What a piece of crap!

FYI, this latest cleanup fixes the oops I reported earlier...
not that anyone cared :).

flushing ide devices: hda <1> Unable to handle kernel NULL pointer at 
address 00000004
*pde = 000000
Oops: 0002
CPU: 0
EIP: 0010:[<c01a692c>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c03077d0 ebx: c03077b8 ecx: 00000000 edx: 00000000
esi: c258e000 edi: c029ef40 ebp: c030766c esp: c258fe40
ds: 0018 es: 0018 ss: 0018
Stack: c030766c c03077b8 c0307540 00000001 c01a6d24 c03077b8 c0295788 
c030766c
        c01eaf9e c03077b8 c0307540 c0307540 c01e271f c030766c c0307670 
c029e9cc
        00000000 00000003 bffffcd8 c0122fdd c029e9cc 00000003 00000000 
4321fedc
Call Trace: [<c01a6d24>] [<c01eaf9d>] [<c01e271f>] [<c0122fdd>] [<c0123576>]
             [<c011331e>] [<c0121413>] [<c01217fe>] [<c0122438>] 
[<c01512e0>] [<c013e01a>]
             [<c013c373>] [<c013c422>] [<c010740f>]
Code: 89 4a 04 89 11 89 40 04 89 43 18 ff 4e 10 8b 46 08 83 e0 08

  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/

