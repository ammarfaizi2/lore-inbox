Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267827AbUHEUc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUHEUc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHEUcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:32:06 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:26188 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267827AbUHEUbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:31:47 -0400
Date: Thu, 5 Aug 2004 22:33:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexander Stohr <Alexander.Stohr@gmx.de>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org,
       Pawe? Sikora <pluto@pld-linux.org>
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
Message-ID: <20040805203317.GA22342@mars.ravnborg.org>
Mail-Followup-To: Alexander Stohr <Alexander.Stohr@gmx.de>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org,
	Pawe? Sikora <pluto@pld-linux.org>
References: <2695.1091715476@www33.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2695.1091715476@www33.gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 04:17:56PM +0200, Alexander Stohr wrote:
> 
> As you, and possibly others can see,
> the compilation happens from the arch/i386/kernel/timers subdir,
> where we got lead to by th arch/i386/kernel subdir directly
> and in this case the needed settings seem to lack despite they
> were present in a former stage of the compilation.

What happens is that the value assigned to AFLAGS_vmlinux.lds.o is lost
between the first and the second invocation of make in arch/i386/kernel

The only difference is the setting of LANG etc. - which you deleted
from the log.

Pleae try to delete the following lines from the top-level Makefile and try again:

line 622-626:
	$(Q)if [ ! -z $$LC_ALL ]; then          \
	export LANG=$$LC_ALL;           \
	export LC_ALL= ;                \
	fi;                                     \
	export LC_COLLATE=C; export LC_CTYPE=C; \
	
If this cures the problem then please provide me with you LANG settings.
Both LANG and LC_* variables.

If it still fails please provide me with the _full_ unedited log up until
the point where it fails.

Since I have to reports on this issue I really would like to have it
nailed before 2.6.8 is out.

The other report is from: Pawe? Sikora <pluto@pld-linux.org>

	Sam
