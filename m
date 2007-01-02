Return-Path: <linux-kernel-owner+w=401wt.eu-S932701AbXABJ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbXABJ2w (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 04:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbXABJ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 04:28:52 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:4516 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932701AbXABJ2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 04:28:51 -0500
Date: Tue, 2 Jan 2007 10:29:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vivek Goyal <vgoyal@in.ibm.com>,
       Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20070102102930.650db9ac.khali@linux-fr.org>
In-Reply-To: <20070102061147.GA30308@in.ibm.com>
References: <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221145922.16ee8dd7.khali@linux-fr.org>
	<1166723157.29546.281560884@webmail.messagingengine.com>
	<20061221204408.GA7009@in.ibm.com>
	<20061222090806.3ae56579.khali@linux-fr.org>
	<20061222104056.GB7009@in.ibm.com>
	<20070101223913.7b1fddbf.khali@linux-fr.org>
	<20070102061147.GA30308@in.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Tue, 2 Jan 2007 11:41:47 +0530, Vivek Goyal wrote:
> Segher had suggested to use .section command to specifically mark
> .text.head section as AX (allocatable and executable) to solve the
> problem.
> 
> Can you please try the attached patch to see if it solves your
> problem.
> 
> Thanks
> Vivek
> 
> 
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---
> 
>  arch/i386/boot/compressed/head.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/i386/boot/compressed/head.S~jean-reboot-issue-fix arch/i386/boot/compressed/head.S
> --- linux-2.6.20-rc2-reloc/arch/i386/boot/compressed/head.S~jean-reboot-issue-fix	2007-01-02 09:54:56.000000000 +0530
> +++ linux-2.6.20-rc2-reloc-root/arch/i386/boot/compressed/head.S	2007-01-02 09:57:46.000000000 +0530
> @@ -28,7 +28,7 @@
>  #include <asm/page.h>
>  #include <asm/boot.h>
>  
> -.section ".text.head"
> +.section ".text.head","ax",@progbits
>  	.globl startup_32
>  
>  startup_32:
> _

Yes! The patch above fixes the problem, and doesn't appear to cause any
regression on my other systems. Thanks Vivek and Segher!

I guess we now want to push this patch upstream rather sooner than
later, and at any rate before 2.6.20 final is released. Eric, can you
please review the patch, and if it looks OK to you, sign it and send it
to Linus?

Thanks,
-- 
Jean Delvare
