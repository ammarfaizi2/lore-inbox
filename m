Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHBMIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTHBMIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:08:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2054 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261180AbTHBMH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:07:58 -0400
Date: Sat, 2 Aug 2003 14:07:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       comedi@comedi.org
Subject: Re: compiling external kernel modules (comedi.org)
Message-ID: <20030802120756.GA964@mars.ravnborg.org>
Mail-Followup-To: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	comedi@comedi.org
References: <3F2B0E06.9000907@cn.stir.ac.uk> <20030802070422.GA2404@mars.ravnborg.org> <3F2BA623.6030906@cn.stir.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2BA623.6030906@cn.stir.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 12:53:07PM +0100, Bernd Porr wrote:
> Ok. Thanks. Now the bug is that comedi cannot find the file "Rules.make" 
> which is apparently no longer there in 2.6. Is it right that the rules 
> are now integrated in the corresponding makefiles?

The way to find the Makefiles changed during the 2.5 development
cycle. Now the kbuild Makefile (the one for comedi for example) are
included from scripts/Makfile.build hereby obsoleting Rules.make.

You will NOT succeed creating a single simple makefile supporting both
2.4 and 2.6. On the other hand the Makefile are so trivial that creating
two distinct version should be acceptable?

> Can you recommend me a Makefile which I can take as a template? Comedi 
> uses some sort of autoconfig and I have to append then the "rules" to 
> the automatically generated makefile.

The most simple Makefile looks like this:

obj-m := comedi.o

No more is actually needed.
You should get rid of export-objs as well - they are also obsoleted
in 2.5/2.6.


> Another thing: can a prevent the kernel of generating the "Stage 2"? It 
> would be nice if the kernel doen't need to write to it's own directories 
> if it compiles external modules.

The right fix is to allow you to build a kernel in a directory
separate from the kernel src. This is WIP - hopefully included in 
mainline within a few weeks.

PS. Please do not cc: subscription only mailing lists.

	Sam
