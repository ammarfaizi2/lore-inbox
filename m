Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUBILaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBILaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:30:25 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:59621 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264917AbUBILaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:30:22 -0500
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.4.25-rc1 -- video1394
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
From: Roland Mas <roland.mas@free.fr>
Date: Mon, 09 Feb 2004 12:30:19 +0100
Message-ID: <873c9kebhw.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi there,

You'll remember Christmas was not that long ago, and the number of
digital camcorders in my possession has grown from nil to one.  And
I've been trying to make the best use of it, with kino as the video
edition/capture/effects/whatever software.

  To the point: I can grab video from it (using the raw1394 system),
but exporting video to it results in an oops.  I've only attached the
ksymoops output from kernel 2.4.25-rc1, but I had similar problems
with 2.4.24.  Of course, when that oops happens, kino crashes with a
segmentation fault.

  Interesting fact: when I export video to the camcorder with a
non-GUI application (dvconnect), I get neither oops nor segfault.
It's just that it doesn't start the recording on the camcorder, so it
isn't very useful: the video appears on the camcorder's screen, but
doesn't go onto tape.

Relevant data (I hope):

- Vanilla 2.4.25-rc1 kernel;
- Debian system (up-to-date sid);
- Sony DRC-TRV33E camcorder;
- lspci shows "00:05.0 FireWire (IEEE 1394): VIA Technologies,
  Inc. IEEE 1394 Host Controller (rev 46)"
- ksymoopsed oops (from kern.log):
,----
| ksymoops 2.4.9 on i686 2.4.25-rc1.  Options used
|      -V (default)
|      -k /proc/ksyms (default)
|      -l /proc/modules (default)
|      -o /lib/modules/2.4.25-rc1/ (default)
|      -m /boot/System.map-2.4.25-rc1 (default)
| 
| Warning: You did not tell me where to find symbol information.  I will
| assume that the log matches the kernel and modules that are running
| right now and I'll use the default options above for symbol resolution.
| If the current kernel and/or modules do not match the log, you can get
| more accurate output by telling me the kernel version and where to find
| map, modules, ksyms etc.  ksymoops -h explains the options.
| 
| Unable to handle kernel NULL pointer dereference at virtual address 00000004
| fcd81136
| *pde = 00000000
| Oops: 0002
| CPU:    0
| EIP:    0010:[<fcd81136>]    Not tainted
| Using defaults from ksymoops -t elf32-i386 -a i386
| EFLAGS: 00210246
| eax: 00000000   ebx: f775eb28   ecx: f775eb78   edx: 00000000
| esi: f775ead4   edi: 80000000   ebp: 00000200   esp: f2c87e80
| ds: 0018   es: 0018   ss: 0018
| Process kino (pid: 1276, stackpage=f2c87000)
| Stack: f775eb28 00000000 00000000 f775eb28 f775ead4 fcd813af f775ead4 00000000
|        c1c3c000 00000000 0000000a 00000400 fcd838bf f2c87eec 00000000 00000030
|        c1d46310 00000000 00000004 80000000 00000000 fcd821c1 f61b1cdc 00000000
| Call Trace:    [<fcd813af>] [<fcd838bf>] [<fcd821c1>] [devfs_open+333/432] [vfs_permission+122/272]
| Code: 89 50 04 89 02 c7 41 04 00 00 00 00 c7 86 a4 00 00 00 00 00
| 
| 
| >>EIP; fcd81136 <[video1394]free_dma_iso_ctx+b6/140>   <=====
| 
| >>ebx; f775eb28 <_end+374711fc/38521754>
| >>ecx; f775eb78 <_end+3747124c/38521754>
| >>esi; f775ead4 <_end+374711a8/38521754>
| >>esp; f2c87e80 <_end+3299a554/38521754>
| 
| Trace; fcd813af <[video1394]alloc_dma_iso_ctx+1ef/5d0>
| Trace; fcd838bf <[video1394].text.end+42a/b13>
| Trace; fcd821c1 <[video1394]video1394_ioctl+2d1/e80>
| 
| Code;  fcd81136 <[video1394]free_dma_iso_ctx+b6/140>
| 00000000 <_EIP>:
| Code;  fcd81136 <[video1394]free_dma_iso_ctx+b6/140>   <=====
|    0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
| Code;  fcd81139 <[video1394]free_dma_iso_ctx+b9/140>
|    3:   89 02                     mov    %eax,(%edx)
| Code;  fcd8113b <[video1394]free_dma_iso_ctx+bb/140>
|    5:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
| Code;  fcd81142 <[video1394]free_dma_iso_ctx+c2/140>
|    c:   c7 86 a4 00 00 00 00      movl   $0x0,0xa4(%esi)
| Code;  fcd81149 <[video1394]free_dma_iso_ctx+c9/140>
|   13:   00 00 00 
| 
| 
| 1 warning issued.  Results may not be reliable.
`----

  The "interesting fact" I mentioned above tells me there might be a
bug in kino, but I'm not sure it should trigger the kernel oops.
Especially since the oops sort of locks the video1394 device so it
can't be used (including by dvconnect) until I reboot the box.

Thanks,

Roland.
-- 
Roland Mas

Death *was* hereditary.  You got it from your ancestors.
  -- in Hogfather (Terry Pratchett)
