Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUETSoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUETSoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUETSoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 14:44:54 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39467 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265236AbUETSow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 14:44:52 -0400
Date: Thu, 20 May 2004 20:56:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: No forces rebuild while changing GCC?
Message-ID: <20040520185635.GA4256@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040520181617.GE1912@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520181617.GE1912@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 08:16:17PM +0200, Jan-Benedict Glaw wrote:
> Hi!
> 
> I'm currently playing with patches for gcc HEAD to build a vax-linux
> cross-compiler. For testing it, I first want to build parts of the
> kernel with my HEAD toolchain, Ctrl-C, and continue/finish building with
> my old compiler (2.95.2).
> 
> I do changing gcc by putting one or the other gcc into $PATH. However,
> whenever I change GCC, kbuild decides to rebuild everything.
> 
> I tried to not overwrite compile.h (my commenting out the mv command in
> scripts/mkcompile_h), but that didn't help either. I even tried
> recompiling my HEAD gcc with exactly the same version string that my old
> gcc had, but that didn't work either:(
> 
> How can I force to keep my old .o files?

This is not easy. kbuild uses a number of measures to check dependencies:
1) Changes in commandline, including name of binary
- Order is not relevant, only content
2) Compiler version used for version.h
- To avoid this remove the FORCE in init/Makefile
3) Usual dependencies, including stdarg.h which is part of the compiler
   include files
4) Change in configuration relevant for that specific file

I think you are hit by 1) in your case.
Do you use same name for both gcc versions?
Otherwise it will fail as you describe (actually work as expected).

Try to compare to commandlines when using "make V=1", to check what gcc
kbuild uses.

	Sam
