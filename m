Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbSIVPVJ>; Sun, 22 Sep 2002 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264261AbSIVPVJ>; Sun, 22 Sep 2002 11:21:09 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33809 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264260AbSIVPVI>; Sun, 22 Sep 2002 11:21:08 -0400
Date: Sun, 22 Sep 2002 17:24:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <20020920071055.A1852@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0209221648180.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Sep 2002, Sam Ravnborg wrote:

> I have been working on integrating lkc with kbuild.
> Here is the result.

Thanks, nice work. :)

> Rules.make
> - Added infrastructure to support host-ccprogs, in other words
>   support tools written (partly) in c++.

There are all compiled with gcc instead of g++, are you sure that will ok
with all supported gcc versions?

> scripts/lkc/Makefile*
> - As kbuild does not distingush between individual objects,
>   used for a given target, but (try to) build them all, I have
>   found a solution where I create one Makefile for each executable.
>   I could not see a clean way to integrate this in kbuild, and finally
>   decided that in this special case a number of Makefiles did not
>   hurt too much.

Here I thought about using "ifeq ($(MAKECMDGOALS),...)" to keep them in a
single file. Did you try something like this?

> flex/bison
> - Prepared for "_shipped" files.
>   Rename lex.zconf.c to lex.zconf.c_shipped etc. in the version
>   reday to go in the kernel.

This works quite well for users, but it's very annoying for the developer.
Kai, any chances to use md5sum for this at some point, e.g. with a helper
script like this:

set -e
src=$1
dst=$2
shift 2

test -f $dst && tail -1 $dst | sed 's,/\* \(.*\) \*/,\1,' | md5sum -c && touch $dst && exit 0
echo "$@"
"$@"
echo "/* $(md5sum $src) */" >> $dst

The only problem with this script is that it only supports a single input
and output file.

Something else I'd like to have for later is the ability to compile
$(sharedobjs) as a shared library and install it somewhere so it can be
used by external programs.

bye, Roman


