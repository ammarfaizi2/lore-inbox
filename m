Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSFDS3j>; Tue, 4 Jun 2002 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFDS3i>; Tue, 4 Jun 2002 14:29:38 -0400
Received: from h00045ad915fa.ne.client2.attbi.com ([24.60.112.15]:19661 "HELO
	frank.mercea.net") by vger.kernel.org with SMTP id <S315870AbSFDS3d>;
	Tue, 4 Jun 2002 14:29:33 -0400
Mime-Version: 1.0
Message-Id: <a05111705b922b09b689a@[10.1.0.123]>
Date: Tue, 4 Jun 2002 14:30:07 -0400
To: linux-kernel@vger.kernel.org
From: Brett Dikeman <brett@cloud9.net>
Subject: 2.4.18 assertion failure in journal_commit_transaction
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all.

I'm helping a company which just installed Redhat 7.3 on several 
systems(Compaq dl380G2, dual proc systems.)  They are running the smp 
kernel that came with the distro(versioned 2.4.18-3; -4 is out, but I 
reviewed the changelogs and it didn't look like they did anything 
that would affect this problem, but I really couldn't tell.)  ext3 
for all filesystems, hardware raid 0+1 via the Compaq controller.

   All was going well until one of the boxes(none are really "in use" 
yet) stopped responding.  We found the following in the logs - names 
changed to protect innocent :-)


Jun  3 12:40:31 abox kernel: Assertion failure in 
journal_commit_transaction() at commit.c:535: "buffer_jdirty
(bh)"
Jun  3 12:40:31 abox kernel: ------------[ cut here ]------------
Jun  3 12:40:31 abox kernel: kernel BUG at commit.c:535!
Jun  3 12:40:31 abox kernel: invalid operand: 0000
Jun  3 12:40:31 abox kernel: ide-cd cdrom autofs eepro100 usb-ohci 
usbcore ext3 jbd cciss sd_mod scsi_mod
Jun  3 12:40:31 abox kernel: CPU:    0
Jun  3 12:40:31 abox kernel: EIP:    0010:[<f88400e4>]    Not tainted
Jun  3 12:40:31 abox kernel: EFLAGS: 00010286
Jun  3 12:40:31 abox kernel:
Jun  3 12:40:31 abox kernel: EIP is at journal_commit_transaction 
[jbd] 0xb04 (2.4.18-3smp)
Jun  3 12:40:31 abox kernel: eax: 0000001c   ebx: 0000000a   ecx: 
c02eee60   edx: 000034c3
Jun  3 12:40:31 abox kernel: esi: f77f0dc0   edi: f754cea0   ebp: 
f7552000   esp: f7553e78
Jun  3 12:40:31 abox kernel: ds: 0018   es: 0018   ss: 0018
Jun  3 12:40:31 abox kernel: Process kjournald (pid: 16, stackpage=f7553000)
Jun  3 12:40:31 abox kernel: Stack: f8846eee 00000217 f7552000 
00000000 00000fa4 f00bf05c 00000000 f64c6f20
Jun  3 12:40:31 abox kernel:        ef205ac0 000013ed 37363534 
42413938 46454443 4a494847 f00fdf60 eeab8c20
Jun  3 12:40:31 abox kernel:        eeab8aa0 eeab8b00 eead8f20 
eeab9a20 eead8500 eeab8a40 eea7bde0 eeab8a40
Jun  3 12:40:31 abox kernel: Call Trace: [<f8846eee>] .rodata.str1.1 
[jbd] 0x26e
Jun  3 12:40:31 abox kernel: [<c0119048>] schedule [kernel] 0x348
Jun  3 12:40:31 abox kernel: [<f88427d6>] kjournald [jbd] 0x136
Jun  3 12:40:31 abox kernel: [<f8842680>] commit_timeout [jbd] 0x0
Jun  3 12:40:31 abox kernel: [<c0107286>] kernel_thread [kernel] 0x26
Jun  3 12:40:31 abox kernel: [<f88426a0>] kjournald [jbd] 0x0
Jun  3 12:40:31 abox kernel:
Jun  3 12:40:31 abox kernel:
Jun  3 12:40:31 abox kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 
56 e8 4b f1 ff ff 8d 47 48

So far this has been an isolated incident(only 1 of 7-8 systems, only 
1 crash), but the concern is that it never should have happened in 
the first place; they've only been up for about a week so far :-)

Unfortunately I cannot offer access to the system for someone to play 
with the box directly(sorry..I'd love to, but it can't be 
done)...however, I'd be happy to play proxy and provide additional 
information(left this post minimal because I wasn't sure what info 
-would- help) or try things for someone.  If there's anything I can 
do, please ask.

Please cc me on all replies(not on the list.)

Thanks!
Brett
-- 
----
"They that give up essential liberty to obtain temporary
safety deserve neither liberty nor safety." - Ben Franklin
