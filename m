Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUBWE1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 23:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUBWE1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 23:27:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61619 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261803AbUBWE1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 23:27:35 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Pavol Luptak <P.Luptak@sh.cvut.cz>
Date: Mon, 23 Feb 2004 15:27:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16441.33071.218049.163976@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: SW RAID5 + high memory support freezes 2.6.3 kernel
In-Reply-To: message from Pavol Luptak on Monday February 23
References: <20040223024124.GA1590@psilocybus>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 23, P.Luptak@sh.cvut.cz wrote:
> Hello,
> issue http://www.spinics.net/lists/lvm/msg10322.html could be still present
> in the current 2.6.3 kernel. I am able to repeat the conditions to halt the 
> 2.6.3 kernel (using mkfs.ext3 on RAID device):

To be fair, your subject should say that 
   SW RAID5 + high memory + loop device freezes 2.6.3 kernel
                          ^^^^^^^^^^^^^^

Would you be able to try the same tes without using "loop" in the
middle and see what happens?

The trace you sent:

> Feb 23 02:52:12 psilocybus kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
> Feb 23 02:52:12 psilocybus kernel: printing eip:
> Feb 23 02:52:12 psilocybus kernel: f9885205
> Feb 23 02:52:12 psilocybus kernel: *pde = 00000000
> Feb 23 02:52:12 psilocybus kernel: Oops: 0000 [#1]
> Feb 23 02:52:12 psilocybus kernel: CPU:    0
> Feb 23 02:52:12 psilocybus kernel: EIP:    0060:[<f9885205>]    Tainted: PF 
> Feb 23 02:52:12 psilocybus kernel: EFLAGS: 00010246
> Feb 23 02:52:12 psilocybus kernel: EIP is at make_request+0x5/0x210 [raid5]
> Feb 23 02:52:12 psilocybus kernel: eax: f10e2f2b   ebx: f6631800   ecx: f7fe9040   edx: 00001000
> Feb 23 02:52:12 psilocybus kernel: esi: 00000008   edi: c644dbc0   ebp: 025c0e08   esp: c1b8bcd0

seems to suggest that %esi is being dereferenced at make_request+0x5,
but when I disassemble my raid5.o, it doesn't.

I tried disassembling the code:

> Feb 23 02:52:12 psilocybus kernel: 
> Feb 23 02:52:12 psilocybus kernel: Code: a7 c0 09 b6 d3 db 66 06 71 67 67 d7 32 47 2a 92 23 22 ee b1 

but that just produced nonsense.

Could you 
   gdb raid5.o
   disassemble make_request

and send me the output please.

NeilBrown
