Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271162AbRHUCWD>; Mon, 20 Aug 2001 22:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271189AbRHUCVx>; Mon, 20 Aug 2001 22:21:53 -0400
Received: from rj.SGI.COM ([204.94.215.100]:36030 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271162AbRHUCVp>;
	Mon, 20 Aug 2001 22:21:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: leroyljr@ccsi.com, linux-kernel@vger.kernel.org
Subject: Re: Failure to Compile AIC7xxx Driver 
In-Reply-To: Your message of "Thu, 16 Aug 2001 19:04:12 CST."
             <200108170104.f7H14CI83159@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 12:21:43 +1000
Message-ID: <18449.998360503@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001 19:04:12 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>>aicasm/aicasm_scan.l: In function `yylex':
>>aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this function)
>>aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only once
>I tried to reproduce this locally, but was never able to do so.  My
>best guess is that the default rules for building lex/yacc grammers don't
>include proper dependencies for the generated y.tab.h file.  Of course,
>it shouldn't be necessary.  Both aicasm_gram.y and aicasm_scan.l should
>have newer dates than the y.tab.h file from a previous build (both are
>updated for 2.4.9) and aicasm_gram.c is listed first in the dependency
>line, so yacc should have already been run prior to the compilation of
>aicasm_scan.c.
>
>Perhaps a make guru can lend some insight?

I have repeatedly offered to fix the aic7xxx and aicasm makefiles but
you have refused to let me.  See the thread that ended in
http://marc.theaimsgroup.com/?l=linux-kernel&m=99353014629653&w=2

You have hit the precise problem that I raised in that thread, you
cannot rely on timestamps for files that are both generated and
shipped.  aic7xxx is not the only system that has this problems but
other maintainers accept that I know the kbuild system better than they
do.  I have fixed the problem in kbuild 2.5 for all generated files
_except_ for aic7xxx.  Until you accept that your makefiles are
incorrect and do not fit the Linux kernel build model, I have no
intention of doing any more work on aic7xxx.

Keith Owens, Linux kernel build maintainer.

