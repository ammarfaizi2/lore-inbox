Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318508AbSGSMlh>; Fri, 19 Jul 2002 08:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318506AbSGSMlh>; Fri, 19 Jul 2002 08:41:37 -0400
Received: from gherkin.frus.com ([192.158.254.49]:384 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S318505AbSGSMlg>;
	Fri, 19 Jul 2002 08:41:36 -0400
Message-Id: <m17VX7e-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.2[5-6] VM problem (oops)
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jul 2002 07:44:38 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, this report is not as detailed as it needs to be (can't
run ksymoops while the affected kernels are running).  2.5.25 and 2.5.26
both seem to have this problem, whereas 2.5.24 and earlier kernels are
fine.  Problem is that kernel will generally "oops" within 24 hours of
booting.  The process that triggers the oops isn't constant, but the
general character of the oops *is*...  Here's the log, such as it is:

kernel BUG at page_alloc.c:182!
invalid operand: 0000
CPU:    0
EIP:    0010:[rmqueue+655/760]    Tainted: P  
EFLAGS: 00013202
eax: 01000010   ebx: c12db6d8   ecx: c0280db4   edx: 01000010
esi: c0280db4   edi: c0280dcc   ebp: 00000000   esp: d6acbd44
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1236, threadinfo=d6aca000 task=d533a040)
Stack: c0280f40 000001ff 00000000 c0280db4 00001000 d6aca000 00013514 00003292 
       c0280dcc 00000000 c0280db4 c012ca25 000001d2 d357bba0 d3c235b8 4056e000 
       c0280f3c 000001d2 ffffff00 c012c836 d6aca000 c01237bc d385f404 d357bba0 
Call Trace: [__alloc_pages+61/384] [_alloc_pages+22/24] [do_anonymous_page+80/328] [do_no_page+56/536] [handle_mm_fault+98/256] 
   [do_page_fault+403/1172] [do_page_fault+0/1172] [__alloc_pages+61/384] [ext2_readpages+22/28] [ext2_get_block+0/864] [read_pages+33/132] 
   [error_code+52/64] [file_read_actor+91/136] [do_generic_file_read+248/792] [generic_file_read+280/308] [file_read_actor+0/136] [vfs_read+151/276] 
   [sys_read+40/60] [syscall_call+7/11] 

Code: 0f 0b b6 00 2b 4d 23 c0 90 8b 43 14 f6 c4 20 74 08 0f 0b b7 

Yes, the kernel is tainted (NVIDIA driver).  However, the only difference
between the tainted and non-tainted kernels is that the tainted ones will
crash faster, i.e., running X11 makes bad things happen faster, but not
running X11 doesn't keep bad things from happening.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
