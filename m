Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTEYUOn (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTEYUOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:14:43 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:29364
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263732AbTEYUOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:14:39 -0400
Message-ID: <3ED12727.1080907@redhat.com>
Date: Sun, 25 May 2003 13:27:19 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
   Alexander Viro <aviro@redhat.com>
Subject: oops with bk kernel as of 2003-05-25T13:00:00-07
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I get an oops at startup time:

Unable to handle kernel NULL pointer dereference at virtual address 000003fc
 printing eip:
c0226e77
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0226e77>]    Not tainted
EFLAGS: 00010246
EIP is at kobj_map+0x9b/0x137
eax: cffbdf40   ebx: 00002400   ecx: cffbe6dc   edx: 00000000
esi: 00000001   edi: 00000100   ebp: 00000024   esp: c1297f3c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1296000 task=c1295900)
Stack: 0000001c 000000d0 00000001 cffbdf40 00002400 cffbdf48 cffbe6a0
c0157a4e
       00000000 00002400 00000100 00000000 c01579c8 c01579cd cffbdf40
cffbdf40
       00000001 c01575d1 cffbdf40 00002400 00000100 c0316117 c03cdea4
00000000
Call Trace:
 [<c0157a4e>] cdev_add+0x63/0x65
 [<c01579c8>] exact_match+0x0/0x5
 [<c01579cd>] exact_lock+0x0/0x1e
 [<c01575d1>] register_chrdev+0xc6/0x10f
 [<c039ec53>] init_netlink+0x1f/0x58
 [<c039ec2e>] netlink_proto_init+0x47/0x4d
 [<c0382880>] do_initcalls+0x27/0x93
 [<c012ddc3>] init_workqueues+0xf/0x26
 [<c01050a8>] init+0x4c/0x1a8
 [<c010505c>] init+0x0/0x1a8
 [<c0108a15>] kernel_thread_helper+0x5/0xb



I looked at the code and the problem is that cdev_map == NULL when
cdev_add is called.  cdev_map is initialized in a constructor.  Maybe
the wrong order or a race...

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+0Scn2ijCOnn/RHQRAnuKAJ0dSiCceWR44y9tBDTV1M6DprpJ7ACeJ2tu
GuQRjOGRP8x7iHi4+TvjxVI=
=ydEX
-----END PGP SIGNATURE-----

