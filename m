Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRKHRRo>; Thu, 8 Nov 2001 12:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276707AbRKHRRf>; Thu, 8 Nov 2001 12:17:35 -0500
Received: from cayuga.grammatech.com ([209.4.89.66]:27405 "EHLO grammatech.com")
	by vger.kernel.org with ESMTP id <S275990AbRKHRRS>;
	Thu, 8 Nov 2001 12:17:18 -0500
Message-ID: <3BEABE11.AFF00CF0@grammatech.com>
Date: Thu, 08 Nov 2001 12:17:05 -0500
From: David Chandler <chandler@grammatech.com>
Organization: GrammaTech, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <Pine.LNX.3.95.1011108103553.22138A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick,

You're right that the one-liner below may not necessarily produce a seg
fault, but shouldn't it terminate normally if it doesn't?  After all,
the program just *reads*.  Hanging does not seem to be an option!

BTW, your example program produces very similar output for the 2.4 and
2.2 kernels to which I have access.  I apologize for any confusion my
original report created -- 0xc0000000 was chosen because of its relation
to the start of the stack frame, and indeed it has nothing
to do with the size of virtual address space.


David Chandler


"Richard B. Johnson" wrote:
> 
> > > On Wed, Nov 07, 2001 at 06:23:13PM -0500, David Chandler wrote:
> > > > The following one-line C program, when compiled by gcc 2.96 without
> > > > optimization, should produce a SIGSEGV segmentation fault (on a machine
> > > > with 3 or less gigabytes of virtual memory, at least):
> > > >
> > > >         int main() { int k  = *(int *)0xc0000000; }
> > > >
> 
> This may not necessarily produce a seg-fault! If this virtual
> address is mapped within the current process (.bss .stack, etc.),
> It's perfectly all right to write to it although you probably
> broke malloc() by doing it. The actual value of the number in
> the pointer depends upon PAGE_OFFSET and other kernel variables.
> If you change the kernel, this number may change. It has nothing
> to do with the size of virtual address space, really.


> 
> All this stuff you "own". You can write to most all of it because
> the kernel has allocated it for you. Whether or not 'const' is
> really read-only is "implementation dependent".
> 
> In your case, it looks as though you scribbled over the top of
> your user stack, in some harmless place.


> Cheers,
> Dick Johnson


-- 

_____
David L. Chandler.                              GrammaTech, Inc.
mailto:chandler@grammatech.com         http://www.grammatech.com
