Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264425AbUDTWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbUDTWQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264381AbUDTWPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:15:13 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:44306
	"HELO mgix.com") by vger.kernel.org with SMTP id S264556AbUDTVav convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:30:51 -0400
From: "Emmanuel Mogenet" <mgix@mgix.com>
To: <linux-kernel@vger.kernel.org>
Subject: Ooops on with 2.4.22 when using rsync over ssh
Date: Tue, 20 Apr 2004 14:30:39 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBOEAJCPAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The raw and ksymoops'ed oops are at the end of this message.

It happens with a Fedora install and it is 100% reproducible
with my config (happens every single time I launch the rsync command below).

The exact version of the kernel it happens with is:

Linux version 2.4.22-1.2174.nptl (bhcompile@tweety.devel.redhat.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 Wed Feb 18 16:38:32 EST 2004

It happens when I launch the following command from a remote machine:

rsync                                   \
        -v                              \
        -c                              \
        -a                              \
        -e 'ssh -p 2222 -l root'        \
        --stats                         \
        --delete                        \
        --dry-run                       \
        --compress                      \
        --progress                      \
        --numeric-ids                   \
        --no-whole-file                 \
        --no-blocking-io                \
        machine_that_oopses:/data       \
        /v/backup/data                  \


RAW OOPS:
---------

Apr 20 14:02:57 alastor sshd(pam_unix)[16553]: session opened for user root by (uid=0)
Apr 20 14:02:57 alastor kernel:  <1>Unable to handle kernel paging request at virtual address ee832ec0
Apr 20 14:02:57 alastor kernel:  printing eip:
Apr 20 14:02:57 alastor kernel: c01426ae
Apr 20 14:02:57 alastor kernel: *pde = 00000000
Apr 20 14:02:57 alastor kernel: Oops: 0000
Apr 20 14:02:57 alastor kernel: reiserfs sd_mod ipt_state ipt_REJECT ipt_LOG iptable_mangle iptable_nat ip_conntrack iptab
Apr 20 14:02:57 alastor kernel: CPU:    0
Apr 20 14:02:57 alastor kernel: EIP:    0060:[<c01426ae>]    Not tainted
Apr 20 14:02:57 alastor kernel: EFLAGS: 00010286
Apr 20 14:02:57 alastor kernel:
Apr 20 14:02:57 alastor kernel: EIP is at dentry_open [kernel] 0x6e (2.4.22-1.2174.nptl)
Apr 20 14:02:57 alastor kernel: eax: ee832ec0   ebx: cc448d40   ecx: 00000000   edx: 00000000
Apr 20 14:02:57 alastor kernel: esi: cb10c980   edi: ffffffe9   ebp: cdfb4400   esp: ca101f58
Apr 20 14:02:57 alastor kernel: ds: 0068   es: 0068   ss: 0068
Apr 20 14:02:57 alastor kernel: Process rsync (pid: 16574, stackpage=ca101000)
Apr 20 14:02:57 alastor kernel: Stack: 00000004 c8da89c0 00008000 c4bf3000 005d7238 bfe8ea28 c0142637 c8da89c0
Apr 20 14:02:57 alastor kernel:        cdfb4400 00008000 ca101f84 c8da89c0 cdfb4400 c4bf3000 ca1a9b5c 00000007
Apr 20 14:02:57 alastor kernel:        00000001 00000001 005d7238 00000007 c01429d3 c4bf3000 00008000 00000000
Apr 20 14:02:57 alastor sshd(pam_unix)[16553]: session closed for user root
Apr 20 14:02:57 alastor kernel: Call Trace:   [<c0142637>] filp_open [kernel] 0x67 (0xca101f70)
Apr 20 14:02:57 alastor kernel: [<c01429d3>] sys_open [kernel] 0x53 (0xca101fa8)
Apr 20 14:02:57 alastor kernel: [<c01095f7>] system_call [kernel] 0x33 (0xca101fc0)
Apr 20 14:02:57 alastor kernel:
Apr 20 14:02:57 alastor kernel:
Apr 20 14:02:57 alastor kernel: Code: 8b 10 85 d2 0f 85 1e 01 00 00 89 c2 89 53 10 8b 86 a0 00 00

KSYMOOPS'ed:
------------

./ksymoops -m /boot/System.map <~/OOPS 
ksymoops 2.4.9 on i686 2.4.22-1.2174.nptl.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-1.2174.nptl/ (default)
     -m /boot/System.map (specified)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
./ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
./ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.22-1.2174.nptl/build: No such file or directory
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Apr 20 14:02:57 alastor kernel:  <1>Unable to handle kernel paging request at virtual address ee832ec0
Apr 20 14:02:57 alastor kernel: c01426ae
Apr 20 14:02:57 alastor kernel: *pde = 00000000
Apr 20 14:02:57 alastor kernel: Oops: 0000
Apr 20 14:02:57 alastor kernel: CPU:    0
Apr 20 14:02:57 alastor kernel: EIP:    0060:[<c01426ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 20 14:02:57 alastor kernel: EFLAGS: 00010286
Apr 20 14:02:57 alastor kernel: eax: ee832ec0   ebx: cc448d40   ecx: 00000000   edx: 00000000
Apr 20 14:02:57 alastor kernel: esi: cb10c980   edi: ffffffe9   ebp: cdfb4400   esp: ca101f58
Apr 20 14:02:57 alastor kernel: ds: 0068   es: 0068   ss: 0068
Apr 20 14:02:57 alastor kernel: Process rsync (pid: 16574, stackpage=ca101000)
Apr 20 14:02:57 alastor kernel: Stack: 00000004 c8da89c0 00008000 c4bf3000 005d7238 bfe8ea28 c0142637 c8da89c0 
Apr 20 14:02:57 alastor kernel:        cdfb4400 00008000 ca101f84 c8da89c0 cdfb4400 c4bf3000 ca1a9b5c 00000007 
Apr 20 14:02:57 alastor kernel:        00000001 00000001 005d7238 00000007 c01429d3 c4bf3000 00008000 00000000 
Apr 20 14:02:57 alastor kernel: Call Trace:   [<c0142637>] filp_open [kernel] 0x67 (0xca101f70)
Apr 20 14:02:57 alastor kernel: [<c01429d3>] sys_open [kernel] 0x53 (0xca101fa8)
Apr 20 14:02:57 alastor kernel: [<c01095f7>] system_call [kernel] 0x33 (0xca101fc0)
Apr 20 14:02:57 alastor kernel: Code: 8b 10 85 d2 0f 85 1e 01 00 00 89 c2 89 53 10 8b 86 a0 00 00 


>>EIP; c01426ae <dentry_open+6e/1d0>   <=====

>>ebx; cc448d40 <_end+c038e08/e404148>
>>esi; cb10c980 <_end+acfca48/e404148>
>>ebp; cdfb4400 <_end+dba44c8/e404148>
>>esp; ca101f58 <_end+9cf2020/e404148>

Trace; c0142637 <filp_open+67/70>
Trace; c01429d3 <sys_open+53/a0>
Trace; c01095f7 <system_call+33/38>

Code;  c01426ae <dentry_open+6e/1d0>
00000000 <_EIP>:
Code;  c01426ae <dentry_open+6e/1d0>   <=====
   0:   8b 10                     mov    (%eax),%edx   <=====
Code;  c01426b0 <dentry_open+70/1d0>
   2:   85 d2                     test   %edx,%edx
Code;  c01426b2 <dentry_open+72/1d0>
   4:   0f 85 1e 01 00 00         jne    128 <_EIP+0x128>
Code;  c01426b8 <dentry_open+78/1d0>
   a:   89 c2                     mov    %eax,%edx
Code;  c01426ba <dentry_open+7a/1d0>
   c:   89 53 10                  mov    %edx,0x10(%ebx)
Code;  c01426bd <dentry_open+7d/1d0>
   f:   8b 86 a0 00 00 00         mov    0xa0(%esi),%eax


