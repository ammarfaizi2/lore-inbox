Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSFCHm1>; Mon, 3 Jun 2002 03:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317301AbSFCHm0>; Mon, 3 Jun 2002 03:42:26 -0400
Received: from avplin2.lanet.lv ([195.13.129.96]:11718 "EHLO avplin2.lanet.lv")
	by vger.kernel.org with ESMTP id <S317300AbSFCHmZ>;
	Mon, 3 Jun 2002 03:42:25 -0400
Date: Mon, 3 Jun 2002 10:41:47 +0300 (WET)
From: Andris Pavenis <pavenis@lanet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steve Kieu <haiquy@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre9-ac3 still OOPS when exiting X with i810 chipset
In-Reply-To: <1023029543.23874.28.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.A41.4.05.10206031028590.27940-100000@ieva06>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jun 2002, Alan Cox wrote:

> On Sun, 2002-06-02 at 01:34, Steve Kieu wrote: 
> > May be I should upgrade to XFree86-4.2.0 but as far as
> > I know the dri module in the standard kernel is too
> > old for 4.2.0 to enable dri....
> 
> The -ac kernel has XFree86 4.2.0 DRI with the required Radeon fixes
> added on top and some locking fixes

Normally used 24bpp mode (so no DRI and all worked Ok). Tried 16bpp
mode and got various weird behaviour:
	
1) similar kernel OOPS in one case (output of ksymoops included)
2) X11 crashes when switching from X11 to console
3) Also X11 crash at startup without oopses

I got 2 and 3 when starting KDE-3.0.1. After attempting 
'xinit /opt/gnome/bin/gnome-session' I got OOPS (perhaps when
quitting X11 as was no more able to start X11 without rebooting
(Error message '(EE) GARTInit: AGPIOC_INFO failed (invalid argument)')

Had to debug some (2) style X11 crashes on i810 chipset some months
ago (I applied related one line fix when building X11, it is in current
CVS version of XFree86). Perhaps again some debugging needed ...  
 
Andris


ksymoops 2.4.1 on i686 2.4.19-pre9-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre9-ac3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says e0903090, /lib/modules/2.4.19-pre9-ac3/kernel/fs/lockd/lockd.o says e0902410.  Ignoring /lib/modules/2.4.19-pre9-ac3/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says e08f5e44, /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o says e08f5b24.  Ignoring /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says e08f5e48, /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o says e08f5b28.  Ignoring /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says e08f5e4c, /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o says e08f5b2c.  Ignoring /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says e08f5e40, /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o says e08f5b20.  Ignoring /lib/modules/2.4.19-pre9-ac3/kernel/net/sunrpc/sunrpc.o entry
cpu: 0, clocks: 1007100, slice: 503550
8139too Fast Ethernet driver 0.9.24
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
Unable to handle kernel paging request at virtual address 0100001b
c012e8a1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012e8a1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: 01000000   ebx: c1419aa0   ecx: c1419aa0   edx: 00000000
esi: d42f9000   edi: c16b1800   ebp: d6d144a0   esp: dd2c9ee0
ds: 0018   es: 0018   ss: 0018
Process X (pid: 626, stackpage=dd2c9000)
Stack: c1419aa0 c0219618 c1419aa0 df811740 df782800 c02196cd c16b1800 d42f9000 
       0000000e c16b1800 dd2c9f20 d5f89120 c0219c25 c16b1800 bffff5f0 00000040 
       00000002 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace: [<c0219618>] [<c02196cd>] [<c0219c25>] [<c0214f2d>] [<c01081b8>] 
   [<c014ca13>] [<c0108ff3>] 
Code: 0f b6 50 1b 8b 1c 95 c4 05 39 c0 89 c2 69 d2 01 00 37 9e 8b 

>>EIP; c012e8a1 <unlock_page+1/60>   <=====
Trace; c0219618 <i810_free_page+48/60>
Trace; c02196cd <i810_dma_cleanup+9d/d0>
Trace; c0219c25 <i810_dma_init+65/a0>
Trace; c0214f2d <i810_ioctl+cd/130>
Trace; c01081b8 <restore_sigcontext+128/140>
Trace; c014ca13 <sys_ioctl+c3/240>
Trace; c0108ff3 <system_call+33/38>
Code;  c012e8a1 <unlock_page+1/60>
00000000 <_EIP>:
Code;  c012e8a1 <unlock_page+1/60>   <=====
   0:   0f b6 50 1b               movzbl 0x1b(%eax),%edx   <=====
Code;  c012e8a5 <unlock_page+5/60>
   4:   8b 1c 95 c4 05 39 c0      mov    0xc03905c4(,%edx,4),%ebx
Code;  c012e8ac <unlock_page+c/60>
   b:   89 c2                     mov    %eax,%edx
Code;  c012e8ae <unlock_page+e/60>
   d:   69 d2 01 00 37 9e         imul   $0x9e370001,%edx,%edx
Code;  c012e8b4 <unlock_page+14/60>
  13:   8b 00                     mov    (%eax),%eax


6 warnings issued.  Results may not be reliable.



