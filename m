Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSFECih>; Tue, 4 Jun 2002 22:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317529AbSFECig>; Tue, 4 Jun 2002 22:38:36 -0400
Received: from zok.SGI.COM ([204.94.215.101]:19400 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317517AbSFECif>;
	Tue, 4 Jun 2002 22:38:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Tue, 04 Jun 2002 22:25:20 -0400."
             <200206050224.WAA00121@mail.reutershealth.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Jun 2002 12:38:18 +1000
Message-ID: <20890.1023244698@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002 22:25:20 -0400 (EDT), 
John Cowan <jcowan@reutershealth.com> wrote:
>Keith Owens scripsit:
>
>> In order to do separate source and object correctly, kbuild 2.5
>> enforces the rule that #include "" comes from the local directory,
>> #include <> comes from the include path.  include/linux/zlib.h
>> incorrectly does #include "zconf.h" instead of #include <linux/zconf.h>,
>> breaking the rules.
>
>This is not the standard gcc behavior, however; quoted-includes
>can come from the include path, although the current directory
>is searched first.  The purpose of <>-includes is to suppress
>searching the current directory.

What gcc allows and what the kernel uses as a coding style are two
different things.  Almost all of the kernel uses <> for global files
and "" for local files, this is the only sane way of coding for a large
project.  However there are some exceptions where the wrong form has
been used.

The wrong form causes problems for separate source and object
directories.  It also causes problems when you do not compile in the
same directory that does not contain the source, i.e. when you do a
global make instead of recursive make.  kbuild 2.5 has identified all
of the problem includes.  I avoided changing the source, instead I
added extra include paths as a temporary workaround, with FIXME
comments for later clean up.  I noticed that some people have already
used the kbuild 2.5 FIXME comments to clean up their code.

