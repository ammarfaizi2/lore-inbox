Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSH0FJf>; Tue, 27 Aug 2002 01:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSH0FJf>; Tue, 27 Aug 2002 01:09:35 -0400
Received: from holomorphy.com ([66.224.33.161]:20642 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313113AbSH0FJf>;
	Tue, 27 Aug 2002 01:09:35 -0400
Date: Mon, 26 Aug 2002 22:11:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] softirq.c races on TASKLET_STATE_SCHED
Message-ID: <20020827051126.GA11908@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of bugfixes were attempted here, so the line numbers are munged,
but they made no difference as to where the BUG() occurred.

Cheers,
Bill


#0  tasklet_hi_action (a=0xc032dd60) at softirq.c:235
#1  0xc011ecda in do_softirq () at softirq.c:89
#2  0xc0109b85 in do_IRQ (regs=
      {ebx = -164215104, ecx = -164215104, edx = -144014328, esi = 32, edi = -144005092, ebp = -184213984, eax = -164358401, xds = -144048024, xes = -164233112, orig_eax = -256, eip = -1071799089, xcs = 96, eflags = 646, esp = -144005092, xss = -251088608}) at irq.c:393
#3  0xc0108214 in common_interrupt () at process.c:983
#4  0xc01da5df in generic_make_request (bio=0xf108b120) at ll_rw_blk.c:1714
#5  0xc01da65c in submit_bio (rw=1, bio=0xf108b120) at ll_rw_blk.c:1760
#6  0xc0161721 in mpage_bio_submit (rw=1, bio=0xf108b120) at mpage.c:93
#7  0xc01620b4 in mpage_writepages (mapping=0xf580ebbc, nr_to_write=0x0, 
    get_block=0xc0171ea0 <ext2_get_block>) at mpage.c:440
#8  0xc0172300 in ext2_writepages (mapping=0xf580ebbc, nr_to_write=0x0)
    at inode.c:636
#9  0xc0140a3a in do_writepages (mapping=0xf580ebbc, nr_to_write=0x0)
    at page-writeback.c:372
#10 0xc012f368 in filemap_fdatawrite (mapping=0xf580ebbc) at filemap.c:497
#11 0xc0145ab3 in sys_fsync (fd=6) at buffer.c:310
#12 0xc01078cf in syscall_call () at process.c:983
#13 0x0804affd in ?? ()
#14 0x08049813 in ?? ()
#15 0x4001dfa5 in ?? ()

