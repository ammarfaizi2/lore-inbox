Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbTEBSVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTEBSVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:21:36 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:5341 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263072AbTEBSUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:20:55 -0400
Date: Fri, 2 May 2003 14:09:41 -0400
From: Ben Collins <bcollins@debian.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] alternative compat_ioctl table implementation
Message-ID: <20030502180941.GG426@phunnypharm.org>
References: <200305021959.02726.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305021959.02726.arnd@arndb.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 07:59:02PM +0200, Arnd Bergmann wrote:
> I had some trouble making the 2.5.68bk implementation
> for compat_ioctl work on s390x because of a cross-compiling
> bug in gcc-2.95.
> 
> This patch changes the way that the translation table
> is generated and solves the problem by replacing
> the assembler magic with linker magic.
> 
> As a side effect, it adds type-checking for the handler
> functions and makes it possible to put COMPATIBLE_IOCTL()
> in places other than arch/*/kernel/ioctl32.c, e.g. next
> to the normal ioctl handler.
> 
> This needs the compat-ioctl-fix.patch from 2.5.68mm4.
>

You macros don't work for things like this:

COMPATIBLE_IOCTL(_IOW('v',  BASE_VIDIOCPRIVATE+0, char [256]))
COMPATIBLE_IOCTL(_IOR('v',  BASE_VIDIOCPRIVATE+1, char [256]))

...which are in compat_ioctl.h.

--
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
