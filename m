Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUJYVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUJYVZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUJYVZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:25:34 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:43445 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S261982AbUJYVYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:24:49 -0400
Date: Mon, 25 Oct 2004 14:24:19 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
To: john cooper <john.cooper@timesys.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1
In-Reply-To: <417BEDB7.6050403@timesys.com>
Message-ID: <Pine.LNX.4.61.0410251332560.25267@ghostwheel.llnl.gov>
References: <20041022032039.730eb226.akpm@osdl.org>
 <Pine.LNX.4.61.0410221515060.25447@ghostwheel.llnl.gov> <417BEDB7.6050403@timesys.com>
Organization: Lawrence Livermore National Laboratory
User-Agent: Pine/4.61 (X11; U; Linux i686; en-US; rv:2.6.9-rc1-mm4)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004, john cooper wrote:

> This appears a result of changes in:
>
>   arch/i386/kernel/vmlinux.lds.S
>
> which causes the kernel start address to
> change from 0xc0100000 to 0x100000 causing
> objcopy to gag.  I rolled back to a 2.6.8.1
> version of the above linker map file and did
> get the kernel to build and [mostly] boot.
> However it incorporated Ingo's RT patches and
> wasn't exactly a vanilla 2.6.9-mm1.
>
> While I don't recommend the above as a fix,
> a repeat of the experiment will require adding
> the following to the linker text section:
>
> --- /user1/linux/linux-2.6.8.1/arch/i386/kernel/vmlinux.lds.S   2004-08-14 
> 06:54:51.000000000 -0400
> +++ 
> /user1/linux/ingo-preempt/linux-2.6.9-Ux/linux-2.6.9/arch/i386/kernel/vmlinux.lds.S 
> 2004-10-24 13:11:52.000000000 -0400
> @@ -17,6 +17,7 @@
>  .text : {
>       *(.text)
>       SCHED_TEXT
> +       LOCK_TEXT
>       *(.fixup)
>       *(.gnu.warning)
>       } = 0x9090
>
>
>

I tried patching vmlinux.lds.S using the above patch and it failed.
Looking at the file shows the LOCK_TEXT line is already in the file.

After reading the dialog between Remi Colinet and Vivek Goyal regarding
the same problem, my next step is to update the binutils to the latest
version. AHA! It looks as though RHEL 3.3 WS up2date downreved binutils
to 2.14.90.0.4 and the latest GNU version is 2.15 so reinstalling it is
in order, which has fixed the build problem. Next step, adventures in
booting B-|

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate      ICCD/SDD/ICRMG     Fax: 925-423-8719
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
-- I've got a mind like a.. a.. what's that thing called? --
