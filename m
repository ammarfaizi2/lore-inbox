Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSF2IUz>; Sat, 29 Jun 2002 04:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSF2IUy>; Sat, 29 Jun 2002 04:20:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:2053 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290289AbSF2IUx>;
	Sat, 29 Jun 2002 04:20:53 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: menuconfig and config uses $objtree 
In-reply-to: Your message of "Sat, 29 Jun 2002 09:26:01 +0200."
             <20020629092601.A2019@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Jun 2002 18:23:00 +1000
Message-ID: <7026.1025338980@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jun 2002 09:26:01 +0200, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>So in our discussion about shadow-tress I recall you mentioned 
>several times that using a built-only tree of src-files would create
>a lot of problems when changes were made, and you had to distribute
>changes back in the original trees.
>My point then was that changes were always made in the original tree.
>And now I see that you use the exact same apporach for config-files
>within kbuild-2.5. So do you agree that creating a built-only tree
>suddenly becomes an OK solution?

You are confusing two completely different cases.  Config reads from a
lot of files and generates one file.  Kernel build both reads and
writes lots of files, plus the developer edits files as they create
their code.  Different problems require different solutions.

Creating a set of symlinks in the object tree to point to every source
file is possible but horribly slow!  On my build machine, creating
10,300 symlinks takes 90 seconds before you can even start compiling [*].
In contrast, all of the kbuild 2.5 processing (phases 1 through 4) on
the same machine takes 9 seconds before you start compiling.

I use symlinks for CML because there are far fewer files and the
symlink tree only has to be built when make *config is requested.
There are also several CML programs that would have to be changed each
time the tree structure changed, code replication is bad.

I do not use symlinks for the main build because they are too slow.
Especially when you include the overhead of resynchronising the source
symlinks on every build.  It has to be redone every time because the
set of source files may have changed.
