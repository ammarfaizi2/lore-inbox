Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTLKQnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbTLKQm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:42:57 -0500
Received: from mxsf24.cluster1.charter.net ([209.225.28.224]:10503 "EHLO
	mxsf24.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265154AbTLKQmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:42:06 -0500
Date: Thu, 11 Dec 2003 11:38:25 -0500
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups patch, no difference)
Message-ID: <20031211163825.GA1413@forming>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <1071159379.1331.4.camel@slappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071159379.1331.4.camel@slappy>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-nf2v4 i686
X-Uptime: 11:32:17 up 6 min,  2 users,  load average: 1.04, 0.88, 0.43
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Dec 11, 2003 at 11:16:20AM -0500, Disconnect wrote:
> I've posted this a couple of times, with no response.
> 
> So long as memory pressure is kept to a minimum, the system is stable. 
> Running without swap and without serious work kept it going for a couple
> of weeks.
> 
> Running (currently with the nforce2-lockups patches and HZ=1000 but no
> APIC/IO-APIC) results in the same oopses as every kernel I've tried,
> including 2.4.22.
> 
> Suggestions? I'd really love to be able to use this thing reliably under
> Linux :(
> 

Do you see hard locks with APIC/IO-APIC enabled?  Do you see this oops
with APIC/IO-APIC enabled?  Just curious because I can reproduce the
hard locks eventually, but never get an oops.  Also, what patches are
you running and what kernel version?

> Unable to handle kernel NULL pointer dereference at virtual address 00000089
> c012dff7
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c012dff7>]    Tainted: P
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010206
> eax: 00000081   ebx: cff72b58   ecx: cee3a000   edx: 0000cad6
> esi: 00001000   edi: cbabd9b4   ebp: 00000081   esp: cee3bf08
> ds: 0018   es: 0018   ss: 0018
> Process giftd (pid: 29738, stackpage=cee3b000)
> Stack: c03155c0 c238b1c0 c44671c0 00000038 cee3a000 00000eea 00000000 00000000
>        00000116 cbabd900 c012e6a0 cee3bf74 c2974660 c2974640 00001000 00001000
>        00000000 00000000 c012e7f2 c2974640 c2974660 cee3bf74 c012e6a0 c0222e67
> Call Trace:    [<c012e6a0>] [<c012e7f2>] [<c012e6a0>] [<c0222e67>] [<c013d413>]
>   [<c0108fdf>]
> Code: 39 78 08 74 05 8b 40 10 eb f2 39 68 0c 75 f6 85 c0 89 c6 0f
>  
>  
> >>EIP; c012dff7 <do_generic_file_read+157/4e0>   <=====
>  
> >>ebx; cff72b58 <_end+fc02f6c/104a5494>
> >>ecx; cee3a000 <_end+eaca414/104a5494>
> >>edi; cbabd9b4 <_end+b74ddc8/104a5494>
> >>esp; cee3bf08 <_end+eacc31c/104a5494>
>  
> Trace; c012e6a0 <file_read_actor+0/a0>
> Trace; c012e7f2 <generic_file_read+b2/1a0>
> Trace; c012e6a0 <file_read_actor+0/a0>
> Trace; c0222e67 <sys_send+37/40>
> Trace; c013d413 <sys_read+a3/110>
> Trace; c0108fdf <system_call+33/38>
>  
> Code;  c012dff7 <do_generic_file_read+157/4e0>
> 00000000 <_EIP>:
> Code;  c012dff7 <do_generic_file_read+157/4e0>   <=====
>    0:   39 78 08                  cmp    %edi,0x8(%eax)   <=====
> Code;  c012dffa <do_generic_file_read+15a/4e0>
>    3:   74 05                     je     a <_EIP+0xa>
> Code;  c012dffc <do_generic_file_read+15c/4e0>
>    5:   8b 40 10                  mov    0x10(%eax),%eax
> Code;  c012dfff <do_generic_file_read+15f/4e0>
>    8:   eb f2                     jmp    fffffffc <_EIP+0xfffffffc>
> Code;  c012e001 <do_generic_file_read+161/4e0>
>    a:   39 68 0c                  cmp    %ebp,0xc(%eax)
> Code;  c012e004 <do_generic_file_read+164/4e0>
>    d:   75 f6                     jne    5 <_EIP+0x5>
> Code;  c012e006 <do_generic_file_read+166/4e0>
>    f:   85 c0                     test   %eax,%eax
> Code;  c012e008 <do_generic_file_read+168/4e0>
>   11:   89 c6                     mov    %eax,%esi
> Code;  c012e00a <do_generic_file_read+16a/4e0>
>   13:   0f 00 00                  sldtl  (%eax)
> 
> -- 
> Disconnect <lkml@sigkill.net>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
