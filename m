Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSLLPo0>; Thu, 12 Dec 2002 10:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264806AbSLLPo0>; Thu, 12 Dec 2002 10:44:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51077 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264771AbSLLPoY>; Thu, 12 Dec 2002 10:44:24 -0500
Date: Thu, 12 Dec 2002 10:54:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Stian Jordet <liste@jordet.nu>, Allan Duncan <allan.d@bigpond.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.51
In-Reply-To: <m1isxzuvpi.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.95.1021212104100.30386A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 2002, Eric W. Biederman wrote:

> James Simmons <jsimmons@infradead.org> writes:
> 
> > Unfortunely ATI doesn't like to release info on what needs to be done to
> > initialize without frimware. I really wish this was the case. I did see
> > email back about someone getting a mach64 card working without firmware.
> > They used a bus analysiser to do this. I will see what kind of patches I
> > can dig up.
> 
> Thanks.
> 
> Eric

The XFree people should know about this. Also, all the PCI/AGP
interface video boards, including those on motherboards, have
an internal BIOS that is sucked out of the board and written to
RAM at C0000 -> C8000 anyway. This stuff is visible from Linux
and can be disassembled by copying it to a file, then going to
VM86 mode DOS and disassembling with many kinds of real-mode DOS
tools. Since this is the real-mode BIOS that replaces the INT 0x10
default BIOS, all the function calls are known, and tracing what
registers they touch (and how) becomes a simple "time-sink".
Not hard, but just takes time.

Example of what's visible to Linux (this is an old Number 9 card).

000C0000  55 AA 40 E9 16 16 37 34-30 30 00 00 00 00 00 00   U.@...7400......
000C0010  00 00 00 00 00 00 00 00-10 02 00 00 00 00 49 42   ..............IB
000C0020  4D 20 56 47 41 20 43 6F-6D 70 61 74 69 62 6C 65   M VGA Compatible
000C0030  20 42 49 4F 53 2E 20 00-BB 66 F0 01 9F 01 F0 09    BIOS. ..f......
000C0040  09 FF 00 02 4E 75 6D 62-65 72 20 4E 69 6E 65 20   ....Number Nine 
000C0050  56 69 73 75 61 6C 20 54-65 63 68 6E 6F 6C 6F 67   Visual Technolog
000C0060  79 20 20 20 20 20 20 20-20 20 20 39 46 58 20 4D   y          9FX M
000C0070  6F 74 69 6F 6E 20 37 37-31 20 20 20 20 20 20 20   otion 771       
000C0080  20 20 20 0E 20 4C 65 74-20 69 74 20 62 65 20 36      . Let it be 6
000C0090  38 2E 2E 2E 00 28 63 29-31 39 39 35 20 4E 75 6D   8....(c)1995 Num
000C00A0  62 65 72 20 4E 69 6E 65-20 56 69 73 75 61 6C 20   ber Nine Visual 
000C00B0  54 65 63 68 6E 6F 6C 6F-67 79 20 43 6F 72 70 2E   Technology Corp.
000C00C0  0D 0A 41 6C 6C 20 52 69-67 68 74 73 20 52 65 73   ..All Rights Res
000C00D0  65 72 76 65 64 0D 0A 00-23 39 2D 39 36 38 20 42   erved...#9-968 B
000C00E0  49 4F 53 20 56 65 72 73-69 6F 6E 20 32 2E 34 35   IOS Version 2.45
000C00F0  2E 31 35 0D 0A 00 28 63-29 31 39 39 35 20 53 33   .15...(c)1995 S3


The POST routine starts executing at offset 3. 0xaa55 is the signature,
the 0x40 byte is the number of 512-byte blocks to checksum (32,768 bytes),
and the initialization code follows. It just takes time. Everything you
need to know is in that 32,768 bytes.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


