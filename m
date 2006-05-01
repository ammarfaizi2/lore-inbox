Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWEABAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWEABAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 21:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWEABAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 21:00:03 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6061 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750736AbWEABAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 21:00:00 -0400
Subject: Re: Removing .tmp_versions considered harmful
From: Pavel Roskin <proski@gnu.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060430214732.GB18257@mars.ravnborg.org>
References: <1145593342.2904.30.camel@dv>
	 <20060421073216.GA17492@mars.ravnborg.org> <1145908527.2292.39.camel@dv>
	 <20060430214732.GB18257@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Apr 2006 20:59:57 -0400
Message-Id: <1146445197.7879.9.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sam!

On Sun, 2006-04-30 at 23:47 +0200, Sam Ravnborg wrote:
> On Mon, Apr 24, 2006 at 03:55:27PM -0400, Pavel Roskin wrote:
> > Remove *.mod files but not .tmp_versions for external builds
> > 
> > From: Pavel Roskin <proski@gnu.org>
> > 
> > When "make install" is run as root, .tmp_versions is re-created and
> > becomes owned by root.  Subsequent "make" run by user fails because
> > .tmp_versions cannot be removed.
> 
> What architecture?
> For i386 and x86_64 make install no longer try to compile the kernel.

That's x86_64.  It turns out the dependency of "install" on "all" in the
project Makefile was causing .tmp_versions to be re-created.  Removing
the dependency on "all" fixes the problem.  This is the original rule:

install: all
        $(MAKE) $(KBUILD_FLAGS) modules_install \
                INSTALL_MOD_DIR=kernel/drivers/net/wireless
        $(DEPMOD) -ae

However, I'd rather keep the dependency of "install" on "all".  It's
better to compile a few files as root than to install out-of-date
modules.  I'm glad that your patch gives me a choice how to write the
project's Makefile.

-- 
Regards,
Pavel Roskin

