Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWBYCIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWBYCIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWBYCIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:08:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964855AbWBYCIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:08:40 -0500
Date: Fri, 24 Feb 2006 18:07:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] x86: clean up early_printk output
Message-Id: <20060224180752.41a13387.akpm@osdl.org>
In-Reply-To: <200602241909_MC3-1-B93E-25B@compuserve.com>
References: <200602241909_MC3-1-B93E-25B@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
>  early_printk() starts output on the second screen line and doesn't
>  clear the rest of the line when it hits a newline char.  When there
>  is already a BIOS message there, it becomes hard to read.  Change
>  this so it starts on the first line and clears to EOL upon hitting
>  newline.

This conflicts in intent with Stas's patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/x86-early-printk-handling-fixes.patch

that patch solves the same problem, and I think in a slightly better way:
at least there's a chance that some of those (potentially useful)
bootloader messages are still visible when the kernel goes tits up.

Of course, the best fix would be to start the kernel messages at the next
line after the bootloader, but I guess that info would be hard to locate.

