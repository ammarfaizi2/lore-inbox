Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293705AbSCMLnc>; Wed, 13 Mar 2002 06:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293726AbSCMLnM>; Wed, 13 Mar 2002 06:43:12 -0500
Received: from atchoum.office.be.wanadoo.com ([195.74.207.5]:48914 "HELO
	Atchoum.lan.wanadoo.be") by vger.kernel.org with SMTP
	id <S293705AbSCMLnH> convert rfc822-to-8bit; Wed, 13 Mar 2002 06:43:07 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OOPS] In 2.4.17 __free_pages_ok
X-MIMEOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Wed, 13 Mar 2002 12:43:13 +0100
Message-ID: <92D340F1F4235A4EBC8A872482AE5372DC08C2@exchange.lan.wanadoo.be>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OOPS] In 2.4.17 __free_pages_ok
Thread-Index: AcHKf6C1ctFDtAZ/T02AQnDcXiO1PQAAASawAAEdTLA=
From: =?iso-8859-1?Q?Fran=E7ois_Baligant_=28Wanadoo=29?= 
	<francois.baligant@be.wanadoo.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I just noticed I have this just before the Oops message,
	maybe I can help to pinpoint where the problem lies.

memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00300000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.
memory.c:100: bad pmd 00100000.
memory.c:100: bad pmd 00200000.

-----Original Message-----
From: François Baligant (Wanadoo) 
Sent: mercredi 13 mars 2002 12:11
To: linux-kernel@vger.kernel.org
Subject: [OOPS] In 2.4.17 __free_pages_ok



Hi,

This is 2.4.17-0.18 from RedHat Rawhide on a very busy UP Intel Web server.

I have done quite a bit of search and found a thread about something
that look similar here:

From: Hugh Dickins (hugh@veritas.com)
Subject: Re: [PATCH] __free_pages_ok oops
Newsgroups: linux.kernel

Date: 2002-02-07 12:30:11 PST
http://groups.google.com/groups?q=g:thl114668156d&hl=en&newwindow=1&selm=Pin
e.LNX.4.21.0202071930320.1533-100000%40localhost.localdomain&rnum=33

I checked in 2.4.18 and 2.4.19pre3, this particular patch didn't make it in.

My question is:

- Am I hit by the same bug ? If yes, Can I go with that particular patch ?

kernel BUG at page_alloc.c:131!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f92a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000020   ebx: c152fcf8   ecx: 00000001   edx: 00002183
esi: 00000000   edi: c1000030   ebp: 00000000   esp: c7f8fde8
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 22189, stackpage=c7f8f000)
Stack: c02987bb 00000083 c11545c0 c11545f8 c1038030 c02c3408 c1528d30
c013445d
       d6149890 00100000 c9f4d4f4 0000f000 17b5f005 c0122e8f c152fcf8
00000010
       00000000 4022e000 d48b5400 4012e000 00000000 4022e000 d48b5400
00000000
Call Trace: [<c013445d>] page_remove_rmap [kernel] 0x5d
[<c0122e8f>] do_zap_page_range [kernel] 0x18f
[<c012feac>] __alloc_pages_limit [kernel] 0x7c
[<c0123370>] zap_page_range [kernel] 0x50
[<c0125a9d>] exit_mmap [kernel] 0xbd
[<c0114796>] mmput [kernel] 0x26
[<c01189a3>] do_exit [kernel] 0xb3
[<c011dcb3>] collect_signal [kernel] 0x93
[<c011dd6d>] dequeue_signal [kernel] 0x6d
[<c0106da4>] do_signal [kernel] 0x234
[<c0106275>] restore_sigcontext [kernel] 0x115
[<c0106359>] sys_sigreturn [kernel] 0xb9
[<c0106f2c>] signal_return [kernel] 0x14
Code: 0f 0b 5f 5d 0f b6 43 25 89 f1 c6 43 24 05 89 dd 83 63 18 eb

>>EIP; c012f92a <__free_pages_ok+11a/310>   <=====
Trace; c013445d <page_remove_rmap+5d/70>
Trace; c0122e8f <do_zap_page_range+18f/250>
Trace; c012feac <__alloc_pages_limit+7c/b0>
Trace; c0123370 <zap_page_range+50/80>
Trace; c0125a9d <exit_mmap+bd/130>
Trace; c0114796 <mmput+26/50>
Trace; c01189a3 <do_exit+b3/1f0>
Trace; c011dcb3 <collect_signal+93/e0>
Trace; c011dd6d <dequeue_signal+6d/b0>
Trace; c0106da4 <do_signal+234/2a0>
Trace; c0106275 <restore_sigcontext+115/140>
Trace; c0106359 <sys_sigreturn+b9/f0>
Trace; c0106f2c <signal_return+14/18>
Code;  c012f92a <__free_pages_ok+11a/310>
00000000 <_EIP>:
Code;  c012f92a <__free_pages_ok+11a/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f92c <__free_pages_ok+11c/310>
   2:   5f                        pop    %edi
Code;  c012f92d <__free_pages_ok+11d/310>
   3:   5d                        pop    %ebp
Code;  c012f92e <__free_pages_ok+11e/310>
   4:   0f b6 43 25               movzbl 0x25(%ebx),%eax
Code;  c012f932 <__free_pages_ok+122/310>
   8:   89 f1                     mov    %esi,%ecx
Code;  c012f934 <__free_pages_ok+124/310>
   a:   c6 43 24 05               movb   $0x5,0x24(%ebx)
Code;  c012f938 <__free_pages_ok+128/310>
   e:   89 dd                     mov    %ebx,%ebp
Code;  c012f93a <__free_pages_ok+12a/310>
  10:   83 63 18 eb               andl   $0xffffffeb,0x18(%ebx)

regards,
Francois




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
