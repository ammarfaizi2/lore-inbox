Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292950AbSCDWdq>; Mon, 4 Mar 2002 17:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292956AbSCDWda>; Mon, 4 Mar 2002 17:33:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:64852 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292948AbSCDWdN>; Mon, 4 Mar 2002 17:33:13 -0500
Date: Mon, 4 Mar 2002 23:33:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jure Pecar <pegasus@telemach.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc2aa2 oops in page_alloc.c
Message-ID: <20020304233343.R20606@dualathlon.random>
In-Reply-To: <20020120182655.301234b4.pegasus@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020120182655.301234b4.pegasus@telemach.net>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 06:26:55PM +0100, Jure Pecar wrote:
> I just got this mailed from the logs on our mail server. The BUG said it's in page_alloc.c line 85.
> System is a redhat 6.2, 4way p3 xeon, 2gb ram, 512mb swap. Heavily loaded through the week (mostly i/o: sendmail, cyrus, ldap, mysql), altough the oops occured at the time of least activity.
> 
> ksymoops 0.7c on i686 2.4.17-rc2aa2.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.17-rc2aa2/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0218650, System.map says c015ac60.  Ignoring ksyms_base entry
> Jan 19 23:04:01 castor kernel: invalid operand: 0000 
> Jan 19 23:04:01 castor kernel: CPU:    0 
> Jan 19 23:04:01 castor kernel: EIP:    0010:[__free_pages_ok+171/740]    Not tainted 
> Jan 19 23:04:01 castor kernel: EFLAGS: 00010282 
> Jan 19 23:04:01 castor kernel: eax: 0000001f   ebx: 00000028   ecx: c02d8388   edx: 0000651b 
> Jan 19 23:04:01 castor kernel: esi: c232fc40   edi: dd52a000   ebp: df749000   esp: dd52bed0 
> Jan 19 23:04:01 castor kernel: ds: 0018   es: 0018   ss: 0018 
> Jan 19 23:04:01 castor kernel: Process ps (pid: 20330, stackpage=dd52b000) 
> Jan 19 23:04:01 castor kernel: Stack: c0281b01 00000055 00000028 c232fc40 dd52a000 df749000 dd52a000 eee015a0  
> Jan 19 23:04:01 castor kernel:        bfffff2c 00000000 00000000 00000000 c012f620 c011d554 00000000 eee015a0  
> Jan 19 23:04:01 castor kernel:        df749000 e28d0000 c232fc40 00000f2c eee015bc dd52a000 eee015bc df749000  
> Jan 19 23:04:01 castor kernel: Call Trace: [__free_pages+28/32] [access_process_vm+448/540] [proc_pid_cmdline+100/256] [proc_info_read+89/296] [sys_read+142/196]  
> Jan 19 23:04:01 castor kernel: Code: 0f 0b 83 c4 08 8b 46 18 a8 80 74 11 6a 57 68 01 1b 28 c0 e8
> Using defaults from ksymoops -t elf32-i386 -a i386
> 

this is fixed in 2.4.19pre1aa1. It's fixed thanks to Ben's removal of
page_cache_release.

Andrea
