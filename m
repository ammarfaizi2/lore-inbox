Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUCYRcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbUCYRcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:32:51 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61427 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263348AbUCYRcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:32:45 -0500
Date: Thu, 25 Mar 2004 09:32:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: bugzilla@stone.nu
Subject: [Bug 2367] New: kernel BUG at inode.c:334! 
Message-ID: <90520000.1080235942@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2367

           Summary: kernel BUG at inode.c:334!
    Kernel Version: 2.4.25
            Status: NEW
          Severity: normal
             Owner: axboe@suse.de
         Submitter: bugzilla@stone.nu


Distribution: Debian GNU/Linux
Hardware Environment: IBM Netfinity 6000 / ICP Vortex / EXP300 Disk cabinet
Software Environment: Vanilla Debian GNU/Linux (woody)

Problem Description:
kernel BUG at inode.c:334!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c014b8bc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: f7b0606c   ebx: 0000000f   ecx: ee95c228   edx: f7b06000
esi: ee95c220   edi: f7b06064   ebp: f7b0606c   esp: f031df88
ds: 0018   es: 0018   ss: 0018
Process fsstress (pid: 883, stackpage=f031d000)
Stack: f7b06000 f031c000 bffffb94 bffff918 f7b06064 c014bd16 f7b06000 00000000
       c0137e4e 00000000 f031c000 400135cc c0137eab 00000000 c0106e77 4012ee48
       4012ad74 080505a0 400135cc bffffb94 bffff918 00000024 0000002b 0000002b
Call Trace:    [<c014bd16>] [<c0137e4e>] [<c0137eab>] [<c0106e77>]
Code: 0f 0b 4e 01 b5 a5 2a c0 89 d8 0c 08 24 f8 89 86 1c 01 00 00

>> EIP; c014b8bc <sync_inodes_sb+90/250>   <=====

>> eax; f7b0606c <_end+3777e8e8/3865b8dc>
>> ecx; ee95c228 <_end+2e5d4aa4/3865b8dc>
>> edx; f7b06000 <_end+3777e87c/3865b8dc>
>> esi; ee95c220 <_end+2e5d4a9c/3865b8dc>
>> edi; f7b06064 <_end+3777e8e0/3865b8dc>
>> ebp; f7b0606c <_end+3777e8e8/3865b8dc>
>> esp; f031df88 <_end+2ff96804/3865b8dc>

Trace; c014bd16 <sync_inodes+36/4c>
Trace; c0137e4e <fsync_dev+3a/80>
Trace; c0137eab <sys_sync+7/10>
Trace; c0106e77 <system_call+33/38>

Code;  c014b8bc <sync_inodes_sb+90/250>
00000000 <_EIP>:
Code;  c014b8bc <sync_inodes_sb+90/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014b8be <sync_inodes_sb+92/250>
   2:   4e                        dec    %esi
Code;  c014b8bf <sync_inodes_sb+93/250>
   3:   01 b5 a5 2a c0 89         add    %esi,0x89c02aa5(%ebp)
Code;  c014b8c5 <sync_inodes_sb+99/250>
   9:   d8 0c 08                  fmuls  (%eax,%ecx,1)
Code;  c014b8c8 <sync_inodes_sb+9c/250>
   c:   24 f8                     and    $0xf8,%al
Code;  c014b8ca <sync_inodes_sb+9e/250>
   e:   89 86 1c 01 00 00         mov    %eax,0x11c(%esi)

Steps to reproduce:
1) Download the latest LTP testsuite
2) Build and install the testsuite
3) Make sure the NFS server daemons are running
4) Export an XFS filesystem to be used for testing, globally, with root allowed.
   ex: /mnt/xfs *(sync,rw, no_root_squash)
5) Change directory to where the LTP is installed
6) Change directory to testcases/bin/
7) Execute 'nfs_fsstress.sh' and follow the prompts.
   a) Enter your hostname as the server
   b) Enter the export filesystem name, i.e. /mnt/xfs
   c) Enter "10" for the number of hours to execute.

The oops should occur within 2-3h or so.

This was found when trying to resolve XFS bug:
http://oss.sgi.com/bugzilla/show_bug.cgi?id=309

