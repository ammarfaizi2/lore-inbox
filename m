Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRBYBEQ>; Sat, 24 Feb 2001 20:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRBYBD4>; Sat, 24 Feb 2001 20:03:56 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:3844 "HELO sh0n.net")
	by vger.kernel.org with SMTP id <S129764AbRBYBDs>;
	Sat, 24 Feb 2001 20:03:48 -0500
Message-ID: <3A9859EF.F01831FA@sh0n.net>
Date: Sat, 24 Feb 2001 20:03:43 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: ksysoops debug info
In-Reply-To: <Pine.LNX.4.21.0102241357220.3684-100000@freak.distro.conectiva> <3A98365A.451C4473@sh0n.net>
Content-Type: multipart/mixed;
 boundary="------------D73E77F4E5A06BFB72214D43"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D73E77F4E5A06BFB72214D43
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Ok, I copied the part from kern.log and pasted it into a separate file then ran
ksysoops and it appeared to have worked.

Any more info you need?

Shawn.

Shawn Starr wrote:

> Doing so..., Im not sure hot to use ksymoops or where to get that program.
> I just usually use the sysq and dump but its ugly ;-)
>
> Shawn.
>
> Marcelo Tosatti wrote:
>
> > On Fri, 23 Feb 2001, Shawn Starr wrote:
> >
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> > > Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> > >
> > > didnt, work, still causing this..
> >
> > Ok, could you please add a line with "BUG();" after the
> > printk("__alloc_pages: %d-order allocation failed", ..) in mm/page_alloc.c
> > function __alloc_pages() ?
> >
> > This will make you get an oops when an allocation fails and if you decode
> > it (with ksymoops) we can have a pretty useful backtrace to have more clue
> > of what's failing.
> >
> > TIA
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------D73E77F4E5A06BFB72214D43
Content-Type: text/plain; charset=iso-8859-15;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops"

ksymoops 2.3.7 on i586 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map (specified)

Feb 24 19:57:32 coredump kernel: kernel BUG at page_alloc.c:507!
Feb 24 19:57:32 coredump kernel: invalid operand: 0000
Feb 24 19:57:32 coredump kernel: CPU:    0
Feb 24 19:57:32 coredump kernel: EIP:    0010:[__alloc_pages+761/776]
Feb 24 19:57:32 coredump kernel: EFLAGS: 00013282
Feb 24 19:57:32 coredump kernel: eax: 00000020   ebx: 00000000   ecx: c1ba8000   edx: c025abe8
Feb 24 19:57:32 coredump kernel: esi: c025c000   edi: 00000003   ebp: c1d06000   esp: c1d07d38
Feb 24 19:57:32 coredump kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 19:57:32 coredump kernel: Process cdda2wav (pid: 386, stackpage=c1d07000)
Feb 24 19:57:32 coredump kernel: Stack: c0219a05 c0219b93 000001fb 00000003 00008000 00008000 00000000 00000007
Feb 24 19:57:32 coredump kernel:        00000008 00000000 c025bff4 c0127fe4 c01b5079 c1d07de4 00000000 00000001
Feb 24 19:57:32 coredump kernel:        c1d07de0 00008000 00000007 c01b5142 00008000 00000000 00000001 00000000
Feb 24 19:57:32 coredump kernel: Call Trace: [__get_free_pages+20/36] [sg_low_malloc+305/408] [sg_malloc+98/280] [sg_build_indi+385/440] [sg_build_reserve+37/68] [sg_ioctl+1582/2588] [__get_free_pages+20/36]
Feb 24 19:57:32 coredump kernel: Code: 0f 0b 83 c4 0c 31 c0 5b 5e 5f 5d 83 c4 10 c3 83 fa 09 77 13
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   31 c0                     xor    %eax,%eax
Code;  00000007 Before first symbol
   7:   5b                        pop    %ebx
Code;  00000008 Before first symbol
   8:   5e                        pop    %esi
Code;  00000009 Before first symbol
   9:   5f                        pop    %edi
Code;  0000000a Before first symbol
   a:   5d                        pop    %ebp
Code;  0000000b Before first symbol
   b:   83 c4 10                  add    $0x10,%esp
Code;  0000000e Before first symbol
   e:   c3                        ret    
Code;  0000000f Before first symbol
   f:   83 fa 09                  cmp    $0x9,%edx
Code;  00000012 Before first symbol
  12:   77 13                     ja     27 <_EIP+0x27> 00000027 Before first symbol


--------------D73E77F4E5A06BFB72214D43--

