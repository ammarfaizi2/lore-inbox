Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSF2Bsf>; Fri, 28 Jun 2002 21:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSF2Bse>; Fri, 28 Jun 2002 21:48:34 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:28946 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317498AbSF2Bsd>;
	Fri, 28 Jun 2002 21:48:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: menuconfig and config uses $objtree 
In-reply-to: Your message of "Fri, 28 Jun 2002 19:28:07 +0200."
             <20020628192807.A2142@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Jun 2002 11:50:41 +1000
Message-ID: <5050.1025315441@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002 19:28:07 +0200, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>It basically teach the config tools that the SRC are no longer
>in current directory but pointed out by $srctree, that output files
>are pointed out by $objtree, and temporary files the same place.
>
>No nasty tricks with sym-lnks required, no copy files around before
>or after the config tools are used. No specific directories that
>needs to be created beforehand.
>Indeed my approach is a number of lines - but that on the other hand
>simplify the usage of the config tools.
>
>But I see your point that we should avoid hardcoding too much
>knowledge in the config tools, and I may change the patch to
>use command-line parameters to specify SRC and OBJ dirs.

What happens when you want to support multiple source trees?  Your
approach prevents the use of multiple source trees, either shadow or
separate (add on) code and breaks kbuild 2.5.  My approach puts all the
complexity (once) in the makefile, not replicated over multiple CML
programs.

What happens when the config data is not in monolithic files but is
supplied in per-driver files (driver.inf)?  Linus wants that feature
eventually.  Note that driver.inf will contain more than just config
data, it will contain all the data required to build a driver.  With
your approach every CML program would have to be changed to understand
the format of the driver.inf files, replicating the code over multiple
parsers.  With my approach you need one program that extracts the
relevant data for config and builds the config tree, then the existing
CML programs run unchanged.

Do it once in the makefile.  Do not embed the knowledge about the
source of the config data in every CML program.

