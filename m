Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbSKBWmK>; Sat, 2 Nov 2002 17:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSKBWmK>; Sat, 2 Nov 2002 17:42:10 -0500
Received: from [212.45.9.156] ([212.45.9.156]:62337 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S261475AbSKBWmI>;
	Sat, 2 Nov 2002 17:42:08 -0500
Message-ID: <3DC455EB.8010803@yahoo.com>
Date: Sun, 03 Nov 2002 01:47:07 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: ru, en
MIME-Version: 1.0
To: "Jos Hulzink" <josh@stack.nl>
CC: linux-kernel@vger.kernel.org,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Larger IO bitmap?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jos Hulzink wrote:
> Increasing the IO bitmap size has huge effects on your Task State Segment 
> size. It sure is possible to increase that size, but be aware that this 
> means you are using megabytes for your TSS's only !
As far as I can read the code
(not too far actually, so correct
me please), we have a per-process
IO bitmap copy, which gets copied
into a per-cpu TSS upon a task switch.
That means that you are right about the
overhead, but at the same time I see
nothing that keeps us from a dynamic
memory allocation for the per-process
copy, as soon as an ioperm() is called.
Is this possible?

> Running iopl(3) isn't that bad, as long as your code knows what it is 
> doing... 
> Ioperm is only needed for virtual 8086 mode (aka DOS emulation mode) 
> With this in mind, dosemu is the only reason why the bitmap should be 
> extended.
Well, at least I think that the VESA
driver of X also uses v86 for the video
bios invocations. It doesn't sucks as badly
as dosemu does probably because even using
vm86(), they still can keep IOPL==3, dosemu
can't. So I think that would still be an
improvement, probably not so noticeable as
it could be for dosemu, but still.

> In my humble opinion, dosemu is not important enough to make TSS's huge 
> bloated things by default.
What if we treat dosemu not as a single
program, but as all that progs that can
work under it and require VESA?:)

> Well... it might be an option in the kernel on x86 systems: [ ] bloat 
> kernel 
> memory usage with huge TSS's, but I really thing this should not be the 
> default way to go.
By any means I am not going to pollute the
memory by a useless per-process IO bitmap
copies. As we have a per-cpu TSS (thanks for
the hint, Denis), we'd have bloat only on a
per-process copies, but I wonder if it is
possible to avoid them except for the processes
that require it?

I wouldn't ask so much and just try the things
out, but for the one thing: what must be done,
besides increasing the IO_BITMAP_SIZE const of a
processor.h, in order to get the larger IO bitmap
right now? As I want to experement a bit, I
need to get it large at first, no matter how much
memory will it eat. But how can I do even that?

