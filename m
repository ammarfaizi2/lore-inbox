Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282998AbRLMByo>; Wed, 12 Dec 2001 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282999AbRLMByf>; Wed, 12 Dec 2001 20:54:35 -0500
Received: from [213.97.199.90] ([213.97.199.90]:9088 "HELO fargo")
	by vger.kernel.org with SMTP id <S282998AbRLMBy3> convert rfc822-to-8bit;
	Wed, 12 Dec 2001 20:54:29 -0500
From: "David Gomez" <davidge@jazzfree.com>
Date: Thu, 13 Dec 2001 02:53:55 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.16
Message-ID: <Pine.LNX.4.33.0112130243210.483-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I get this oops executing the configure script from the wget package. I
can reproduce it always, and normally after the first oops, i get a lot
more and the computer gets unusable. The script part when i get this
oops is when is checking the 'strncasecmp' library function.

Below is the oops decoded. Tell me if you need more info.


ksymoops 2.4.1 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): mismatch on symbol journal_enable_debug  , jbd says e082ce64, /lib/modules/2.4.16/kernel/fs/jbd/jbd.o says e082ce50.  Ignoring /lib/modules/2.4.16/kernel/fs/jbd/jbd.o entry
Dec 12 20:21:31 fargo kernel: kernel BUG at page_alloc.c:193!
Dec 12 20:21:31 fargo kernel: invalid operand: 0000
Dec 12 20:21:31 fargo kernel: CPU:    0
Dec 12 20:21:31 fargo kernel: EIP:    0010:[<c0129413>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 12 20:21:31 fargo kernel: EFLAGS: 00010082
Dec 12 20:21:31 fargo kernel: eax: 00000020   ebx: c1a69340   ecx: 00000001   edx: 00001614
Dec 12 20:21:31 fargo kernel: esi: c01f7000   edi: c1a69340   ebp: 00000000   esp: ddfb5e64
Dec 12 20:21:31 fargo kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 20:21:31 fargo kernel: Process bash (pid: 702, stackpage=ddfb5000)
Dec 12 20:21:31 fargo kernel: Stack: c01dbe33 000000c1 00000003 00000286 00000000 c01f6fe8 c01f715c 000001ff
Dec 12 20:21:31 fargo kernel:        00000000 000001d2 c0129843 c01f6fe8 c01f7158 00000000 00000000 00000001
Dec 12 20:21:31 fargo kernel:        c177dfc0 c177dfc0 c012043d 080c2808 00000001 c191c124 df1f8f70 c01209ca
Dec 12 20:21:31 fargo kernel: Call Trace: [<c0129843>] [<c012043d>] [<c01209ca>] [<c014cb91>] [<c01ccdd5>]
Dec 12 20:21:31 fargo kernel:    [<c0110917>] [<c0112766>] [<c01130be>] [<c01107ac>] [<c0106cfc>]
Dec 12 20:21:31 fargo kernel: Code: 0f 0b 58 5a 8b 03 8b 53 04 89 50 04 89 02 8b 44 24 0c 2b b8

>>EIP; c0129413 <rmqueue+67/20c>   <=====
Trace; c0129843 <__alloc_pages+37/15c>
Trace; c012043d <do_wp_page+89/160>
Trace; c01209ca <handle_mm_fault+86/c0>
Trace; c014cb91 <ext2_lookup+5d/68>
Trace; c01ccdd5 <rb_insert_color+b5/d8>
Trace; c0110917 <do_page_fault+16b/474>
Trace; c0112766 <copy_mm+266/290>
Trace; c01130be <do_fork+5d6/674>
Trace; c01107ac <do_page_fault+0/474>
Trace; c0106cfc <error_code+34/3c>
Code;  c0129413 <rmqueue+67/20c>
00000000 <_EIP>:
Code;  c0129413 <rmqueue+67/20c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129415 <rmqueue+69/20c>
   2:   58                        pop    %eax
Code;  c0129416 <rmqueue+6a/20c>
   3:   5a                        pop    %edx
Code;  c0129417 <rmqueue+6b/20c>
   4:   8b 03                     mov    (%ebx),%eax
Code;  c0129419 <rmqueue+6d/20c>
   6:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c012941c <rmqueue+70/20c>
   9:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012941f <rmqueue+73/20c>
   c:   89 02                     mov    %eax,(%edx)
Code;  c0129421 <rmqueue+75/20c>
   e:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c0129425 <rmqueue+79/20c>
  12:   2b b8 00 00 00 00         sub    0x0(%eax),%edi


1 warning issued.  Results may not be reliable.




David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra




