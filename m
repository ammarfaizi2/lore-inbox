Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTKZAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTKZAp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:45:26 -0500
Received: from web40606.mail.yahoo.com ([66.218.78.143]:27156 "HELO
	web40606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263880AbTKZApW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:45:22 -0500
Message-ID: <20031126004521.92703.qmail@web40606.mail.yahoo.com>
Date: Wed, 26 Nov 2003 00:45:21 +0000 (GMT)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: OOPS with Linux-2.6.0-test10 (VFS-related)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was my first attempt with Linux 2.6, so the
userspace environment was still predominantly 2.4 when
this happened. The machine is a dual P4 Xeon with 1 GB
RAM, ACPI and HT enabled:

Nov 25 01:11:52 volcano kernel: Unable to handle
kernel NULL pointer dereference at virtual address
00000018
Nov 25 01:11:52 volcano kernel:  printing eip:
Nov 25 01:11:52 volcano kernel: c0163a34
Nov 25 01:11:52 volcano kernel: *pde = 00000000
Nov 25 01:11:52 volcano kernel: Oops: 0000 [#1]
Nov 25 01:11:52 volcano kernel: CPU:    1
Nov 25 01:11:52 volcano kernel: EIP:   
0060:[<c0163a34>]    Not tainted
Nov 25 01:11:52 volcano kernel: EFLAGS: 00010286
Nov 25 01:11:52 volcano kernel: EIP is at
pipe_write+0x80/0x2f3
Nov 25 01:11:52 volcano kernel: eax: f6100000   ebx:
00001000   ecx: f6298e6c   edx: 00000000
Nov 25 01:11:52 volcano kernel: esi: f6cbbc80   edi:
00000000   ebp: f6298e00   esp: f6101f38
Nov 25 01:11:52 volcano kernel: ds: 007b   es: 007b  
ss: 0068
Nov 25 01:11:52 volcano kernel: Process gtbl (pid:
2774, threadinfo=f6100000 task=f780a080)
Nov 25 01:11:52 volcano kernel: Stack: 0000001d
00020002 f6101f68 f6100000 f6100000 c0350700 f6100000
f6298e6c
Nov 25 01:11:52 volcano kernel:        00000000
00001000 00000000 00000000 f6cbbc80 00000000 00000000
c0157ad8
Nov 25 01:11:52 volcano kernel:        f6cbbc80
40016000 00001000 f6cbbca0 0000000a 00000046 f6cbbc80
fffffff7
Nov 25 01:11:52 volcano kernel: Call Trace:
Nov 25 01:11:52 volcano kernel:  [<c0157ad8>]
vfs_write+0xbc/0x127
Nov 25 01:11:52 volcano kernel:  [<c0157be8>]
sys_write+0x42/0x63
Nov 25 01:11:52 volcano kernel:  [<c010b2d1>]
sysenter_past_esp+0x52/0x71
Nov 25 01:11:52 volcano kernel:
Nov 25 01:11:52 volcano kernel: Code: 8b 4a 18 85 c9
0f 84 27 02 00 00 b9 00 10 00 00 8b 42 10 89

And I'm afraid that's all the information that I have,
except that I was trying to export an NFS mount from
this machine at the time and was failing miserably. (I
suspect that this might have been because "ifconfig lo
127.0.0.1" hadn't created an entry in the routing
table... if that makes any sense?) The last entries in
my log file were:

...
Nov 25 01:05:58 volcano nfs: Starting NFS services: 
succeeded
Nov 25 01:05:58 volcano rpc.rquotad: Cannot register
service: RPC: Unable to send; errno = Invalid argument
Nov 25 01:05:58 volcano rpc.rquotad: rpc.rquotad:
unable to register (RQUOTAPROG, RQUOTAVERS, udp).
Nov 25 01:05:58 volcano nfs: rpc.rquotad startup
failed
Nov 25 01:06:45 volcano rpc.mountd: unable to register
(mountd, 1, udp).
Nov 25 01:07:37 volcano nfs: rpc.mountd shutdown
failed
Nov 25 01:07:37 volcano nfs: nfsd shutdown failed
Nov 25 01:07:37 volcano nfs: rpc.rquotad shutdown
failed
Nov 25 01:07:37 volcano nfs: Shutting down NFS
services:  succeeded
Nov 25 01:07:42 volcano nfs: Starting NFS services: 
succeeded
Nov 25 01:07:42 volcano rpc.rquotad: Cannot register
service: RPC: Unable to send; errno = Invalid argument
Nov 25 01:07:42 volcano rpc.rquotad: rpc.rquotad:
unable to register (RQUOTAPROG, RQUOTAVERS, udp).
Nov 25 01:07:42 volcano nfs: rpc.rquotad startup
failed
Nov 25 01:07:48 volcano kernel: portmap: server
localhost not responding, timed out
Nov 25 01:08:46 volcano nfs: rpc.mountd shutdown
failed
Nov 25 01:08:46 volcano nfs: nfsd shutdown failed
Nov 25 01:08:46 volcano nfs: rpc.rquotad shutdown
failed
Nov 25 01:08:46 volcano nfs: Shutting down NFS
services:  succeeded
Nov 25 01:09:32 volcano kernel: portmap: server
localhost not responding, timed out
Nov 25 01:09:38 volcano kernel: portmap: server
localhost not responding, timed out
Nov 25 01:09:38 volcano kernel: svc_destroy: no
threads for serv=f6cd5440!
Nov 25 01:10:32 volcano portmap[2756]: connect from
127.0.0.1 to unset(nfs): request from non-local host
Nov 25 01:10:32 volcano portmap[2757]: connect from
127.0.0.1 to unset(nfs): request from non-local host
Nov 25 01:10:32 volcano portmap[2758]: connect from
127.0.0.1 to unset(nfs): request from non-local host
Nov 25 01:10:38 volcano portmap[2759]: connect from
127.0.0.1 to unset(nfs): request from non-local host
Nov 25 01:10:38 volcano portmap[2760]: connect from
127.0.0.1 to unset(nfs): request from non-local host
Nov 25 01:10:38 volcano portmap[2761]: connect from
127.0.0.1 to unset(nfs): request from non-local host
Nov 25 01:11:52 volcano kernel: Unable to handle
kernel NULL pointer dereference at virtual address
00000018
...

There doesn't seem to be a ksymoops for 2.6. Is there
anything else I need to do to this oops?

Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk
