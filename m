Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278216AbRJMAee>; Fri, 12 Oct 2001 20:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278217AbRJMAeZ>; Fri, 12 Oct 2001 20:34:25 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:54788 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S278216AbRJMAeL>; Fri, 12 Oct 2001 20:34:11 -0400
Message-ID: <3BC78AFA.F7B4B80F@osdl.org>
Date: Fri, 12 Oct 2001 17:29:46 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tanner@real-time.com
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cat /proc/ioports Segmentation faults
In-Reply-To: <20011010223443.V26659@real-time.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob-

Have you tried 2.4.12?

Does anyone know if this was a fluke in 2.4.10
or a real problem?  I've yet to try 2.4.12.

Oops occurred in vsnprintf() -- actually in the inline func.
"strnlen()" (the only one in the vsnprintf function).

string size is negative and the cmp to -1 won't happen
because it's already -2 (in edx).

~Randy

Bob Tanner wrote:
> 
> [1.] One line summary of the problem:
> cat /proc/ioports seg faults
> 
> [2.] Full description of the problem/report:
> Upgraded from 2.4.10 to 2.4.11, during troubleshooting a usb problem, I was
> cat-ing /proc/interrupts and /proc/ioports. The last cat to /proc/ioports seg
> faulted and syslog says this:
> 
> Oct 10 23:22:51 transmuter kernel: Unable to handle kernel paging request at
> virtual address c883a769
> Oct 10 23:22:51 transmuter kernel:  printing eip:
> Oct 10 23:22:51 transmuter kernel: c021fb5b
> Oct 10 23:22:51 transmuter kernel: *pde = 07f9d067
> Oct 10 23:22:51 transmuter kernel: *pte = 00000000
> Oct 10 23:22:51 transmuter kernel: Oops: 0000
> Oct 10 23:22:51 transmuter kernel: CPU:    0
> Oct 10 23:22:51 transmuter kernel: EIP:    0010:[vsnprintf+523/1056]    Not
> tainted
> Oct 10 23:22:51 transmuter kernel: EFLAGS: 00010297
> Oct 10 23:22:51 transmuter kernel: eax: c883a769   ebx: c4e29297   ecx: c883a769
> edx: fffffffe
> Oct 10 23:22:51 transmuter kernel: esi: ffffffff   edi: c71bfec8   ebp: ffffffff
> esp: c71bfe70
> Oct 10 23:22:51 transmuter kernel: ds: 0018   es: 0018   ss: 0018
> Oct 10 23:22:51 transmuter kernel: Process cat (pid: 1353, stackpage=c71bf000)
> Oct 10 23:22:51 transmuter kernel: Stack: 00000000 ffffffff 0000000a c1204e80
> c4e29289 00000006 c4e2a000 c021fda6
> Oct 10 23:22:51 transmuter kernel:        c4e29289 3b1d6d77 c022bc46 c71bfebc
> c021fdc4 c4e29289 c022bc35 c71bfebc
> Oct 10 23:22:51 transmuter kernel:        c011a43b c4e29289 c022bc35 0000fcc0
> 0000fcdf c883a769 c12114c8 c4e29289
> Oct 10 23:22:51 transmuter kernel: Call Trace: [vsprintf+22/32] [sprintf+20/32]
> [do_resource_list+75/128] [do_resource_list+107/128] [get_resource_list+49/64]
> Oct 10 23:22:51 transmuter kernel:    [ioports_read_proc+46/96]
> [proc_file_read+206/400] [sys_read+150/208] [system_call+51/56]
> Oct 10 23:22:51 transmuter kernel:
> Oct 10 23:22:51 transmuter kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29
> c8 f6 04 24 10 89 c6
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> # lsmod
> Module                  Size  Used by
> 3c574_cs                8768   1
> ppp_async               6160   0  (autoclean) (unused)
> ppp_generic            17168   0  (autoclean) [ppp_async]
> slhc                    4576   0  (autoclean) [ppp_generic]
> agpgart                28448   0  (unused)
> ymfpci                 40704   0
> uart401                 6096   0  [ymfpci]
> sound                  54400   0  [uart401]
> soundcore               3568   4  [ymfpci sound]
> ac97_codec              9264   0  [ymfpci]
> 
> [4.] Kernel version (from /proc/version):
> # cat /proc/version
> Linux version 2.4.11 (root@transmuter.real-time.com) (gcc version 2.96 20000731
> (Red Hat Linux 7.1 2.96-85)) #1 Wed Oct 10 22:51:43 CDT 2001
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
> ksymoops 2.3.4 on i686 2.4.11.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.11/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Warning (compare_maps): mismatch on symbol _ctype  , ksyms_base says c027ec14,
> System.map says c027ebf4.  Ignoring ksyms_base entry
...similar removed...

> ac97_codec: AC97 Audio codec, id: 0x414b:0x4d02 (Asahi Kasei AK4543)
> 3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds, becker@scyld.com.
> Unable to handle kernel paging request at virtual address c883a769
> c021fb5b
> *pde = 07f9d067
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c021fb5b>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010297
> eax: c883a769   ebx: c4e29297   ecx: c883a769   edx: fffffffe
> esi: ffffffff   edi: c71bfec8   ebp: ffffffff   esp: c71bfe70
> ds: 0018   es: 0018   ss: 0018
> Process cat (pid: 1353, stackpage=c71bf000)
> Stack: 00000000 ffffffff 0000000a c1204e80 c4e29289 00000006 c4e2a000 c021fda6
>        c4e29289 3b1d6d77 c022bc46 c71bfebc c021fdc4 c4e29289 c022bc35 c71bfebc
>        c011a43b c4e29289 c022bc35 0000fcc0 0000fcdf c883a769 c12114c8 c4e29289
> Call Trace: [<c021fda6>] [<c021fdc4>] [<c011a43b>] [<c011a45b>] [<c011a4a1>]
>    [<c014d7fe>] [<c014b5be>] [<c0131406>] [<c0106ce7>]
> Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10 89 c6
> 
> >>EIP; c021fb5b <vsnprintf+20b/420>   <=====
> Trace; c021fda6 <vsprintf+16/20>
> Trace; c021fdc4 <sprintf+14/20>
> Trace; c011a43b <do_resource_list+4b/80>
> Trace; c011a45b <do_resource_list+6b/80>
> Trace; c011a4a1 <get_resource_list+31/40>
> Trace; c014d7fe <ioports_read_proc+2e/60>
> Trace; c014b5be <proc_file_read+ce/190>
> Trace; c0131406 <sys_read+96/d0>
> Trace; c0106ce7 <system_call+33/38>
> Code;  c021fb5b <vsnprintf+20b/420>
> 00000000 <_EIP>:
> Code;  c021fb5b <vsnprintf+20b/420>   <=====
>    0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
> Code;  c021fb5e <vsnprintf+20e/420>
>    3:   74 07                     je     c <_EIP+0xc> c021fb67
> <vsnprintf+217/420>
> Code;  c021fb60 <vsnprintf+210/420>
>    5:   40                        inc    %eax
> Code;  c021fb61 <vsnprintf+211/420>
>    6:   4a                        dec    %edx
> Code;  c021fb62 <vsnprintf+212/420>
> 00000000 <_EIP>:
> Code;  c021fb5b <vsnprintf+20b/420>   <=====
>    0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
> Code;  c021fb5e <vsnprintf+20e/420>
>    3:   74 07                     je     c <_EIP+0xc> c021fb67
> <vsnprintf+217/420>
> Code;  c021fb60 <vsnprintf+210/420>
>    5:   40                        inc    %eax
> Code;  c021fb61 <vsnprintf+211/420>
>    6:   4a                        dec    %edx
> Code;  c021fb62 <vsnprintf+212/420>
>    7:   83 fa ff                  cmp    $0xffffffff,%edx
> Code;  c021fb65 <vsnprintf+215/420>
>    a:   75 f4                     jne    0 <_EIP>
> Code;  c021fb67 <vsnprintf+217/420>
>    c:   29 c8                     sub    %ecx,%eax
> Code;  c021fb69 <vsnprintf+219/420>
>    e:   f6 04 24 10               testb  $0x10,(%esp,1)
> Code;  c021fb6d <vsnprintf+21d/420>
>   12:   89 c6                     mov    %eax,%esi
> 
> 53 warnings issued.  Results may not be reliable.
> 
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
> 
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
> Linux transmuter.real-time.com 2.4.11 #1 Wed Oct 10 22:51:43 CDT 2001 i686
> unknown
...
> [7.2.] Processor information (from /proc/cpuinfo):
> # cat /proc/cpuinfo
...
> [7.3.] Module information (from /proc/modules):
> # cat /proc/modules
...
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> 
> Can't give you /proc/ioports, it seg faults.
> 
> # cat /proc/iomem
...
> [7.5.] PCI information ('lspci -vvv' as root)
...
> [7.6.] SCSI information (from /proc/scsi/scsi)
> 
> Non SCSI system.
