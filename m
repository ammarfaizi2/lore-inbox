Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVBDUid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVBDUid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbVBDUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:38:32 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:8661 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262737AbVBDUaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:30:16 -0500
Date: Fri, 4 Feb 2005 20:29:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Mr. Berkley Shands" <berkley@exegy.com>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 Kernel BUG at hugetlbpage:212 (x86_64 and i386)
In-Reply-To: <4203D5AD.8030108@cse.wustl.edu>
Message-ID: <Pine.LNX.4.61.0502042011240.11692@goblin.wat.veritas.com>
References: <42023352.9040309@dssimail.com> 
    <Pine.LNX.4.61.0502041634090.10535@goblin.wat.veritas.com> 
    <20050204194255.GO24805@holomorphy.com> <4203D5AD.8030108@cse.wustl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Mr. Berkley Shands wrote:
> > 
> Sorry, but I still crash. This time it hung the kernel so bad I had to
> powerfail to restart.

Thanks for trying, okay, your problem is a different one from
what my patch fixes: I thought that might turn out to be so.

> Feb  4 13:43:19 eclipse kernel: Kernel BUG at hugetlbpage:212
> Feb  4 13:43:19 eclipse kernel: invalid operand: 0000 [1] SMP
> Feb  4 13:43:19 eclipse kernel: CPU 1
> Feb  4 13:43:19 eclipse kernel: Modules linked in:
> Feb  4 13:43:19 eclipse kernel: Pid: 1374, comm: DssiEPSearch Not tainted
> 2.6.10
> <ffffffff8011e3cb>{unmap_hugepage_range+75} RSP <000001007f337dd8>
> 
> patch applied and rebooted (I made sure this time :-)

And kernel rebuilt, I trust!

> unless of course I'm not functional today :-)
> The patch I had was for mmap.c, not in hugetlb.c. Did I miss something?

No, that's right, it was only fixing mm/mmap.c.

Please point me privately to your app source, oh, it may be gigantic,
or difficult for me to compile, I guess your binary as well or instead:
so I can try to reproduce on i386.

We notice fpga_read and fpga_ioctl in both your traces, not in our
2.6.10 kernel source: just leftover addresses on the stack, not part
of the real backtrace, but interestingly there in both.  Where are
they from (FC3?), any idea what chance it's doing something bad?

Hugh
