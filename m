Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVAQPqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVAQPqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVAQPqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:46:15 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:23439 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261826AbVAQPp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:45:57 -0500
Date: Mon, 17 Jan 2005 16:46:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@suse.cz>
Cc: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sparse refuses to work due to stdarg.h
Message-ID: <20050117154626.GA16111@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, torvalds@osdl.org,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050116224922.GA4454@elf.ucw.cz> <20050117044955.GA8092@mars.ravnborg.org> <20050117114927.GD1354@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117114927.GD1354@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 12:49:27PM +0100, Pavel Machek wrote:
 
> pavel@amd:/usr/src/linux-cvs$ make C=2
>   CHK     include/linux/version.h
>   CHECK   scripts/mod/empty.c
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHECK   init/main.c
> /usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:29:35: warning: no newline at end of file
> /usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:13:11: error: unable to open 'features.h'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> pavel@amd:/usr/src/linux-cvs$

You seems to have a symlink? to /usr/include/asm in your 3.3.5/include
directory.
But real issue is search order of include paths in sparse.
sparse searches standard system dirs before dir's specified with -I ...
This in contradiction to 'info gcc - see description for -I'.

	Sam
