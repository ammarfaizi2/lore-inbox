Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSACXPp>; Thu, 3 Jan 2002 18:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288375AbSACXPg>; Thu, 3 Jan 2002 18:15:36 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58065 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288374AbSACXP3>; Thu, 3 Jan 2002 18:15:29 -0500
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files (maintainers pls read this)
In-Reply-To: <02010216180403.01928@manta> <3C340EA9.FE084B4C@zip.com.au>
	<20020103095742.A11443@flint.arm.linux.org.uk>
	<200201032028.g03KSsE29484@Port.imtp.ilyichevsk.odessa.ua>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 04 Jan 2002 00:14:54 +0100
Message-ID: <87zo3vyqkx.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"vda@port.imtp.ilyichevsk.odessa.ua"  <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> And this method is traditional for C. We have struct declarations and fn 
> propotypes in *.h, we should place extern vars there too. Always.

Agreed.

> If you are a kernel subsystem or driver maintainer, you may wish to check 
> whether *your* part of kernel has any extern variable defs. Just run this
> hunter script in top dir of kernel source:
> -----------------------
> #!/bin/sh
> 
> function do_grep() {
>     pattern="$1"
>     dir="$2"
>     shift;shift
>     
>     for i in $dir/$*; do
>         if ! test -d "$i"; then
>             if test -e "$i"; then
> 		grep -E "$pattern" "$i" /dev/null
> 	    fi
>         fi
>     done
>     for i in $dir/*; do
>         if test -d "$i"; then
> 	    do_grep "$pattern" "$i" $*
> 	fi
>     done
> }
> 
> do_grep 'extern [^()]*;' . "*.c" 2>&1 | tee ../extern.log
> ---------------------------------

FWIW, I suppose you meant:
$ find . -name '*.c' | xargs grep -E 'extern [^()]*;' 2>&1 | tee extern.log

Regards, Olaf.
