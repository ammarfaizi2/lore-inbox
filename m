Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTI2OSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTI2OSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:18:31 -0400
Received: from mail.zmailer.org ([62.197.173.195]:25220 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S263383AbTI2OSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:18:25 -0400
Date: Mon, 29 Sep 2003 17:18:20 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Artur Klauser <Artur.Klauser@computer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: div64.h:do_div() bug
Message-ID: <20030929141820.GE1058@mea-ext.zmailer.org>
References: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 03:25:19PM +0200, Artur Klauser wrote:
> I've found that a bug in asm-arm/div64.h:do_div() is preventing correct
> conversion of timestamps in smbfs (and probably ntfs as well) from NT to
> Unix format. I'll post a patch that fixes the bug, but I think it is also
> present in other architectures - at least SPARC, SH, and CRIS look
> suspicious.
> 
> If people with access to these architectures could run the following small 
> test and let me know the outcome, I can fix it there too - thanks.

Call it "lack/lazyness of implementation"

Long ago it was used only in  printk()  debug printouts.
Now it is used all over the place.  At least its users are aware of
it being slow, and not just using GCC's magic bultin codes.


> //-----------------------------------------------------------------------------
> #define __KERNEL__
> #include <asm/types.h> // get kernel definition of u64, u32
> #undef __KERNEL__
> #include <asm/div64.h> // get definition of do_div()
> #include <stdio.h>
> 
> main () {
>   union {
>     u64 n64;
>     u32 n32[2];
>   } in, out;
> 
>   in.n32[0] = 1;
>   in.n32[1] = 1;
>   out = in;
> 
>   do_div(out.n64, 1);
> 
>   if (in.n64 != out.n64) {
>     printf("FAILURE: asm/div64.h:do_div() is broken for 64-bit dividends\n");
>     exit(1);
>   } else {
>     printf("Congratulations: asm/div64.h:do_div() handles 64-bit dividends\n");
>   }
>   return 0;
> }
