Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276648AbRJGX3I>; Sun, 7 Oct 2001 19:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276647AbRJGX27>; Sun, 7 Oct 2001 19:28:59 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32531 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276641AbRJGX2s>;
	Sun, 7 Oct 2001 19:28:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles 
In-Reply-To: Your message of "Sun, 07 Oct 2001 13:16:19 EST."
             <Pine.LNX.3.96.1011007131234.26881H-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 09:29:06 +1000
Message-ID: <27710.1002497346@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001 13:16:19 -0500 (CDT), 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>On Sun, 7 Oct 2001, Andrea Arcangeli wrote:
>
>> On Sun, Oct 07, 2001 at 08:25:42PM +1000, Keith Owens wrote:
>> > in the top level Makefile forces a recompile of the entire kernel, for
>> > no good reason.
>> 
>> this is a matter of taste but personally I believe that at least
>> theorically recompiling the whole kernel if I add -g to CFLAGS, or if I
>> change the EXTRAVERSION have lots of sense.
>
>Correct.  I am amazed Keith missed this...  changing data in Makefile
>can certainly affect the entire kernel compile, so it makes sense to
>recompile the entire kernel when it changes.

I did not miss it.  Changing cflags is detected by the
.<object>.o.flags files.

ifeq (-D__KERNEL__ -I/build/kaos/2.4.11-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586,$(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_vt.o))))
FILES_FLAGS_UP_TO_DATE += vt.o
endif

kbuild already detects changes to flags, down to the level of
per-object flags, there is no need to detect changes to the top level
Makefile.  Especially when you can override flags and other fields on
the make command line, that does not change Makefile but kbuild still
detects the changes.

