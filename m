Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbRFLS6E>; Tue, 12 Jun 2001 14:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFLS5y>; Tue, 12 Jun 2001 14:57:54 -0400
Received: from NET.WAU.NL ([137.224.10.12]:32019 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S263106AbRFLS5j>;
	Tue, 12 Jun 2001 14:57:39 -0400
Date: Tue, 12 Jun 2001 20:57:56 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: from dmesg: kernel BUG at inode.c:486
In-Reply-To: <XFMail.20010612113936.davidel@xmailserver.org>; from
 davidel@xmailserver.org on Tue, Jun 12, 2001 at 11:39:36AM -0700
To: linux-kernel@vger.kernel.org
Message-id: <20010612205756.A26346@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 8:55pm  up 27 days, 4 min,  2 users,  load average: 1.00,
 1.00, 1.00
X-Reverse-Engineered: High priority for sending SMS messages
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>
 <XFMail.20010612113936.davidel@xmailserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today my girlfriend reported all programs that accessed my 
NFS mounted drive where crashing. I use Linux 2.4.5 on the client
with these .config options (for NFS):
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y

The server is a very old install, running user-space NFS daemon:
fender:~$ /usr/sbin/rpc.nfsd --version
Universal NFS Server 2.2beta41

When running dmesg on the client I got this output:

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fffb>]
EFLAGS: 00010286
eax: 0000001b   ebx: cc703ba0   ecx: 00000001   edx: c025ba84
esi: c025ec60   edi: c976eac0   ebp: c32fdfa4   esp: c32fdeec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 1193, stackpage=c32fd000)
Stack: c021b86d c021b8cc 000001e6 cc703ba0 c01409c7 cc703ba0 cceee320
cc703ba0 
       c015e62a cc703ba0 c013e5d6 cceee320 cc703ba0 cceee320 00000000
c013723c 
       cceee320 c32fdf68 c013795a c976eac0 c32fdf68 00000000 c8587000
00000000 
Call Trace: [<c01409c7>] [<c015e62a>] [<c013e5d6>] [<c013723c>] [<c013795a>]
[<c0137f68>] [<c0135276>] 
       [<c0106a7b>] [<c010002b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fffb>]
EFLAGS: 00010286
eax: 0000001b   ebx: c62eb840   ecx: 00000001   edx: c025ba84
esi: c025ec60   edi: c976eac0   ebp: c7135fa4   esp: c7135eec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 1239, stackpage=c7135000)
Stack: c021b86d c021b8cc 000001e6 c62eb840 c01409c7 c62eb840 cf7285e0
c62eb840 
       c015e62a c62eb840 c013e5d6 cf7285e0 c62eb840 cf7285e0 00000000
c013723c 
       cf7285e0 c7135f68 c013795a c976eac0 c7135f68 00000000 c89ac000
00000000 
Call Trace: [<c01409c7>] [<c015e62a>] [<c013e5d6>] [<c013723c>] [<c013795a>]
[<c0137f68>] [<c0135276>] 
       [<c0106a7b>] [<c010002b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fffb>]
EFLAGS: 00010286
eax: 0000001b   ebx: c62ebde0   ecx: 00000001   edx: c025ba84
esi: c025ec60   edi: c976eac0   ebp: c32fdfa4   esp: c32fdeec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 1243, stackpage=c32fd000)
Stack: c021b86d c021b8cc 000001e6 c62ebde0 c01409c7 c62ebde0 cf7288e0
c62ebde0 
       c015e62a c62ebde0 c013e5d6 cf7288e0 c62ebde0 cf7288e0 00000000
c013723c 
       cf7288e0 c32fdf68 c013795a c976eac0 c32fdf68 00000000 c55df000
00000000 
Call Trace: [<c01409c7>] [<c015e62a>] [<c013e5d6>] [<c013723c>] [<c013795a>]
[<d8e7dda3>] [<c0137f68>] 
       [<c0135276>] [<c0106a7b>] [<c010002b>] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 

I have no idea what this means, to me it looks serious so I decided to
post it on the kernel mailinglist. Is this a real bug? If I have to provide 
more detailed information please tell me what you need and how to get it.

thanks,
	Olivier Sessink
	

