Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRLWWHV>; Sun, 23 Dec 2001 17:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282081AbRLWWHD>; Sun, 23 Dec 2001 17:07:03 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.227]:49834 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S281863AbRLWWGo>; Sun, 23 Dec 2001 17:06:44 -0500
Message-ID: <3C26555F.3000802@nyc.rr.com>
Date: Sun, 23 Dec 2001 17:06:23 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS Kernel 2.4.17
In-Reply-To: <fa.cc39hdv.18kqu2b@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case any of you are interested in what caused this oops.
I was compiling the kernel with gcc 3.1.0 (unknowingly at
first).

Compiling the kernel with gcc 2.9.5, gcc 2.9.6, and gcc 3.0.3
does not cause this oops.


John Weber wrote:

> As previously posted, this oops occurs on boot (and somewhere after or
> during the loading of the floppy driver).
> 
> $ ksymoops --no-ksyms --no-lsmod -o /lib/modules/2.4.17/ -m
> /boot/System.map-2.4.17 Oops.file 
> ksymoops 2.4.1 on i686 2.4.16.  Options used
>      -V (default)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.17/ (specified)
>      -m /boot/System.map-2.4.17 (specified)
> 
> No modules in ksyms, skipping objects
> Unable to handle kernel paging request at virual address 0000413d
> c0106ea6
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0106ea6>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: c7faff2c   ebx: c7fae000   ecx: 00000000   edx: 00000001
> esi: c7faff60   edi: c7fae246   ebp: 00004111   esp: c7fafe84
> ds: 0018   es: 0018   ss: 0018
> Process keventd (pid: 2, stackpage=c7faf000)
> Stack: 00000202 c02962e0 c7fae000 00000000 c02e8500 c7fae000 c7fafef4
> c02eab80
>        c7fafed4 c0112fec 00000000 c7fae000 00000000 00000000 00000001
> c7fae000
>        c7fafef8 c7fafef8 c7f62000 00000008 00004000 c0114b13 00000000
> 00004111
> Call Trace: [<c0112fec>] [<c0114b13>] [<c0121ec0>] [<c0105abf>]
> [<c0107384>]
>    [<c0121ec0>] [<c0105655>] [<c0121f33>] [<c0121ec0>] [<c011a54a>]
> [<c01224dc>]
>    [<c0122310>] [<c0105000>] [<c010565e>] [<c0122310>]
> Code: 8b 45 2c 83 e0 03 83 f8 03 74 0f 81 c4 94 00 00 00 89 d0 5b
> 
> 
>>>EIP; c0106ea6 <do_signal+16/2e0>   <=====
>>>
> Trace; c0112fec <wait_for_completion+6c/90>
> Trace; c0114b13 <do_fork+4b3/640>
> Trace; c0121ec0 <____call_usermodehelper+0/50>
> Trace; c0105abf <sys_clone+2f/40>
> Trace; c0107384 <signal_return+14/18>
> Trace; c0121ec0 <____call_usermodehelper+0/50>
> Trace; c0105655 <kernel_thread+25/40>
> Trace; c0121f33 <__call_usermodehelper+23/40>
> Trace; c0121ec0 <____call_usermodehelper+0/50>
> Trace; c011a54a <__run_task_queue+5a/70>
> Trace; c01224dc <context_thread+1cc/1e0>
> Trace; c0122310 <context_thread+0/1e0>
> Trace; c0105000 <_stext+0/0>
> Trace; c010565e <kernel_thread+2e/40>
> Trace; c0122310 <context_thread+0/1e0>
> Code;  c0106ea6 <do_signal+16/2e0>
> 00000000 <_EIP>:
> Code;  c0106ea6 <do_signal+16/2e0>   <=====
>    0:   8b 45 2c                  mov    0x2c(%ebp),%eax   <=====
> Code;  c0106ea9 <do_signal+19/2e0>
>    3:   83 e0 03                  and    $0x3,%eax
> Code;  c0106eac <do_signal+1c/2e0>
>    6:   83 f8 03                  cmp    $0x3,%eax
> Code;  c0106eaf <do_signal+1f/2e0>
>    9:   74 0f                     je     1a <_EIP+0x1a> c0106ec0
> <do_signal+30/2e0>
> Code;  c0106eb1 <do_signal+21/2e0>
>    b:   81 c4 94 00 00 00         add    $0x94,%esp
> Code;  c0106eb7 <do_signal+27/2e0>
>   11:   89 d0                     mov    %edx,%eax
> Code;  c0106eb9 <do_signal+29/2e0>
>   13:   5b                        pop    %ebx
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



