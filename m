Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281199AbRKYXK5>; Sun, 25 Nov 2001 18:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281194AbRKYXKs>; Sun, 25 Nov 2001 18:10:48 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:41616 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281196AbRKYXKk>;
	Sun, 25 Nov 2001 18:10:40 -0500
Message-ID: <3C017A6E.A4A3E2A6@pobox.com>
Date: Sun, 25 Nov 2001 15:10:38 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Henderson <hendersj@mindspring.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:  kernel BUG at filemap.c:791
In-Reply-To: <3C016E08.3C2D2537@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Henderson wrote:

> After compiling a 2.2.14 kernel on one of my systems, I've started
> receiving this problem.  Kernel is patched with the ext3 filesystem
> patches, however running without ext3 being used results in this problem
> as well.

Wow, it must have taken quite some effort
to patch a 2.2 kernel for ext3!

OK, assuming you really mean 2.4.14, there
is a patch floating around the list for that -

I had a compaq 6500 that would scribble
on the disk and then lock up hard at some
random point in time - but that behaviour
could be triggered immediatley by running
dbench  - Look for the compaq patches from
Jens Axboe or better yet, lose 2.4.14 and go
straight to 2.4.16-pre1, since it has the ida
raid fixes, and ext3 support already.

cu

jjs

> This can happen at any time, I've seen it during startup and after the
> system has been running for a couple of days; it is reproducable, but
> not at will (ie, it's a given that it will happen but unknown as to what
> causes it).  Previous kernels I've run (2.4.2 and 2.4.6) do not exhibit
> this problem.

>
>
> Here's the crash info with symbols resolved:
>
> --- snip ---
>
> ksymoops 2.4.0 on i486 2.4.6.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.14/ (specified)
>      -m /boot/System.map-2.4.14 (specified)
>
> No modules in ksyms, skipping objects
> kernel BUG at filemap.c:791!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0122938>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010086
> eax: 0000001d   ebx: c1133980   ecx: c0270660   edx: 00006181
> esi: c0080134   edi: c11e3c00   ebp: 00000001   esp: c4ef5b50
> ds: 0018   es: 0018   ss: 0018
> Process syslogd (pid: 365, stackpage=c4ef5000)
> Stack: c022640b 00000317 00000000 c0080134 c01abbb4 c4cc96c0 00000001
> 00000002
>        c011a834 00000001 c02c65c0 00000000 c11444e0 24000001 0000000e
> c4ef5bd4
>        c01082aa 0000000e c11e3c00 c4ef5bd4 c4ef5bd4 0000000e c02bcac0
> c11444e0
> Call Trace: [<c01abbb4>] [<c011a834>] [<c01082aa>] [<c010842d>]
> [<c01ab6bc>]
>    [<c01176a0>] [<c0117473>] [<c010845c>] [<c011a740>] [<c019ec3a>]
> [<c0117473>]
>    [<c010845c>] [<c019f2ea>] [<c019e75e>] [<c0117858>] [<c012ed26>]
> [<c011778b>]
>    [<c01176a0>] [<c012f985>] [<c010845c>] [<c01ab8ba>] [<c01d8b6c>]
> [<c01da75d>]
>    [<c020966f>] [<c02096cf>] [<c012fc95>] [<c0130640>] [<c0130b14>]
> [<c0124db6>]
>    [<c0124e16>] [<c012e248>] [<c0124900>] [<c0161d4a>] [<c015fb74>]
> [<c012f1aa>]
>    [<c0106ef3>]
> Code: 0f 0b 5a 59 8d 43 28 8d 73 24 39 43 28 74 19 89 f0 5b b9 01
>
> >>EIP; c0122938 <unlock_page+28/60>   <=====
> Trace; c01abbb4 <do_ida_intr+1f4/270>
> Trace; c011a834 <timer_bh+24/250>
> Trace; c01082aa <handle_IRQ_event+3a/70>
> Trace; c010842d <do_IRQ+6d/b0>
> Trace; c01ab6bc <do_ida_request+dc/2f0>
> Trace; c01176a0 <tasklet_hi_action+50/80>
> Trace; c0117473 <do_softirq+53/a0>
> Trace; c010845c <do_IRQ+9c/b0>
> Trace; c011a740 <update_process_times+20/b0>
> Trace; c019ec3a <__make_request+fa/670>
> Trace; c0117473 <do_softirq+53/a0>
> Trace; c010845c <do_IRQ+9c/b0>
> Trace; c019f2ea <generic_make_request+13a/150>
> Trace; c019e75e <generic_unplug_device+1e/30>
> Trace; c0117858 <__run_task_queue+48/60>
> Trace; c012ed26 <__wait_on_buffer+56/90>
> Trace; c011778b <bh_action+1b/50>
> Trace; c01176a0 <tasklet_hi_action+50/80>
> Trace; c012f985 <fsync_inode_data_buffers+e5/120>
> Trace; c010845c <do_IRQ+9c/b0>
> Trace; c01ab8ba <do_ida_request+2da/2f0>
> Trace; c01d8b6c <__kfree_skb+dc/e0>
> Trace; c01da75d <skb_free_datagram+1d/30>
> Trace; c020966f <unix_dgram_recvmsg+9f/110>
> Trace; c02096cf <unix_dgram_recvmsg+ff/110>
> Trace; c012fc95 <__refile_buffer+55/60>
> Trace; c0130640 <__block_commit_write+a0/c0>
> Trace; c0130b14 <generic_commit_write+54/60>
> Trace; c0124db6 <generic_file_write+4b6/590>
> Trace; c0124e16 <generic_file_write+516/590>
> Trace; c012e248 <do_readv_writev+1d8/260>
> Trace; c0124900 <generic_file_write+0/590>
> Trace; c0161d4a <ext2_update_inode+38a/3a0>
> Trace; c015fb74 <ext2_fsync_inode+14/50>
> Trace; c012f1aa <sys_fsync+5a/90>
> Trace; c0106ef3 <system_call+33/40>
> Code;  c0122938 <unlock_page+28/60>
> 00000000 <_EIP>:
> Code;  c0122938 <unlock_page+28/60>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c012293a <unlock_page+2a/60>
>    2:   5a                        pop    %edx
> Code;  c012293b <unlock_page+2b/60>
>    3:   59                        pop    %ecx
> Code;  c012293c <unlock_page+2c/60>
>    4:   8d 43 28                  lea    0x28(%ebx),%eax
> Code;  c012293f <unlock_page+2f/60>
>    7:   8d 73 24                  lea    0x24(%ebx),%esi
> Code;  c0122942 <unlock_page+32/60>
>    a:   39 43 28                  cmp    %eax,0x28(%ebx)
> Code;  c0122945 <unlock_page+35/60>
>    d:   74 19                     je     28 <_EIP+0x28> c0122960
> <unlock_page+50/60>
> Code;  c0122947 <unlock_page+37/60>
>    f:   89 f0                     mov    %esi,%eax
> Code;  c0122949 <unlock_page+39/60>
>   11:   5b                        pop    %ebx
> Code;  c012294a <unlock_page+3a/60>
>   12:   b9 01 00 00 00            mov    $0x1,%ecx
>
>  <0>Kernel panic: Aiee, killing interrupt handler!
>
> --- snip ---
>
> The problem is reported in the unlock_page function in filemap.c with
> this bit of code:
>
>  if (!test_and_clear_bit(PG_locked, &(page)->flags))
>                 BUG();
>
> Module-wise, the only options selected are for LAN drivers (not
> including the one actually being used) and a SYM710 SCSI controller (for
> an external CD-ROM drive that is powered off).
>
> The following info comes from a stable 2.4.6 kernel procfs output (since
> 2.2.14 doesn't want to stay running long enough for me to get this info
> from there):
>
> CPU Info:
>
> --- snip ---
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 4
> model           : 14
> model name      : Am5x86-WT
> stepping        : 4
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu
> bogomips        : 66.35
>
> --- snip ---
>
> No SCSI drivers loaded, but a Compaq SMART controller is in use:
>
> --- snip ---
>
> ida0:  Compaq SMART Controller
>        Board ID: 0x2040110e
>        Firmware Revision: 2.26
>        Controller Sig: 0x2ae7909f
>        Memory Address: 0x00000000
>        I/O Port: 0x5000
>        IRQ: 14
>        Logical drives: 1
>        Physical drives: 2
>
>        Current Q depth: 0
>        Max Q depth since init: 42
>
> Logical Drive Info:
> ida/c0d0: blksz=512 nr_blks=8217120
> nr_allocs = 3961
> nr_frees = 3961
>
> --- snip ---
>
> The system is an EISA system, Compaq Prosignia VS with 80 MB of RAM and
> an AMD K5 processor, integrated AMD network adapter, Compaq SMART
> controller.
>
> The only other patch applied to this kernel is the one suggested in this
> list for loopback device (loop.c to remove the deactivate_page(page)
> calls which prevent the kernel from properly compiling.
>
> I have a second system (Celeron 300A processor, 640 MB of RAM, and IDE
> drives) that runs 2.2.14 with these same patches with no problems that
> I've seen.
>
> Please let me know if there's any other information needed to diagnose
> this problem - this is the first time I've ever had a kernel crash, and
> I hope I've included all the relevant information here.  I don't
> subscribe to the linux-kernel list, so all correspondence should be
> copied to me directly as well if possible.
>
> Thanks,
>
> Jim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

