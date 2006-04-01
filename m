Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWDARDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWDARDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 12:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWDARDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 12:03:15 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:7273 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751557AbWDARDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 12:03:15 -0500
Date: Sat, 1 Apr 2006 20:04:30 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Keith Owens <kaos@sgi.com>, Nathan Scott <nathans@sgi.com>
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.16
Message-ID: <20060401170430.GA14715@localdomain>
References: <28258.1142920764@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28258.1142920764@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 04:59:24PM +1100, Keith Owens wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> KDB (Linux Kernel Debugger) has been updated for kernel 2.6.16.
> 
> ftp://oss.sgi.com/projects/kdb/download/v4.4/
> ftp://ftp.ocs.com.au/pub/mirrors/oss.sgi.com/projects/kdb/download/v4.4/
> 
> Note:  Due to a spam attack, the kdb@oss.sgi.com mailing list is now
> subscriber only.  If you reply to this mail, you may wish to trim
> kdb@oss.sgi.com from the cc: list.
> 
> Thanks to Nathan Scott for updating KDB while I was on holiday.
> 
> Current versions are :-
> 
>   kdb-v4.4-2.6.16-common-1.bz2
>   kdb-v4.4-2.6.16-i386-1.bz2
>   kdb-v4.4-2.6.16-ia64-1.bz2

Thanks for this new version, however I'm looking forward to see
kdb maintained also for the x86_64 architecture. Currently I have 
got as far as forward-porting it to a level where it "works" except 
for one annoying issue where setjmp/longjmp looks to be broken:

[0]more> q                                                   
invalid opcode: 0000 [1] SMP 
kdb: Debugger re-entered on cpu 0, new reason = 5
     Attempting to abort command and recover     
invalid opcode: 0000 [2] SMP                
kdb: Debugger re-entered on cpu 0, new reason = 5
     Attempting to abort command and recover     
invalid opcode: 0000 [3] SMP                
kdb: Debugger re-entered on cpu 0, new reason = 5
     Attempting to abort command and recover     
invalid opcode: 0000 [4] SMP                
kdb: Debugger re-entered on cpu 0, new reason = 5
     Attempting to abort command and recover     
invalid opcode: 0000 [5] SMP                
[...]

An inescapable loop. 

Kernel configured with CONFIG_FRAME_POINTER=y,
gcc version 3.3.5 (Debian 1:3.3.5-13).

ffffffff8032fc90 <kdba_setjmp>:
ffffffff8032fc90:       55                      push   %rbp
ffffffff8032fc91:       48 89 e5                mov    %rsp,%rbp
ffffffff8032fc94:       48 89 5f 00             mov    %rbx,0x0(%rdi)
ffffffff8032fc98:       48 89 6f 08             mov    %rbp,0x8(%rdi)
ffffffff8032fc9c:       4c 89 67 10             mov    %r12,0x10(%rdi)
ffffffff8032fca0:       4c 89 6f 18             mov    %r13,0x18(%rdi)
ffffffff8032fca4:       4c 89 77 20             mov    %r14,0x20(%rdi)
ffffffff8032fca8:       4c 89 7f 28             mov    %r15,0x28(%rdi)
ffffffff8032fcac:       48 8d 54 24 10          lea    0x10(%rsp),%rdx
ffffffff8032fcb1:       48 89 57 30             mov    %rdx,0x30(%rdi)
ffffffff8032fcb5:       48 8b 04 24             mov    (%rsp),%rax
ffffffff8032fcb9:       48 89 47 38             mov    %rax,0x38(%rdi)
ffffffff8032fcbd:       65 8b 04 25 24 00 00    mov    %gs:0x24,%eax
ffffffff8032fcc4:       00 
ffffffff8032fcc5:       48 c7 c1 c0 86 57 80    mov    $0xffffffff805786c0,%rcx
ffffffff8032fccc:       48 98                   cltq   
ffffffff8032fcce:       8b 14 81                mov    (%rcx,%rax,4),%edx
ffffffff8032fcd1:       80 ce 04                or     $0x4,%dh
ffffffff8032fcd4:       89 14 81                mov    %edx,(%rcx,%rax,4)
ffffffff8032fcd7:       31 c0                   xor    %eax,%eax
ffffffff8032fcd9:       c9                      leaveq 
ffffffff8032fcda:       c3                      retq   
ffffffff8032fcdb:       66                      data16
ffffffff8032fcdc:       66                      data16
ffffffff8032fcdd:       90                      nop    
ffffffff8032fcde:       66                      data16
ffffffff8032fcdf:       90                      nop    

ffffffff8032fce0 <kdba_longjmp>:
ffffffff8032fce0:       55                      push   %rbp
ffffffff8032fce1:       48 89 e5                mov    %rsp,%rbp
ffffffff8032fce4:       48 8b 5f 00             mov    0x0(%rdi),%rbx
ffffffff8032fce8:       48 8b 6f 08             mov    0x8(%rdi),%rbp
ffffffff8032fcec:       4c 8b 67 10             mov    0x10(%rdi),%r12
ffffffff8032fcf0:       4c 8b 6f 18             mov    0x18(%rdi),%r13
ffffffff8032fcf4:       4c 8b 77 20             mov    0x20(%rdi),%r14
ffffffff8032fcf8:       4c 8b 7f 28             mov    0x28(%rdi),%r15
ffffffff8032fcfc:       85 f6                   test   %esi,%esi
ffffffff8032fcfe:       b8 01 00 00 00          mov    $0x1,%eax
ffffffff8032fd03:       0f 44 f0                cmove  %eax,%esi
ffffffff8032fd06:       89 f0                   mov    %esi,%eax
ffffffff8032fd08:       48 8b 57 38             mov    0x38(%rdi),%rdx
ffffffff8032fd0c:       48 8b 67 30             mov    0x30(%rdi),%rsp
ffffffff8032fd10:       ff e2                   jmpq   *%edx
ffffffff8032fd12:       c9                      leaveq 
ffffffff8032fd13:       c3                      retq   
ffffffff8032fd14:       66                      data16
ffffffff8032fd15:       66                      data16
ffffffff8032fd16:       66                      data16
ffffffff8032fd17:       90                      nop    
ffffffff8032fd18:       66                      data16
ffffffff8032fd19:       66                      data16
ffffffff8032fd1a:       66                      data16
ffffffff8032fd1b:       90                      nop    
ffffffff8032fd1c:       66                      data16
ffffffff8032fd1d:       66                      data16
ffffffff8032fd1e:       66                      data16
ffffffff8032fd1f:       90                      nop
-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
