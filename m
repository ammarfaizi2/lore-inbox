Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTFDNPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTFDNPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:15:38 -0400
Received: from axion.xs4all.nl ([213.84.8.90]:12843 "EHLO axion.demon.nl")
	by vger.kernel.org with ESMTP id S262855AbTFDNPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:15:37 -0400
Date: Wed, 4 Jun 2003 15:29:06 +0200
From: Monchi Abbad <kernel@axion.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: Oops: bad: scheduling while atomic!
Message-ID: <20030604132906.GA373@axion.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While using kernel 2.5.70 I and reading from an atapi scsi-emulated cdrom,
 if i get a irq timeout and atapi reset I get the following messages:

Jun  4 15:12:30 axion kernel: bad: scheduling while atomic!
Jun  4 15:12:30 axion kernel: Call Trace: [<c011f5ec>]  [<c01297a0>]  [<c0129710>]  [<c02a756b>]  [<c0297c3a>]  [<c0297d87>]  [<c029898b>]  [<c0298b06>]  [<c02989c0>]  [<c010920d>]
Jun  4 15:12:41 axion kernel: ------------[ cut here ]------------
Jun  4 15:12:41 axion kernel: kernel BUG at kernel/timer.c:162!
Jun  4 15:12:41 axion kernel: invalid operand: 0000 [#1]
Jun  4 15:12:41 axion kernel: CPU:    0
Jun  4 15:12:41 axion kernel: EIP:    0060:[<c0128d23>]    Not tainted
Jun  4 15:12:41 axion kernel: EFLAGS: 00010082
Jun  4 15:12:41 axion kernel: eax: c17a8000   ebx: dfc39980   ecx: 3a62e8b3   edx: c06f804c
Jun  4 15:12:41 axion kernel: esi: c0288320   edi: dfc399a4   ebp: c0440c40   esp: c17a9e8c
Jun  4 15:12:41 axion kernel: ds: 007b   es: 007b   ss: 0068
Jun  4 15:12:41 axion kernel: Process scsi_eh_3 (pid: 12, threadinfo=c17a8000 task=c17c80c0)
Jun  4 15:12:41 axion kernel: Stack: dfc39980 c0288320 c06f804c 00000096 c028821b dfc399a4 c17a8000 c06f804c
Jun  4 15:12:41 axion kernel:        c0288777 c06f804c c0288320 00000032 00000000 00000008 00000177 00000000
Jun  4 15:12:41 axion kernel:        c06f804c c06f805c 00000092 dfc39980 c06f7fa0 c02888cc c06f804c 00000000
Jun  4 15:12:41 axion kernel: Call Trace: [<c0288320>]  [<c028821b>]  [<c0288777>]  [<c0288320>]  [<c02888cc>]  [<c02a766d>]  [<c0297e4e>]  [<c0297f30>]  [<c02986d7>]  [<c02989a0>]  [<c0298b06>]  [<c02989c0>]  [<c010920d>]
Jun  4 15:12:41 axion kernel: Code: 0f 0b a2 00 09 fb 3a c0 81 7f 10 6e ad 87 4b 74 09 57 e8 c6
Jun  4 15:12:42 axion kernel:  <6>note: scsi_eh_3[12] exited with preempt_count 3
Jun  4 15:12:42 axion kernel: hdc: ATAPI reset complete

After which the cdrom drive is not accessible anymore, not even when unmounting 
and remounting.

Monchi.
--
