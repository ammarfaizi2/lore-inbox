Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVBCGl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVBCGl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVBCGl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:41:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:59095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262552AbVBCG1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:27:33 -0500
Date: Wed, 2 Feb 2005 22:27:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb update (new patch)
Message-Id: <20050202222729.72ad31d4.akpm@osdl.org>
In-Reply-To: <1107411557.2189.24.camel@gaston>
References: <1107411557.2189.24.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> This patch against current bk replaces the previous one I sent you.
> 
>  It adds the sleep support for newer powermacs, improve power saving on
>  some laptops, makes use of the new fbdev modelist management routines,
>  and fixes a few backlight related issues.
> 
>  I tested it on a thinkpad T30 and a few PPC boxes with success. It
>  should be less invasive than the previous one (I don't try to restore
>  the mode on exit, that is what breaks the thinkpad and possibly other
>  stuffs that boot in VGA text mode), plus fixed a couple of bugs in the
>  mode detection code. I also reverted the memory map fix on ppc since it
>  doesn't work properly on some recent laptops where the firmware sets a
>  tiled display. I'll rework that completely to update the memory map as
>  part of the mode setting later. That should fix various issues when
>  switching with X/DRI on x86.
> 
>  Andrew: If Linus takes it, you'll need to send him the patch that
>  fixes the old radeonfb build.

I don't think Linus _can_ apply it - he doesn't have
try_acquire_console_sem() for a start.

I currently have:

add-try_acquire_console_sem.patch
update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
radeonfb-massive-update-of-pm-code.patch
radeonfb-build-fix.patch

And the patch which you've just send replaces
radeonfb-massive-update-of-pm-code.patch.

Please confirm that all four are needed.

Are you seriously proposing this for 2.6.11??
