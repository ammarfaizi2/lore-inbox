Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbTCMQ0l>; Thu, 13 Mar 2003 11:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbTCMQ0l>; Thu, 13 Mar 2003 11:26:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43136 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262450AbTCMQ0j>;
	Thu, 13 Mar 2003 11:26:39 -0500
Date: Thu, 13 Mar 2003 17:37:07 +0100
From: Jens Axboe <axboe@suse.de>
To: James Stevenson <james@stev.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-ID: <20030313163707.GH836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014b01c2e978$701050e0$0cfea8c0@ezdsp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, James Stevenson wrote:
> Hi
> 
> strange looks alot like the ones i have seen though the whole 2.4.x tree.
> 
> this was discussed before somebody said they would send a patch myself
> and sombody else were going to test it but the patch never happens.
> >From what i can work out an error occurs on the cd drive and the request
> queue is then empty and the ide-scsi driver then attempts to access the
> reuest queue that doesnt exist i never did manage to find out
> where the request get removed from the queue though.

Your explanation doesn't quite make sense, but I can take a look at the
problem :-)

What kernel is the below oops from? What compiler?

> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01e5783>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 00000000   ebx: c7a71000   ecx: c0327104   edx: 00000000
> esi: 00000001   edi: c13a4fc0   ebp: cb23df58   esp: cb23df44
> ds: 0018   es: 0018   ss: 0018
> Process klogd (pid: 381, stackpage=cb23d000)
> Stack: 00000000 c0327294 c13de260 c0327294 00000202 cb23df78 c01cdd11
> c0327294
>        c01e5700 c0327104 c121db00 04000001 0000000f cb23df98 c010a0bd
> 0000000f
>        c13de260 cb23dfc4 cb23dfc4 0000000f c02f8ae0 cb23dfbc c010a24d
> 0000000f
> Call Trace: [<c01cdd11>] [<c01e5700>] [<c010a0bd>] [<c010a24d>] [<c010c358>]
> Code: 8b 72 18 46 89 72 18 8b 55 f0 8b 82 f0 00 00 00 8b 58 04 53
> 
> >>EIP; c01e5783 <idescsi_pc_intr+83/290>   <=====
> Trace; c01cdd11 <ide_intr+c1/120>
> Trace; c01e5700 <idescsi_pc_intr+0/290>
> Trace; c010a0bd <handle_IRQ_event+3d/70>
> Trace; c010a24d <do_IRQ+7d/c0>
> Trace; c010c358 <call_do_IRQ+5/d>
> Code;  c01e5783 <idescsi_pc_intr+83/290>
> 00000000 <_EIP>:
> Code;  c01e5783 <idescsi_pc_intr+83/290>   <=====
>    0:   8b 72 18                  mov    0x18(%edx),%esi   <=====
> Code;  c01e5786 <idescsi_pc_intr+86/290>
>    3:   46                        inc    %esi
> Code;  c01e5787 <idescsi_pc_intr+87/290>
>    4:   89 72 18                  mov    %esi,0x18(%edx)
> Code;  c01e578a <idescsi_pc_intr+8a/290>
>    7:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
> Code;  c01e578d <idescsi_pc_intr+8d/290>
>    a:   8b 82 f0 00 00 00         mov    0xf0(%edx),%eax
> Code;  c01e5793 <idescsi_pc_intr+93/290>
>   10:   8b 58 04                  mov    0x4(%eax),%ebx
> Code;  c01e5796 <idescsi_pc_intr+96/290>
>   13:   53                        push   %ebx
> 
> <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 1 warning issued.  Results may not be reliable.

-- 
Jens Axboe

