Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311801AbSCNVcS>; Thu, 14 Mar 2002 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311799AbSCNVcC>; Thu, 14 Mar 2002 16:32:02 -0500
Received: from [206.40.202.198] ([206.40.202.198]:5530 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S311798AbSCNVbL>; Thu, 14 Mar 2002 16:31:11 -0500
Date: Thu, 14 Mar 2002 13:26:37 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
cc: <root@chaos.analogic.com>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <3C9121EB.11632.26F0805@localhost>
Message-ID: <Pine.LNX.4.33.0203141322590.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Pedro M. Rodrigues wrote:

> Date: Thu, 14 Mar 2002 22:19:23 +0100
> From: Pedro M. Rodrigues <pmanuel@myrealbox.com>
> To: John Heil <kerndev@sc-software.com>, root@chaos.analogic.com
> Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
>      Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
> Subject: Re: IO delay, port 0x80, and BIOS POST codes
>
>
>    This piece of code is taken from an old Minix source code tree, the file being
> boothead.s . Notice the port 0xED usage and the comment.
>
>
> ! Enable (ah = 0xDF) or disable (ah = 0xDD) the A20 address line.
> gate_A20:
>         call    kb_wait
>         movb    al, #0xD1       ! Tell keyboard that a command is coming
>         outb    0x64
>         call    kb_wait
>         movb    al, ah          ! Enable or disable code
>         outb    0x60
>         call    kb_wait
>
>
>         mov     ax, #25         ! 25 microsec delay for slow keyboard chip
> 0:      out     0xED            ! Write to an unused port (1us)
>         dec     ax
>         jne     0b
>
>         ret
> kb_wait:
>         inb     0x64
>         testb   al, #0x02       ! Keyboard input buffer full?
>         jnz     kb_wait         ! If so, wait
>         ret
>
>
>
> /Pedro
>
> On 14 Mar 2002 at 16:03, Richard B. Johnson wrote:
>
> >
> >
> > Well I can see why he's an EX-Phoenix BIOS developer. A port at 0xed
> > does not exist on any standard or known non-standard Intel/PC/AT
> > compatible.
> >
> > Remember DOS debug?
> >
> > C:\>debug
> >
> > -i ed
> > FF
> > -o ed aa
> > -i ed
> > FF
> > -o ed 55
> > -i ed
> > FF
> > -q
> >
> >
> > This is not a DOS emulation. This is a real-mode boot where any ports
> > will be visible. If you used it with success, it means that you didn't
> > need the I/O delay of writing to a real port. Instead you got the few
> > hundred nanoseconds of delay you get by writing to nowhere.
> >
> > Cheers,
> > Dick Johnson
>
>

We did not want the I/O delay based on the port itself.
We specifically wanted an unused port, and avoid the 0x80 conflict.

Perhaps this should be a kernel hacking/debug option, due to the
difference in environments and needs.


Johnh

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

