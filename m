Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273525AbRIQJPI>; Mon, 17 Sep 2001 05:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273554AbRIQJOu>; Mon, 17 Sep 2001 05:14:50 -0400
Received: from [212.21.93.242] ([212.21.93.242]:13202 "EHLO k242")
	by vger.kernel.org with ESMTP id <S273525AbRIQJOg>;
	Mon, 17 Sep 2001 05:14:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Oops in kswapd of linux-2.4.8-ac5
From: andreas.koenig@anima.de (Andreas J. Koenig)
Date: 17 Sep 2001 11:12:58 +0200
Message-ID: <m3k7yygoyt.fsf@anima.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before this Oops the kernel was running for 22 days with high load.
I'm pretty sure, at that time some of the swap space was actually in
use, no idea how much. It's an SMP box with 4 SCSI disks. Each disk
has a swap partition:

# swapon -s
Filename                        Type            Size    Used    Priority
/dev/sda3                       partition       1004052 0       -1
/dev/sdb3                       partition       1004052 0       -2
/dev/sdc3                       partition       1004052 0       -3
/dev/sdd3                       partition       1004052 0       -4

(I realize now that I forgot the pri= option in /etc/fstab)

The box was pingable but not available for connecting, so the ksymoops
was run on the /var/log/messages file after rebooting.

Please let me know if you need further details.

# ksymoops /var/log/messages
ksymoops 0.7c on i686 2.4.8-ac5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac5/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01f04f0, System.map says c0153330.  Ignoring ksyms_base entry
Aug 15 00:23:37 k77 kernel: cpu: 0, clocks: 995643, slice: 331881 
Aug 15 00:23:37 k77 kernel: cpu: 1, clocks: 995643, slice: 331881 
Aug 15 11:08:13 k77 kernel: cpu: 0, clocks: 995651, slice: 331883 
Aug 15 11:08:13 k77 kernel: cpu: 1, clocks: 995651, slice: 331883 
Aug 15 12:54:03 k77 kernel: cpu: 0, clocks: 995665, slice: 331888 
Aug 15 12:54:03 k77 kernel: cpu: 1, clocks: 995665, slice: 331888 
Aug 15 13:10:16 k77 kernel: cpu: 0, clocks: 995726, slice: 331908 
Aug 15 13:10:16 k77 kernel: cpu: 1, clocks: 995726, slice: 331908 
Aug 15 13:41:59 sb11 kernel: cpu: 0, clocks: 995652, slice: 331884 
Aug 15 13:41:59 sb11 kernel: cpu: 1, clocks: 995652, slice: 331884 
Aug 23 14:33:10 sb11 kernel: cpu: 0, clocks: 995576, slice: 331858 
Aug 23 14:33:10 sb11 kernel: cpu: 1, clocks: 995576, slice: 331858 
Aug 23 14:43:31 sb11 kernel: cpu: 0, clocks: 995715, slice: 331905 
Aug 23 14:43:31 sb11 kernel: cpu: 1, clocks: 995715, slice: 331905 
Aug 23 14:46:47 sb11 kernel: cpu: 0, clocks: 995648, slice: 331882 
Aug 23 14:46:47 sb11 kernel: cpu: 1, clocks: 995648, slice: 331882 
Aug 23 13:23:23 sb11 kernel: cpu: 0, clocks: 995712, slice: 331904 
Aug 23 13:23:23 sb11 kernel: cpu: 1, clocks: 995712, slice: 331904 
Sep 15 15:29:13 sb11 kernel: invalid operand: 0000 
Sep 15 15:29:13 sb11 kernel: CPU:    1 
Sep 15 15:29:13 sb11 kernel: EIP:    0010:[prune_dcache+131/352] 
Sep 15 15:29:13 sb11 kernel: EFLAGS: 00010202 
Sep 15 15:29:13 sb11 kernel: eax: 0400dc3e   ebx: ccf63ab8   ecx: ecdc0ee0   edx: df9b1d38 
Sep 15 15:29:13 sb11 kernel: esi: ccf63aa0   edi: c1eef060   ebp: ffffaafe   esp: f7f45f68 
Sep 15 15:29:13 sb11 kernel: ds: 0018   es: 0018   ss: 0018 
Sep 15 15:29:13 sb11 kernel: Process kswapd (pid: 5, stackpage=f7f45000) 
Sep 15 15:29:13 sb11 kernel: Stack: c012cfeb 00000001 00000000 00000185 0000f8ae 00000000 c028fd20 00000000  
Sep 15 15:29:13 sb11 kernel:        00000000 0000031b c012d8ed 00000185 00000185 000000c0 00000000 0008e000  
Sep 15 15:29:13 sb11 kernel:        c0148bd1 00000000 c012dbc7 00000000 000000c0 000000c0 00000000 ffffffff  
Sep 15 15:29:13 sb11 kernel: Call Trace: [do_page_launder+315/2096] [free_shortage+13/48] [shrink_dcache_memory+33/64] [do_try_to_free_pages+39/96] [kswapd+89/256]  
Sep 17 11:46:21 sb11 kernel: cpu: 0, clocks: 995641, slice: 331880 
Sep 17 11:46:21 sb11 kernel: cpu: 1, clocks: 995641, slice: 331880 

2 warnings issued.  Results may not be reliable.


-- 
andreas
