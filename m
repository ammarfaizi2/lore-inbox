Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUJDWrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUJDWrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUJDWrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:47:33 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:49793 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268591AbUJDWr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:47:27 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: William Knop <wknop@andrew.cmu.edu>
Date: Tue, 5 Oct 2004 08:47:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16737.54003.419130.575839@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: message from William Knop on Monday October 4
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 4, wknop@andrew.cmu.edu wrote:
> CPU:    0
> EIP:    0060:[<229e4d8c>]    Not tainted
> EFLAGS: 00010206   (2.6.8-1.521)
> EIP is at handle_stripe+0x29a/0x1407 [raid5]
> eax: 00000001   ebx: 00000000   ecx: 00915cb8   edx: 21f7e1c0
> esi: 1ccbd118   edi: 21f7e1c0   ebp: 01000000   esp: 1d300f28
> ds: 007b   es: 007b   ss: 0068
> Process md0_raid5 (pid: 2626, threadinfo=1d300000 task=1d317970)
> Stack: 2283eb57 20db8000 21f7e1c0 21c30288 1ccbd204 20db8000 00000001 
> 1ccbd158
>         00000002 00000000 00000000 00000001 00000000 00000000 00000001 
> 00000000
>         00000001 00000001 00000000 00000003 1ccbd0ac 21f7e1c0 1ccbd0ac 
> 21f76c00
> Call Trace:
>   [<2283eb57>] ata_scsi_queuecmd+0xbe/0xc7 [libata]
>   [<229e6b1c>] raid5d+0x1ce/0x2f8 [raid5]
>   [<0228f5d2>] md_thread+0x227/0x256
>   [<0211be05>] autoremove_wake_function+0x0/0x2d
>   [<0211be05>] autoremove_wake_function+0x0/0x2d
>   [<0228f3ab>] md_thread+0x0/0x256
>   [<021041d9>] kernel_thread_helper+0x5/0xb
> Code: 8b 55 04 83 c1 08 8b 45 00 83 d3 00 39 da 72 0e 0f 87 e0 01

This code starts:

   0:   8b 55 04                  mov    0x4(%ebp),%edx
   3:   83 c1 08                  add    $0x8,%ecx

and as %ebp is 01000000, this oopses.  
It looks very much like a single-bit memory error (as has already been
suggested as a possibility).

NeilBrown
