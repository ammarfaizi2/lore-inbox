Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbRELSbv>; Sat, 12 May 2001 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbRELSbl>; Sat, 12 May 2001 14:31:41 -0400
Received: from ip166-219.fli-ykh.psinet.ne.jp ([210.129.166.219]:40645 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S261308AbRELSb1>;
	Sat, 12 May 2001 14:31:27 -0400
Message-ID: <3AFD817A.AD5B2160@yk.rim.or.jp>
Date: Sun, 13 May 2001 03:31:22 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, May 06, 2001 at 01:51:59PM +0100, Alan Cox wrote:
>
>> > There really needs to be a hardware fix... this doesn't stop some
>> > application having it's owne optimised code from breaking on some
>> > hardware (think games and similation software perhaps).
>>
>> prefetch is virtually addresses. An application would need access to
/dev/mem
>> or similar. So the only folks I think it might actually bite are the
Xserver
>> people.
>
>Prefetch bugs in hardware have biten Linux/68k as early as '94; a GVP
SCSI
>HBA on the Amiga may touch areas beyond the last valid RAM address when

>doing DMA to the last page. Being a burned child from that time
Linux/MIPS
>didn't use the last RAM page just to be on the safe side.
>
>  Ralf

I use Duron 750 MHz and has experienced a strange X11 server error.
(The motherboard is Gigabyte 7IXE4 and uses AMD 751 and 756 chipsets.)

If I follow a certain steps accessing a web page using
netscape, the X11 server crashes reliably.
(The server is for ATI rage 128. Xfree86 3.3.6.)

After recompiling the X11 server with debug flag to C compiler,
I figured that the X11 server crashes in a bitblt copy againt
its backing up store . (I forgot what the proper X11 terminology, but
this is where the image data is saved for quick re-display, etc..
You can build an image in a memory buffer and then simply copy it
onto screen memory, etc..)

I was a little skeptical to think that the X11 server code
has such a bug for SVGA 16bits color server today,
and yet was still wondering if
the code might want to access non-allocated area due
to some optimized accessing pattern or something.

(Long time ago, I had a similar bug on a dedicated bitblt
instruction for a  workstation: the bitblt instruction could
access outside the boundary of malloc-ed  area
since it tries to access as many words as possible if there is a chance
to use
long word access. In doing so, the CPU could
step outside sbrk() limit and VM access error condition was generated.
Since this access violation occured inside the CPU firmware and
not visible to outside, it was very hard to track. Eventually, I figured
out
the problem, and always allocated enough trailing area for bitmap
storage
just in case the CPU tried to access a few word outside the limit.

Now, back to DuronAthlon problem:
I wasn't following this Athlong bug discussion in depth, thinking
it has something to do with VIA chipset alone.

But can the same problem manifest on AMD 751 chipset?
That would explain this mysterious X11 server
crash beatifully :-)

Happy Hacking,
ci



