Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSF1I4I>; Fri, 28 Jun 2002 04:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSF1I4H>; Fri, 28 Jun 2002 04:56:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34320 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317072AbSF1I4H>;
	Fri, 28 Jun 2002 04:56:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Greg Banks <gnb@alphalink.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] [PATCH] kconfig: menuconfig and config uses $objtree 
In-reply-to: Your message of "Fri, 28 Jun 2002 18:07:45 +1000."
             <3D1C1951.987E1FF8@alphalink.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Jun 2002 18:58:17 +1000
Message-ID: <934.1025254697@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002 18:07:45 +1000, 
Greg Banks <gnb@alphalink.com.au> wrote:
>Sam Ravnborg wrote:
>> 
>> In order to prepare for separate obj and src trees make use of $objtree
>> within scripts/Menuconfig and scripts/Configure.
>> All temporary and all result files are located in directory pointed at
>> by $objtree.
>
>Interesting, but there's an alternative approach.  Let the scripts dump
>any files they like into the current directory, but move the current
>directory to be the *object* directory not the source directory.  Then
>all you need to change are the places where the arch config.in files are
>initially included, and to override the "source" statement to look relative
>to $srctree not the current directory.  That last can be done like this:

You are still forcing all the CML code to know about the difference
between source and object trees and to handle multiple source trees.
With that approach, the knowledge has to be embedded in every CML
program, and changed every time the tree structure changes.

It is far better to retain the existing CML design which assumes that
there is only one tree.  Then use symlinks to hide the real tree
structure from CML.  That gives us the flexibility to change the tree
structure without changing every CML program.

Notice that kbuild 2.5 handles separate source and object trees and
even multiple source trees with _no_ changes to CML code.  The only
change to CML in kbuild 2.5 is to add Ghozlane Toumi's extra config
targets.  scripts/Makefile-2.5 hides all the complexity of separate
source and object and multiple source trees from both CML1 and CML2.

