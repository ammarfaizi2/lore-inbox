Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTJUB47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTJUB47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:56:59 -0400
Received: from [65.172.181.6] ([65.172.181.6]:13736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262839AbTJUB4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:56:54 -0400
Date: Mon, 20 Oct 2003 18:56:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.0-test8-mm1
Message-Id: <20031020185613.7d670975.akpm@osdl.org>
In-Reply-To: <200310210046.h9L0kHFg001918@turing-police.cc.vt.edu>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<200310201811.18310.schlicht@uni-mannheim.de>
	<20031020144836.331c4062.akpm@osdl.org>
	<200310210001.08761.schlicht@uni-mannheim.de>
	<200310210014.h9L0EZFP003073@turing-police.cc.vt.edu>
	<20031020172732.6b6b3646.akpm@osdl.org>
	<200310210046.h9L0kHFg001918@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Mon, 20 Oct 2003 17:27:32 PDT, Andrew Morton said:
> > Valdis.Kletnieks@vt.edu wrote:
> > >
> > > This ring any bells?  What you want tested? etc etc....
> > 
> > Can you try disabling all fbdev stuff in config?
> 
> OK.. That booted just fine, didn't hang in pty_init, didn't hit the
> WARN_ON added to fs_inoce.c.
> 
> So we have:
> 
> works:
> #  CONFIG_FB is not set
> 
> Doesn't work:
> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> 
> I've not had a chance to play binary search on those options yet..  Graphics
> card is an NVidia GeForce 440Go, and was previous working just fine with
> framebuffer over on vc1-6 and NVidia's driver on an XFree86 on vc7. (OK, I
> admit I didn't stress test the framebuffer side much past "penguins and
> scroiled text"...)
> 

Thanks.  You're now the third person (schlicht@uni-mannheim.de,
jeremy@goop.org) who reports that the weird oopses (usually in
invalidate_list()) go away when the fbdev code is disabled.

You're using vesafb on nvidia, Jeremy is using vesafb on either radeon or
nvidia, not sure about Thomas.

Has anyone tried CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC, see if that
turns anything up?

