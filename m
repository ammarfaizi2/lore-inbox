Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTJLNUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 09:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTJLNUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 09:20:06 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:20950 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263462AbTJLNUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 09:20:04 -0400
Subject: Re: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200310121310.h9CDASEI006119@harpo.it.uu.se>
References: <200310121310.h9CDASEI006119@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1065964761.993.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 12 Oct 2003 15:19:22 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-12 at 15:10, Mikael Pettersson wrote:
> When I compile a non-modular 2.6 kernel for ppc with gcc-3.3.1,
> it oopses in __copy_tofrom_user() [copy_mount_options()] in
> user-space's first mount /proc call. User-space limps along
> for a while, oopsing in every mount call, and then hangs.
> 
> This occurs with 2.6.0-test5, test6, and the test7-based
> linuxppc-2.5 tree (rsync:ed today).
> 
> Enabling CONFIG_MODULES=y but still keeping everything built-in
> prevents the oopses.

Smells like some section alignement issues. Can you check
how the __ex_table  section is aligned and where __start___ex_table
points to ? (using objdump)

Ben.


