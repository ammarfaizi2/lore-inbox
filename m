Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284393AbRLLAaH>; Tue, 11 Dec 2001 19:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284432AbRLLAaC>; Tue, 11 Dec 2001 19:30:02 -0500
Received: from air-1.osdl.org ([65.201.151.5]:20751 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S284393AbRLLA26>;
	Tue, 11 Dec 2001 19:28:58 -0500
Date: Tue, 11 Dec 2001 16:22:27 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Berend De Schouwer <bds@jhb.ucs.co.za>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za>
Message-ID: <Pine.LNX.4.33L2.0112111611590.4033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2001, Berend De Schouwer wrote:

| [1.] One line summary of the problem:
|
| Running "cat /proc/ioports" causes a segfault and kernel oops.
|
|
| [2.] Full description of the problem/report:
|
| Running "cat /proc/ioports" may cause cat to segfault, and the kernel to
| Oops.  It doesn't happen immediately after boot -- its required to run
| the kernel for some time (minimum two days for me), and make it do some
| work.
|
|
| [3.] Keywords (i.e., modules, networking, kernel):
|
| kernel, proc
|
|
| [4.] Kernel version (from /proc/version):
|
| Linux version 2.4.14 (root@clo002c.clobea.co.za)
|   (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81))
|   #3 SMP Mon Nov 12 15:34:14 SAST 2001

Have you tried any newer kernels?  (although I don't see any
changes in this area)

| [5.] Output of Oops.. message (if applicable) with symbolic information
|      resolved (see Documentation/oops-tracing.txt)
|
| Unable to handle kernel paging request at virtual address f886bc55
|  printing eip:
| c02a925b
| *pde = 37bb5067
| *pte = 00000000
| Oops: 0000
| CPU:    0
| EIP:    0010:[vsnprintf+523/1056]    Not tainted
| EIP:    0010:[<c02a925b>]    Not tainted
| EFLAGS: 00010297
| eax: f886bc55   ebx: d957f16c   ecx: f886bc55   edx: fffffffe
| esi: ffffffff   edi: e98ddec4   ebp: ffffffff   esp: e98dde6c
| ds: 0018   es: 0018   ss: 0018
| Process cat (pid: 29869, stackpage=e98dd000)
| Stack: 00000000 ffffffff 0000000a d760e480 d957f15e 00000006 d9580000 c02a94a6
|        d957f15e 26a80ea2 c02bd8a6 e98ddeb8 c02a94c4 d957f15e c02bd895 e98ddeb8
|        c011dcfb d957f15e c02bd895 00003000 0000307f f886bc55 c2838478 d957f15e
| Call Trace: [vsprintf+22/32] [sprintf+20/32] [do_resource_list+75/128] [do_resource_list+107/128] [get_resource_list+66/96]
| Call Trace: [<c02a94a6>] [<c02a94c4>] [<c011dcfb>] [<c011dd1b>] [<c011dd72>]
|    [ioports_read_proc+46/96] [proc_file_read+206/400] [sys_read+150/208] [sys_brk+186/240] [system_call+51/56]
|    [<c0154eae>] [<c0152a3e>] [<c01368f6>] [<c0127caa>] [<c010712b>]
| Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10 89 c6
|
| and ksymoops < oops:
|
| Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
| says c0254350, System.map says c01560b0.  Ignoring ksyms_base entry
|
| >>EIP; c02a925b <vsnprintf+20b/420>   <=====
| Trace; c02a94a6 <vsprintf+16/20>
| Trace; c02a94c4 <sprintf+14/20>
| Trace; c011dcfb <do_resource_list+4b/80>
| Trace; c011dd1b <do_resource_list+6b/80>
| Trace; c011dd72 <get_resource_list+42/60>
| Trace; c0154eae <ioports_read_proc+2e/60>
| Trace; c0152a3e <proc_file_read+ce/190>
| Trace; c01368f6 <sys_read+96/d0>
| Trace; c0127caa <sys_brk+ba/f0>
| Trace; c010712b <system_call+33/38>
| Code;  c02a925b <vsnprintf+20b/420>
| 00000000 <_EIP>:
| Code;  c02a925b <vsnprintf+20b/420>   <=====
|    0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
| Code;  c02a925e <vsnprintf+20e/420>
|    3:   74 07                     je     c <_EIP+0xc> c02a9267 <vsnprintf+217/420>
| Code;  c02a9260 <vsnprintf+210/420>
|    5:   40                        inc    %eax
| Code;  c02a9261 <vsnprintf+211/420>
|    6:   4a                        dec    %edx
| Code;  c02a9262 <vsnprintf+212/420>
|    7:   83 fa ff                  cmp    $0xffffffff,%edx
| Code;  c02a9265 <vsnprintf+215/420>
|    a:   75 f4                     jne    0 <_EIP>
| Code;  c02a9267 <vsnprintf+217/420>
|    c:   29 c8                     sub    %ecx,%eax
| Code;  c02a9269 <vsnprintf+219/420>
|    e:   f6 04 24 10               testb  $0x10,(%esp,1)
| Code;  c02a926d <vsnprintf+21d/420>
|   12:   89 c6                     mov    %eax,%esi

Hm, strnlen() in vsnprintf() already has a negative length to work
with (0xfffffffe), then it would inc %eax and dec %edx if it ever
got that far.

I suspect that it's a caller problem -- one that we could paste
over/hide in vsnprintf(), but then we would never find the
real problem (but your system wouldn't die either).

| [6.] A small shell script or example program which triggers the
|      problem (if possible)
|
| cat /proc/ioports
|
|
| [7.3.] Module information (from /proc/modules):
|
| cyclades              147616  16 (autoclean)
| eepro100               16960   1 (autoclean)

Have you noticed if the oops happens if these modules are not
loaded?

| [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
|
| I can't add this :(  It causes the oops.

Did you try /proc/iomem also ?

| [X.] Other notes, patches, fixes, workarounds:
|
| I've had it with 2.4.12, 2.4.12-ac, and 2.4.14.  I've tested the RAM
| with memtest86, and memtest, and haven't found a problem yet.  Oddly
| enough I can run "cat /proc/ioports" right after the machine boots, but
| not after its done some work.  The address listed in "Cannot handle
| kernel paging request" is always the same.  Workaround: don't do that.

-- 
~Randy

