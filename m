Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSH0Mnb>; Tue, 27 Aug 2002 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSH0Mna>; Tue, 27 Aug 2002 08:43:30 -0400
Received: from lila.inti.gov.ar ([200.10.161.32]:27317 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S315923AbSH0Mn3> convert rfc822-to-8bit;
	Tue, 27 Aug 2002 08:43:29 -0400
Message-ID: <3D6B74EE.4000801@inti.gov.ar>
Date: Tue, 27 Aug 2002 09:47:42 -0300
From: Salvador Eduardo Tropea <salvador@inti.gov.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: es-ar, es, en
MIME-Version: 1.0
To: Ingo.Saitz@stud.uni-hannover.de,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       AlanCox <alan@lxorguk.ukuu.org.uk>, willy@w.ods.org, ast@domdv.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can´t find a final conclusion about this topic.
What I found is that it happends some hours after the kernel killed a 
process that was eating the memory.
Example:

Aug 26 13:07:22 ice kernel: Out of Memory: Killed process 18432 
(mozilla-bin).
Aug 26 13:07:22 ice kernel: Out of Memory: Killed process 18443 
(mozilla-bin).
Aug 26 13:07:22 ice kernel: Out of Memory: Killed process 18444 
(mozilla-bin).
Aug 26 13:07:22 ice kernel: Out of Memory: Killed process 18445 
(mozilla-bin).
Aug 26 13:07:22 ice kernel: Out of Memory: Killed process 18447 
(mozilla-bin).
Aug 26 13:07:22 ice kernel: Out of Memory: Killed process 30410 
(mozilla-bin).
....
Aug 27 06:26:00 ice kernel: kernel BUG at page_alloc.c:91!
Aug 27 06:26:00 ice kernel: invalid operand: 0000
Aug 27 06:26:00 ice kernel: CPU:    0
Aug 27 06:26:00 ice kernel: EIP:    0010:[__free_pages_ok+45/624]    
Tainted: P
Aug 27 06:26:00 ice kernel: EFLAGS: 00010286
Aug 27 06:26:00 ice kernel: eax: c103a528   ebx: c1105760   ecx: 
c1105760   edx: c0228e9c
Aug 27 06:26:00 ice kernel: esi: 00000000   edi: 00000016   ebp: 
0000005e   esp: c7f93f18
Aug 27 06:26:00 ice kernel: ds: 0018   es: 0018   ss: 0018
Aug 27 06:26:00 ice kernel: Process kswapd (pid: 4, stackpage=c7f93000)
Aug 27 06:26:00 ice kernel: Stack: c22d28c0 c1105760 00000016 0000005e 
c013755c c1105760 00000
1d0 00000016
Aug 27 06:26:00 ice kernel:        0000005e c0135a09 c22d28c0 c1105760 
c012d482 c012e3fb c012d
4bb 00000020
Aug 27 06:26:00 ice kernel:        000001d0 00000020 00000006 00000006 
c7f92000 000003a4 00000
1d0 c0229034
Aug 27 06:26:00 ice kernel: Call Trace:    [try_to_free_buffers+140/224] 
[try_to_release_page+
73/80] [shrink_cache+482/768] [__free_pages+27/32] [shrink_cache+539/768]
Aug 27 06:26:00 ice kernel:   [shrink_caches+86/128] 
[try_to_free_pages+60/96] [kswapd_balance
_pgdat+67/144] [kswapd_balance+22/48] [kswapd+157/192] [kernel_thread+40/64]

At 6:25 the cron started the regular locate data base update and other 
tasks I guess it made the kernel reduce the size of the cache and fail.
I saw reports it happends with "non-tainted" kernels and with or without 
nVidia driver, so perhaps that´s a real bug in the mechanism used by the 
kernel to kill a process that is eating all the memory introduced in 2.4.19.
I can fill a full bug report but perhaps any of you know about the 
conclusion of this thread and I´m just too stupid to find it.
Note that it doesn´t happend if the kernel doesn´t kill mozilla-bin for 
days, when kernel kills this process is just a matter of hours before it 
and from this point the cache size won´t be reduced.

SET

-- 
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org 
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



