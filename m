Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUFVF2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUFVF2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 01:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUFVF2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 01:28:37 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:35202 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S266486AbUFVF2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 01:28:33 -0400
Message-ID: <40D7C3D3.30DB5F72@users.sourceforge.net>
Date: Tue, 22 Jun 2004 08:29:55 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org> <20040620221824.GA10586@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Jun 21, 2004 at 12:03:19AM +0200, Sam Ravnborg wrote:
> > If I get just one good example I will go for the object directory, but
> > what I have seen so far is whining - no examples.
> 
> Now I recall why I did not like the object directory.
> I will break all modules using the kbuild infrastructure!

No it does not. If 'export KBUILD_OUTPUT=/foo' command is used used before
kernel is built, it is not any more difficult to compile external modules
with that same env variable defined.

> Why, because there is no way the to find the output directory except
> specifying both directories.
> One could do:
> make -C /lib/modules/`uname -r`/source O=/lib/modules/`uname -r`/build M=`pwd`
> 
> So the currect choice is:
> 1) Break modules that actually dive into the src, grepping, including or whatever
> 2) Break all modules using kbuild infrastructure, including the above ones

or 3) Add the missing object symlink. It does not break anything.

If and when external module build scripts are updated to automatically
detect the /lib/modules/`uname -r`/object symlink, users can even unset the
KBUILD_OUTPUT= env variable and external modules will still compile ok.

> I go for 1), introducing minimal breakage.

You seem to be in some strange "I must destroy... I must destroy... I must
destroy..." mental state. There is a no-breakage alternative and you just
will not consider that at all.

> If kernels are shipped with separate source and output then we better break
> as few modules as possible. And the introduced change actually minimize breakage.

Nope. Solution #3 is the minimal breakage solution.

> So the patch will not change.

In which case Andrew and Linus should consider revoking your kbuild
maintainer status. I moved Andrew and Linus from CC list to TO list in hope
to get this small question answered:

Andrew, Linus,
How about choosing someone else less destructive to maintain kbuild?

> See the following table:
> 
>                                           Current kbuild                With patch
> simple module, no grepping
> kernel source + output mixed                  OK                           OK
> 
> simple module, no grepping
> kernel source separate from output            FAIL *1                      OK
> 
> module grepping in src
> kernel source + output mixed                  OK                           OK
> 
> module grepping in src
> kernel source separate from output            FAIL *2                      FAIL *3
> 
> FAIL *1 Module cannot build because it fails to locate the compiled files used for kbuild.
>         Also the kernel configuration is missing.

Same 'export KBUILD_OUTPUT=/foo' will work the same for kernel build and
external module build. Your "FAIL *1" is bogus.

> FAIL *2 Same as FAIL *1. Module cannot build because kbuild compiled files are missing and
>         it cannot access kernel configuration.
>         Also it fails to locate files when grepping.

Same 'export KBUILD_OUTPUT=/foo' will work the same for kernel build and
external module build. Your "FAIL *2" is also bogus.

> FAIL *3 Grep will fail because it try to grep in files located under build/

Yep.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
