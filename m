Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269308AbRHQBE3>; Thu, 16 Aug 2001 21:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269334AbRHQBET>; Thu, 16 Aug 2001 21:04:19 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:29968 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269308AbRHQBEK>; Thu, 16 Aug 2001 21:04:10 -0400
Message-Id: <200108170104.f7H14CI83159@aslan.scsiguy.com>
To: leroyljr@ccsi.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Failure to Compile AIC7xxx Driver 
In-Reply-To: Your message of "Thu, 16 Aug 2001 19:15:38 CDT."
             <200108170013.f7H0DoO21290@ccsi.com> 
Date: Thu, 16 Aug 2001 19:04:12 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If nobody has brought this up yet, I want to report this issue.
>
>Here is what happened when I tried to build the aic7xxx driver for 2.4.9:
>
>aicasm/aicasm_scan.l: In function `yylex':
>aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this function)
>aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only once
>aicasm/aicasm_scan.l:115: for each function it appears in.)
>aicasm/aicasm_scan.l:132: `T_STRING' undeclared (first use in this function)
>
>This is for the new driver, BTW.

I tried to reproduce this locally, but was never able to do so.  My
best guess is that the default rules for building lex/yacc grammers don't
include proper dependencies for the generated y.tab.h file.  Of course,
it shouldn't be necessary.  Both aicasm_gram.y and aicasm_scan.l should
have newer dates than the y.tab.h file from a previous build (both are
updated for 2.4.9) and aicasm_gram.c is listed first in the dependency
line, so yacc should have already been run prior to the compilation of
aicasm_scan.c.

Perhaps a make guru can lend some insight?

If you manually go into drivers/scsi/aic7xxx/aicasm and do a make clean, the
error should go away.

Of course, you could just disable the build of the firmware in your
kernel config...

--
Justin
