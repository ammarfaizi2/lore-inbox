Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSATR0W>; Sun, 20 Jan 2002 12:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288842AbSATR0N>; Sun, 20 Jan 2002 12:26:13 -0500
Received: from isis.telemach.net ([213.143.65.10]:11271 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S288830AbSATR0B>;
	Sun, 20 Jan 2002 12:26:01 -0500
Date: Sun, 20 Jan 2002 18:26:55 +0100
From: Jure Pecar <pegasus@telemach.net>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.17rc2aa2 oops in page_alloc.c
Message-Id: <20020120182655.301234b4.pegasus@telemach.net>
Organization: Select Technology 
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got this mailed from the logs on our mail server. The BUG said it's in page_alloc.c line 85.
System is a redhat 6.2, 4way p3 xeon, 2gb ram, 512mb swap. Heavily loaded through the week (mostly i/o: sendmail, cyrus, ldap, mysql), altough the oops occured at the time of least activity.

ksymoops 0.7c on i686 2.4.17-rc2aa2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc2aa2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0218650, System.map says c015ac60.  Ignoring ksyms_base entry
Jan 19 23:04:01 castor kernel: invalid operand: 0000 
Jan 19 23:04:01 castor kernel: CPU:    0 
Jan 19 23:04:01 castor kernel: EIP:    0010:[__free_pages_ok+171/740]    Not tainted 
Jan 19 23:04:01 castor kernel: EFLAGS: 00010282 
Jan 19 23:04:01 castor kernel: eax: 0000001f   ebx: 00000028   ecx: c02d8388   edx: 0000651b 
Jan 19 23:04:01 castor kernel: esi: c232fc40   edi: dd52a000   ebp: df749000   esp: dd52bed0 
Jan 19 23:04:01 castor kernel: ds: 0018   es: 0018   ss: 0018 
Jan 19 23:04:01 castor kernel: Process ps (pid: 20330, stackpage=dd52b000) 
Jan 19 23:04:01 castor kernel: Stack: c0281b01 00000055 00000028 c232fc40 dd52a000 df749000 dd52a000 eee015a0  
Jan 19 23:04:01 castor kernel:        bfffff2c 00000000 00000000 00000000 c012f620 c011d554 00000000 eee015a0  
Jan 19 23:04:01 castor kernel:        df749000 e28d0000 c232fc40 00000f2c eee015bc dd52a000 eee015bc df749000  
Jan 19 23:04:01 castor kernel: Call Trace: [__free_pages+28/32] [access_process_vm+448/540] [proc_pid_cmdline+100/256] [proc_info_read+89/296] [sys_read+142/196]  
Jan 19 23:04:01 castor kernel: Code: 0f 0b 83 c4 08 8b 46 18 a8 80 74 11 6a 57 68 01 1b 28 c0 e8
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   8b 46 18                  mov    0x18(%esi),%eax
Code;  00000008 Before first symbol
   8:   a8 80                     test   $0x80,%al
Code;  0000000a Before first symbol
   a:   74 11                     je     1d <_EIP+0x1d> 0000001d Before first symbol
Code;  0000000c Before first symbol
   c:   6a 57                     push   $0x57
Code;  0000000e Before first symbol
   e:   68 01 1b 28 c0            push   $0xc0281b01
Code;  00000013 Before first symbol
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> 00000018 Before first symbol


2 warnings issued.  Results may not be reliable.

About 19 hours later, the box appears to work ok.


Some thoughts on aa kernel ... well it is definitely better that stock 2.4.17, but the box still uses up to 50mb of swap. 2.4.17 went into 300mb easily. For contrast, 2.4.2 which run more than half a year without problems on this box, _never_ swapped.


-- 


Jure Pecar


Unfortunatly, SMTP email is anything but a small set of problems.  Quite the opposite: it's a tarpit of bureaucratic standards committees, arrogant implementors, impatient administrators and whiny end-users.

