Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRJKPVC>; Thu, 11 Oct 2001 11:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276444AbRJKPUx>; Thu, 11 Oct 2001 11:20:53 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:8109 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S276381AbRJKPUk>; Thu, 11 Oct 2001 11:20:40 -0400
Date: Thu, 11 Oct 2001 08:20:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: willy tarreau <wtarreau@yahoo.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10-ac11
Message-ID: <20011011082033.F12016@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011080046.C12016@cpe-24-221-152-185.az.sprintbbd.net> <20011011151045.40155.qmail@web20508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011011151045.40155.qmail@web20508.mail.yahoo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 05:10:45PM +0200, willy tarreau wrote:
> > Erm, these files should include <linux/pm.h>
> > directly and not
> > expect something else to pull it in.  Doing a quick
> > grep
> > shows that everything else does.
> 
> well, I find it normal that a file which uses some definitions
> includes the required files itself. Else, a single change in any
> ".h" file would have repercussions on many files and external
> projects.

Er, d'oh.  After looking a bit <asm-i386/keyboard.h> does need
<linux/pm.h>.  Still, pc_keyb.c is used on other arches and the code in
question looks to be wholly specific to a Dell laptop.

Alan, please apply the following which just adds <linux/pm.h> to the
include list on drivers/char/pc_keyb.c

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- linux-2.4.10-ac11.orig/drivers/char/pc_keyb.c	Wed Oct 10 19:10:27 2001
+++ linux-2.4.10-ac11/drivers/char/pc_keyb.c	Wed Oct 10 19:35:15 2001
@@ -34,6 +34,7 @@
 #include <linux/vt_kern.h>
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
+#include <linux/pm.h>
 
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
