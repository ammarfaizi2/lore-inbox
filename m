Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWAKQjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWAKQjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWAKQjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:39:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7685 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751362AbWAKQjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:39:16 -0500
Date: Wed, 11 Jan 2006 17:38:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 make fails with multiple targets in parallel
Message-ID: <20060111163846.GA16112@mars.ravnborg.org>
References: <13394.1136968751@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13394.1136968751@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 07:39:11PM +1100, Keith Owens wrote:
> Running make on the kernel tree with multiple targets on the command
> line and in parallel mode gets errors.  The prepare targets are run
> several times, once for each target on the command line.  Sometimes the
> result is sensible, sometimes the prepare commands overwrite each other
> with either garbage or missing files.
> 
> make -j12 compressed modules vmlinux
>   Using /foo/linux as source for kernel
>   Using /foo/linux as source for kernel
>   Using /foo/linux as source for kernel
>   GEN    /foo/obj/Makefile
I've tested it locally. It happens only when using 'make O=...'
or in your case with KBUILT_OUTPUT set to a value.

I will try to take a look during the weekend  but if you have any inputs
that would be appreciated.
 
> Is this where we mention http://www.google.com/search?q=cache:HwuX7YF2uBIJ:aegis.sourceforge.net/auug97.pdf&hl=en ?
>
The bug you see is due to the way the "make O=..." support is done - not
due to use of recursive makefiles in the kernel.

That being said I hope one day to write a tool that can take all
the kbuild files used as part of the kernel build and create one
big Makefile - sounds familiar?

The current syntax is rather easy to parse up so no syntax changes in
the kbuild (makefile) files needed.
But several other topics are higher on the todo list for now.

	Sam
