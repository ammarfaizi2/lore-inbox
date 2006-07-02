Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWGBEF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWGBEF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 00:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWGBEF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 00:05:27 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:45151 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932205AbWGBEF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 00:05:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AqzkYp6A9tqwV+CqkEeD8jweFxaJaa+x8VQG1+pgVrCQgq9yIcpQAXKKNbszoK+e/ssNAwZvgK5CTdy4iuSlTKGxGW1SlaJOmMvoW+C39quNAA4HgZ6R+qTs1qIhGLPpQyAPcPeiaIjEpodutQCosWlycRE9HNY5/d/T1b+KJFE=
Message-ID: <a44ae5cd0607012105g23a22e67ma3fd2bdd7c9352a4@mail.gmail.com>
Date: Sat, 1 Jul 2006 21:05:26 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44A73790.5030006@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
	 <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>
	 <20060701230635.GA19114@mars.ravnborg.org>
	 <44A706C4.7070908@zytor.com> <20060702030121.GA7247@mars.ravnborg.org>
	 <44A73790.5030006@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Sam Ravnborg wrote:
> >
> >> -KLIBCREQFLAGS     :=
> >> +KLIBCREQFLAGS     := $(call cc_option, -fno-stack-protector, )
> >
> > This needs to be $(call cc-option, ...)
> > '-' not '_'.
> >
>
> *plonk* OK... I feel dumb now :)
>
> Miles: could you try this out?
>
> >> +++ b/usr/klibc/arch/arm/MCONFIG
> >> @@ -12,7 +12,7 @@ CPU_TUNE := strongarm
> >>
> >>  KLIBCOPTFLAGS = -Os -march=$(CPU_ARCH) -mtune=$(CPU_TUNE)
> >>  KLIBCBITSIZE  = 32
> >> -KLIBCREQFLAGS = -fno-exceptions
> >> +KLIBCREQFLAGS += -fno-exceptions
> >
> > This should be fixed for KLIBCOPTFLAGS also. Unrelated to this issue.
> >
>
> *Nod.*

I gave it my best shot, but my build is still unhappy.
I set:
KLIBCREQFLAGS     :=  $(call cc-option, -fno-stack-protector, )
in scripts/Kbuild.klibc.

KLIBCOPTFLAGS     = -march=i386 -Os -g -fomit-frame-pointer
$(gcc_align_option) $(call cc-option, -fno-stack-protector, )
in usr/klibc/arch/i386/MCONFIG

CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                   $(call cc-option, -fno-stack-protector, ) -fno-common
in Makefile.

Trying to compile, I get:

include/asm/system.h: In function '__set_64bit_var':
include/asm/system.h:209: warning: dereferencing type-punned pointer
will break strict-aliasing rules
