Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313482AbSDHIZ6>; Mon, 8 Apr 2002 04:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSDHIZ6>; Mon, 8 Apr 2002 04:25:58 -0400
Received: from gw.wmich.edu ([141.218.1.100]:29082 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S313482AbSDHIZ4>;
	Mon, 8 Apr 2002 04:25:56 -0400
Subject: Re: Make swsusp actually work
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz>
Content-Type: multipart/mixed; boundary="=-DrKfpkXPLxlxgPYOig/T"
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 04:25:43 -0400
Message-Id: <1018254348.571.129.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DrKfpkXPLxlxgPYOig/T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It tries killing init on resume for me and panics.  the actual suspend
worked though (apparently).  I attached the ksymoops output to the
panic.

On Sun, 2002-04-07 at 19:37, Pavel Machek wrote:
> Hi!
> 
> There were two bugs, and linux/mm.h one took me *very* long to
> find... Well, those bits used for zone should have been marked. Plus I
> hack ide_..._suspend code not to panic, and it now seems to
> work. [Sorry, 2pm, have to get some sleep.]
> 


--=-DrKfpkXPLxlxgPYOig/T
Content-Disposition: attachment; filename=ksymoops.out
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ksymoops.out; charset=ANSI_X3.4-1968

ksymoops 2.4.5 on i686 2.4.19-pre5-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5-ac3/ (default)
     -m /boot/System.map-2.4.19-pre5-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
00000000
*pde =3D 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<00000000>] Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c0292e58   ebx: c013f000     ecx: 00000304       edx: 00000000
esi: cff6a100   edi: 00000000     ebp: 00000000       esp: c1357e98
ds: 0018        es: 00000000   ss: 0018
Process swapper (pid: 1, stackpage=3Dc1357000)
Stack: c0196c88 c0292e58 00000000 cff6a100 00000000 c0142512 cff6a100 00000=
000
    00000008 00000000 00000000 00000002 c0196d2a 00000000 cff6a100 cff6a100
    00000000 c0196f3d 00000000 cff6a100 00000304 00000200 00002480 00000304
Call Trace: [<c0196c88>] [<c0142512>] [<c0196d2a>] [<c0196f3d>] [<c0140358>=
] [<c014604>] [<c011a776>] [<c011a866>] [<c0129c70>] [<c0129d5f>] [<c010500=
0>]
    [<c012a245>] [<c0105070>] [<c0105000>] [<c01071d6>] [<c0105050>]
Code: Bad EIP value


>>EIP; 00000000 Before first symbol

>>eax; c0292e58 <blk_dev+198/8780>
>>ebx; c013f000 <end_buffer_io_sync+0/30>
>>esi; cff6a100 <_end+fcc5b8c/1055ba8c>
>>esp; c1357e98 <_end+10b3924/1055ba8c>

Trace; c0196c88 <generic_make_request+d8/140>
Trace; c0142512 <hash_page_buffers+102/120>
Trace; c0196d2a <submit_bh+3a/60>
Trace; c0196f3d <ll_rw_block+18d/1b0>
Trace; c0140358 <getblk+18/40>
Trace; 0c014604 Before first symbol
Trace; c011a776 <__call_console_drivers+46/60>
Trace; c011a866 <call_console_drivers+66/120>
Trace; c0129c70 <bdev_read+30/70>
Trace; c0129d5f <resume_try_to_read+af/530>
Trace; c0105000 <_stext+0/0>
Trace; c012a245 <software_resume+65/b0>
Trace; c0105070 <init+20/1b0>
Trace; c0105000 <_stext+0/0>
Trace; c01071d6 <kernel_thread+26/30>
Trace; c0105050 <init+0/1b0>

<0>Kernel Panic: Attempted to kill init!

1 warning issued.  Results may not be reliable.

--=-DrKfpkXPLxlxgPYOig/T--

