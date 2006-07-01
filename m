Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWGAVR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWGAVR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWGAVR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:17:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23528 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932632AbWGAVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:17:57 -0400
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:
	undefined reference to `__stack_chk_fail'
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 23:17:53 +0200
Message-Id: <1151788673.3195.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 14:09 -0700, Miles Lane wrote:
> I am getting this:
> 
>   KLIBCLD usr/klibc/libc.so
> usr/klibc/execl.o: In function `execl':
> usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> usr/klibc/execle.o: In function `execle':
> usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> usr/klibc/execvpe.o: In function `execvpe':
> usr/klibc/execvpe.c:75: undefined reference to `__stack_chk_fail'
> usr/klibc/execlp.o: In function `execlp':
> usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> usr/klibc/execlpe.o: In function `execlpe':
> usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
> usr/klibc/vfprintf.o:usr/klibc/vfprintf.c:26: more undefined
> references to `__stack_chk_fail' follow
> make[2]: *** [usr/klibc/libc.so] Error 1
> 
> But I've searched all the .h and .c files in the tree and found no
> reference to __stack_chk_fail.  I am running Ubuntu's Edgy Eft (the
> latest development tree).

somehow you're getting -fstack-protector added to your CFLAGs.. which
won't do you any good unless you link to glibc or another library that
implements the user side of the feature...


