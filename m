Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFCDLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFCDLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 23:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFCDLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 23:11:52 -0400
Received: from host-148-244-76-242.block.alestra.net.mx ([148.244.76.242]:16787
	"EHLO gr13v0u5.icontrol.com.mx") by vger.kernel.org with ESMTP
	id S261223AbVFCDLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 23:11:46 -0400
Subject: Re: PROBLEM: doing a dd to a dbfile
From: "Ing." =?ISO-8859-1?Q?Ra=FAl?= Alvarez Aguileta 
	<l0rd4gu1@icontrol.com.mx>
Reply-To: l0rd4gu1@icontrol.com.mx
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <429F5BB6.90301@suse.com>
References: <1117673999.28282.2.camel@localhost>  <429F5BB6.90301@suse.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Red de Control Corporativo
Date: Thu, 02 Jun 2005 22:16:28 -0500
Message-Id: <1117768588.12719.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff

Thanks for the help, i've published the image at:

http://egw.servebeer.com/vmlinux.bz2


Thanks & Regards

-- 
Ing. Raúl Alvarez Aguileta <l0rd4gu1@icontrol.com.mx>
Red de Control Corporativo

On Thu, 2005-06-02 at 15:19 -0400, Jeff Mahoney wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ing. Raúl Alvarez Aguileta wrote:
> > Hi
> > 
> > I've a corruption problem with one innodb file, when i'm trying to
> > recover a corrupted file (it's filled with no data at byte 524288+, but
> > it have valid info later [aprox 4mb ahead] ) with:
> > 
> > # dd if=/dev/zero of=ibdata1 bs=1 seek=524288 count=4194304 conv=notrunc
> > 
> > the command ends dumping the folllowing message:
> > 
> > output from /var/log/messages
> > ---->
> > Jun  1 18:43:07 g4nd4lf Kernel BUG at file:534
> > Jun  1 18:43:07 g4nd4lf invalid operand: 0000 [1] SMP
> > Jun  1 18:43:07 g4nd4lf CPU 0
> > Jun  1 18:43:07 g4nd4lf Modules linked in: ipt_LOG ipt_state
> > iptable_filter ip_tables ip_conntrack_tftp ip_conntrack_irc
> > ip_conntrack_ftp ip_conntrack_amanda ip_conntrack amd74xx sd_mod aic79xx
> > mptctl mptscsih mptbase sata_sx4 sata_promise libata usb_storage
> > ide_core scsi_mod ohci_hcd uhci_hcd ehci_hcd usbcore
> > Jun  1 18:43:07 g4nd4lf Pid: 8993, comm: dd Not tainted 2.6.11-gentoo-r9
> > Jun  1 18:43:07 g4nd4lf RIP: 0010:[<ffffffff801a9372>]
> > <ffffffff801a9372>{reiserfs_file_write+5298}
> > Jun  1 18:43:07 g4nd4lf RSP: 0018:ffff81007c273ba8  EFLAGS: 00010246
> > Jun  1 18:43:08 g4nd4lf RAX: 0000000001000020 RBX: 0000000000000000 RCX:
> > 0000000000000001
> > Jun  1 18:43:08 g4nd4lf RDX: ffff810002b04038 RSI: ffff81007c26e670 RDI:
> > ffff81007c273d98
> > Jun  1 18:43:08 g4nd4lf RBP: ffff81007e8bbdf0 R08: 0000000000000000 R09:
> > ffff810002c13c80
> > Jun  1 18:43:08 g4nd4lf R10: ffff81007fdd8ec0 R11: ffff81007e8bbdf0 R12:
> > 0000000000000001
> > Jun  1 18:43:08 g4nd4lf R13: 0000000000000000 R14: ffff81007c26e670 R15:
> > ffff81007e8c0678
> > Jun  1 18:43:08 g4nd4lf FS:  00002aaaaade7b00(0000)
> > GS:ffffffff803ed880(0000) knlGS:0000000000000000
> > Jun  1 18:43:08 g4nd4lf CS:  0010 DS: 0000 ES: 0000 CR0:
> > 000000008005003b
> > Jun  1 18:43:08 g4nd4lf CR2: 00002aaaaac4d3e0 CR3: 000000007c267000 CR4:
> > 00000000000006e0
> > Jun  1 18:43:08 g4nd4lf Process dd (pid: 8993, threadinfo
> > ffff81007c272000, task ffff81007f6fa1b0)
> > Jun  1 18:43:08 g4nd4lf Stack: 0000000000000286 ffff81000000d680
> > 0000000000000000 ffff81007c26e730
> > Jun  1 18:43:08 g4nd4lf 0000000100000000 000000000008cfff
> > 00000000000080d2 0000000000000000
> > Jun  1 18:43:08 g4nd4lf 0000000000000000 0000000000000001
> > Jun  1 18:43:08 g4nd4lf Call Trace:<ffffffff80145f9e>{buffered_rmqueue
> > +654} <ffffffff801527ab>{do_no_page+939}
> > Jun  1 18:43:08 g4nd4lf <ffffffff8010de4d>{error_exit+0}
> > <ffffffff8018b88f>{inotify_inode_queue_event+47}
> > Jun  1 18:43:08 g4nd4lf <ffffffff801f1160>{read_zero+480}
> > <ffffffff80164669>{vfs_write+233}
> > Jun  1 18:43:08 g4nd4lf <ffffffff801647f3>{sys_write+83}
> > <ffffffff8010d44a>{system_call+126}
> > Jun  1 18:43:08 g4nd4lf
> > Jun  1 18:43:08 g4nd4lf
> > Jun  1 18:43:08 g4nd4lf Code: 0f 0b 8b f1 2d 80 ff ff ff ff 16 02 8b 02
> > 4c 8b 42 10 f6 c4
> > Jun  1 18:43:08 g4nd4lf RIP <ffffffff801a9372>{reiserfs_file_write+5298}
> > RSP <ffff81007c273ba8>
> > <----
> > 
> > # sh /usr/src/linux/scripts/ver_linux
> > ---->
> > If some fields are empty or look unusual you may have an old version.
> > Compare to the current minimal requirements in Documentation/Changes.
> > 
> > Linux g4nd4lf 2.6.11-gentoo-r9 #1 SMP Wed May 18 07:53:38 CDT 2005
> > x86_64 AMD Opteron(tm) Processor 250 AuthenticAMD GNU/Linux
> 
> Ok, this trace maps to page_buffers() in
> reiserfs_allocate_blocks_for_region(), specifically the BUG_ON
> (!PagePrivate(page)) check inside it. Somehow, the buffers associated
> with that page are getting freed, despite it being locked.
> 
> Just to double check that the page it's checking is valid - could you
> post your vmlinux somewhere or send it to me off list? I'd like to check
> the Oops against the disassembly.
> 
> - -Jeff
> 
> - --
> Jeff Mahoney
> SuSE Labs
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.0 (GNU/Linux)
> 
> iD8DBQFCn1u2LPWxlyuTD7IRAtipAJ0dnkRURMCvDVi7BsqCLB3PKTRlXACfXXip
> nREAY313itZta85HPacCSKc=
> =4U9c
> -----END PGP SIGNATURE-----


