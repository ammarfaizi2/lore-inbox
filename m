Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRRUA>; Mon, 18 Dec 2000 12:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131143AbQLRRTr>; Mon, 18 Dec 2000 12:19:47 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:25354 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130017AbQLRRTc>;
	Mon, 18 Dec 2000 12:19:32 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Dana Lacoste" <dana.lacoste@peregrine.com>
Date: Mon, 18 Dec 2000 17:48:20 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linus's include file strategy redux
CC: <linux-kernel@vger.kernel.org>, peter@cadcamlab.org
X-mailer: Pegasus Mail v3.40
Message-ID: <100879FA29DC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 00 at 10:51, Dana Lacoste wrote:
> Potential answers that have come up so far :
> 1 - /lib/modules/* directories that involve `uname -r`
>     This won't work because i might not be compiling for the `uname -r` kernel
> 2 - /lib/modules/<version>/build/include/ :
>     we could recommend that all kernel headers for all versions be put in
>     the directory with the modules as listed above.  someone doesn't like
>     the idea of symlinks (dangling symlinks ARE bad :) and someone else
> pointed
>     out that his root partition is only 30MB.  therefore this idea has flaws
>     too.
> 3 - the script (Config.make, etc) approach : several people recommended one
>     kind or another of script that could be run prior to compilation that
>     could set all the relevant variables, including one that would point to
>     where the kernel headers are, and one that would have the 'correct'
>     compile flags, etc.

How you can make sure that script will not point to non-existing directory?
With danglink symlink you can test... No, if user removes its kernel source,
he should also remove symlink. And if he does not know about symlink, it
does not matter that symlink is dangling.

> Can we get a #3 going?  I think it could really help both the cross-compile
> people and those who just want to make sure their modules are compiling in
> the 'correct' environment.  It also allows for things like 'kgcc vs. gcc' to
> be 'properly' resolved by the distribution-creator as it should be, instead of
> linux-kernel or the 3rd party module mailing lists.

You should just use /lib/modules/*/build/Makefile:

cd /lib/modules/*/build
make subdir-m=/my/dir modules

and that's all. Complete environment already here. And if you built
kernel with 'make CC=my-kernel-gcc' ? Sorry, but we cannot store all 
possible parameters of your environment. What if you built kernel
with 'PATH=/my/kernel/tools:$PATH make' ? Should we store path too?
Complete environment?

Just my 0.02 cents.
                                Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

P.S.: While we are cleaning up Makefiles, what about switching from
xxxxx-x to xxxxx_x ? Bash otherwise complains in 'make subdir-m=/my/subdir'
that 'invalid character 45 in exportstr for subdir-m' ... I know
it is late, but better now than sometime later.
                                        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
