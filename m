Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbQLXXy7>; Sun, 24 Dec 2000 18:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131538AbQLXXyt>; Sun, 24 Dec 2000 18:54:49 -0500
Received: from inje.iskon.hr ([213.191.128.16]:55566 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S130664AbQLXXyd>;
	Sun, 24 Dec 2000 18:54:33 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Marco d'Itri" <md@Linux.IT>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.10.10012241004430.3972-100000@penguin.transmeta.com>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 25 Dec 2000 00:23:49 +0100
In-Reply-To: Linus Torvalds's message of "Sun, 24 Dec 2000 10:10:38 -0800 (PST)"
Message-ID: <87puihl7y2.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sun, 24 Dec 2000, Linus Torvalds wrote:
> > 
> > Marco, would you mind changing the test in reclaim_page(), somewheer
> > around line mm/vmscan.c:487 that says:
> 

Speaking of page_launder() I just stumbled upon two oopsen today on
the UP build. Maybe it could give a hint to someone, I'm not that good
at Oops decoding.

Merry Christmas!


Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c012872e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[page_launder+510/2156]
EFLAGS: 00010202
eax: 00000000   ebx: c12e2ce8   ecx: c1244474   edx: 00000000
esi: c12e2d04   edi: 00000000   ebp: 00000000   esp: c15d1fb4
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 6, stackpage=c15d1000)
Stack: c15d0000 00000000 c15d023a 0008e000 00000000 00000000 00000001 00002933 
       00000000 c0131e5d 00000003 00000000 00010f00 c146ff88 c146ffc4 c01073fc 
       c146ffc4 00000078 c146ffc4 
Call Trace: [bdflush+141/236] [kernel_thread+40/56] 
Code: 8b 40 0c 8b 00 85 c0 0f 84 ba 04 00 00 83 7c 24 10 00 75 73 


Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c012872e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[page_launder+510/2156]
EFLAGS: 00010202
eax: 00000000   ebx: c1260eec   ecx: c15d5fe0   edx: c02917f0
esi: c1260f08   edi: 00000000   ebp: 00000000   esp: c15d5f9c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c15d5000)
Stack: 00010f00 00000004 00000000 00000000 00000004 00000000 00000000 00002938 
       00000000 c01290fc 00000004 00000000 00010f00 c01f77f7 c15d4239 0008e000 
       c01291c6 00000004 00000000 c146ffb8 00000000 c01073fc 00000000 00000078 
Call Trace: [do_try_to_free_pages+52/128] [tvecs+8683/64084] [kswapd+126/288] [kernel_thread+40/56] 
Code: 8b 40 0c 8b 00 85 c0 0f 84 ba 04 00 00 83 7c 24 10 00 75 73 

-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
