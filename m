Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUESAiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUESAiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUESAiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:38:16 -0400
Received: from listserv.vub.ac.be ([134.184.129.2]:25556 "EHLO guppy.vub.ac.be")
	by vger.kernel.org with ESMTP id S263725AbUESAhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:37:54 -0400
Message-ID: <40AAAC5F.7010707@vub.ac.be>
Date: Wed, 19 May 2004 02:37:51 +0200
From: Michael Van Damme <michael.vandamme@vub.ac.be>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops in filemap_fdatawait (2.4.25)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've experienced an oops with kernel 2.4.25 (stock kernel on a redhat 9
system). The system had been up for over 40 days and wasn't
under any load (it's a webserver that never sees any traffic).
All filesystems are ext3fs.

Michael


ksymoops output:

ksymoops 2.4.5 on i686 2.4.25.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.25/ (default)
      -m /boot/System.map-2.4.25 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address b2928b38
c0127dcc
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0127dcc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 16cf1cc2   ebx: dc9cc884   ecx: dc9c47c0   edx: b2928b38
esi: dc9c4874   edi: dc9c4884   ebp: 00000000   esp: ddfcdf04
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=ddfcd000)
Stack: 00000000 00000001 dc9c47c0 ddee045c ddee0400 c014b955 dc9c4874 
00000000
        ddfcc560 ddfcdfd0 ddfcc560 ddfcc000 c013b498 ddfcc560 ddfcdfd0 
c013b7c4
        c02bc220 00000292 c02ca000 ddfcc000 dc550ec0 c0113321 ddfcdf90 
dc550ec0
Call Trace:    [<c014b955>] [<c013b498>] [<c013b7c4>] [<c0113321>] 
[<c01130b8>]
   [<c016e1a8>] [<c0108d72>] [<c013b6b0>] [<c0105000>] [<c010728e>] 
[<c013b6b0>]
Code: 89 02 89 50 04 c7 03 00 00 00 00 8b 06 89 58 04 89 03 89 73


 >>EIP; c0127dcc <filemap_fdatawait+1c/80>   <=====

 >>eax; 16cf1cc2 Before first symbol
 >>ebx; dc9cc884 <_end+1c691bc0/1e51a3bc>
 >>ecx; dc9c47c0 <_end+1c689afc/1e51a3bc>
 >>edx; b2928b38 Before first symbol
 >>esi; dc9c4874 <_end+1c689bb0/1e51a3bc>
 >>edi; dc9c4884 <_end+1c689bc0/1e51a3bc>
 >>esp; ddfcdf04 <_end+1dc93240/1e51a3bc>

Trace; c014b955 <sync_unlocked_inodes+c5/130>
Trace; c013b498 <sync_old_buffers+8/60>
Trace; c013b7c4 <kupdate+114/170>
Trace; c0113321 <reschedule_idle+91/b0>
Trace; c01130b8 <__change_page_attr+d8/1b0>
Trace; c016e1a8 <__journal_clean_checkpoint_list+28/70>
Trace; c0108d72 <ret_from_fork+6/20>
Trace; c013b6b0 <kupdate+0/170>
Trace; c0105000 <_stext+0/0>
Trace; c010728e <arch_kernel_thread+2e/40>
Trace; c013b6b0 <kupdate+0/170>

Code;  c0127dcc <filemap_fdatawait+1c/80>
00000000 <_EIP>:
Code;  c0127dcc <filemap_fdatawait+1c/80>   <=====
    0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0127dce <filemap_fdatawait+1e/80>
    2:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0127dd1 <filemap_fdatawait+21/80>
    5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c0127dd7 <filemap_fdatawait+27/80>
    b:   8b 06                     mov    (%esi),%eax
Code;  c0127dd9 <filemap_fdatawait+29/80>
    d:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c0127ddc <filemap_fdatawait+2c/80>
   10:   89 03                     mov    %eax,(%ebx)
Code;  c0127dde <filemap_fdatawait+2e/80>
   12:   89 73 00                  mov    %esi,0x0(%ebx)


1 warning issued.  Results may not be reliable.


ver_linux output:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux werkpc66.vub.ac.be 2.4.25 #1 Wed Apr 7 02:15:31 CEST 2004 i686 
athlon i386 GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         ip_conntrack_ftp ipt_state ip_conntrack ipt_ULOG 
ipt_limit iptable_mangle ipt_REJECT iptable_filter ip_tables





