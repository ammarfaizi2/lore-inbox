Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319237AbSIKRMn>; Wed, 11 Sep 2002 13:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319238AbSIKRMm>; Wed, 11 Sep 2002 13:12:42 -0400
Received: from gargantua.enseirb.fr ([147.210.18.6]:22430 "EHLO
	gargantua.enseirb.fr") by vger.kernel.org with ESMTP
	id <S319237AbSIKRM3>; Wed, 11 Sep 2002 13:12:29 -0400
Date: Wed, 11 Sep 2002 19:16:14 +0200
From: lists@corewars.org
To: Andrea Arcangeli <andrea@suse.de>
Cc: riel@conectiva.com.br, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 OOPS [Repost]
Message-ID: <20020911191614.A2078@corewars.org>
References: <20020903190726.A15065@corewars.org> <20020904201155.A17544@corewars.org> <20020904182223.GE1210@dualathlon.random> <20020905223233.A3893@corewars.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020905223233.A3893@corewars.org>; from lists@corewars.org on Thu, Sep 05, 2002 at 10:32:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Just in case this might shed some more light on the problem...
I recompiled the kernel with frame pointers about a week ago, and I
didn't face a single oops till today morning, when I recompiled the
kernel without frame-pointers and I've been getting the same
oopses all day.

Kind regards,
Sapan


On Thu, Sep 05, 2002 at 10:32:33PM +0200, lists@corewars.org wrote:
> Hi,
> 
> The problem just came back. I got a couple of identical oopses.
> 
> They all fail _immediately_ after returning from swap_free().
> badblocks -w ran fine on the swap partition, and to my knowlege
> I'm not running any applications that might be playing with the disk.
> What else could be causing it?
> 
> Swap is about 530MB. /tmp is on tmpfs.
> 
> Regards,
> Sapan
> 
> 
> Code: 6e 23 c1 40 64 2b c0 00 02 00 00 34 3d 20 c1 02 00 00 00 59 
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   6e                        outsb  %ds:(%esi),(%dx)
> Code;  00000001 Before first symbol
>    1:   23 c1                     and    %ecx,%eax
> Code;  00000003 Before first symbol
>    3:   40                        inc    %eax
> Code;  00000004 Before first symbol
>    4:   64                        fs
> Code;  00000005 Before first symbol
>    5:   2b c0                     sub    %eax,%eax
> Code;  00000007 Before first symbol
>    7:   00 02                     add    %al,(%edx)
> Code;  00000009 Before first symbol
>    9:   00 00                     add    %al,(%eax)
> Code;  0000000b Before first symbol
>    b:   34 3d                     xor    $0x3d,%al
> Code;  0000000d Before first symbol
>    d:   20 c1                     and    %al,%cl
> Code;  0000000f Before first symbol
>    f:   02 00                     add    (%eax),%al
> Code;  00000011 Before first symbol
>   11:   00 00                     add    %al,(%eax)
> Code;  00000013 Before first symbol
>   13:   59                        pop    %ecx
> 
> 00009900
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00009900>]    Not Tainted
> EFLAGS: 00010202
> eax: 00000002   ebx: c0316420   ecx: 00000099   edx: d081e000
> esi: 00000099   edi: cc94fffc   ebp: cd591500   esp: c834be50
> ds: 0018   es: 0018   ss: 0018
> Process ps (pid: 1942, stackpage=c834b000)
> Stack: c11f6948 c0121a16 c0316420 00000001 bffffe62 00000000 cd591500 cc99e2a0 
>        c0121d5b cd591500 cc99e2a0 bffffe62 cc94fffc 00009900 00000000 c390b600 
>        cb4e4000 ffffffea cffbd468 cd591500 bffffe62 c0122adc cd591500 cc99e2a0 
> Call Trace:    [<c0121a16>] [<c0121d5b>] [<c0122adc>] [<c0120dd2>] [<c011ac0d>]
>   [<c014affa>] [<c014afb0>] [<c014b30e>] [<c0130ab6>] [<c01391be>] [<c01305d7>]
>   [<c0108857>]
> Code:  Bad EIP value
> 
> 
> >>EIP; 00009900 Before first symbol   <=====
> 
> >>ebx; c0316420 <swap_info+0/700>
> >>edx; d081e000 <_end+104e4dfc/10528dfc>
> >>edi; cc94fffc <_end+c616df8/10528dfc>
> >>ebp; cd591500 <_end+d2582fc/10528dfc>
> >>esp; c834be50 <_end+8012c4c/10528dfc>
> 
> Trace; c0121a16 <do_swap_page+86/f0>
> Trace; c0121d5b <handle_mm_fault+6b/c0>
> Trace; c0122adc <find_extend_vma+1c/b0>
> Trace; c0120dd2 <get_user_pages+82/1a0>
> Trace; c011ac0d <access_process_vm+11d/160>
> Trace; c014affa <proc_pid_cmdline+4a/e0>
> Trace; c014afb0 <proc_pid_cmdline+0/e0>
> Trace; c014b30e <proc_info_read+4e/110>
> Trace; c0130ab6 <sys_read+96/f0>
> Trace; c01391be <getname+5e/a0>
> Trace; c01305d7 <sys_open+57/80>
> Trace; c0108857 <system_call+33/38>
> 
> 
> On Wed, Sep 04, 2002 at 08:22:23PM +0200, Andrea Arcangeli wrote:
> > On Wed, Sep 04, 2002 at 08:11:55PM +0200, lists@corewars.org wrote:
> > > Just in case this had someone wondering, the problem was swap
> > > corruption. I did an mkswap on the swap partition, and it doesn't
> > > OOPS anymore.
> > 
> > make sense.
> > 
> > The reason of the corruption could be from hardware fault to whatever
> > buggy application that played with the devices, so unless you can
> > reproduce I'd ignore this on the kernel side, at least on 2.4 (kernel
> > trusts metadata, the fs does too, kernel assumes if the data is
> > corrupted an I/O error has to be generated by the hardware, we can add
> > some check to make it more robust but it's not a 2.4 matter).
> > 
> > Andrea
> > -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
