Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUKWXHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUKWXHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKWXFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:05:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:37586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbUKWXDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:03:25 -0500
Date: Tue, 23 Nov 2004 15:07:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "colin" <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I cannot stop execution by using "ctrl+c"
Message-Id: <20041123150738.0e243724.akpm@osdl.org>
In-Reply-To: <011501c4d14e$d00b1ce0$8b1a13ac@realtek.com.tw>
References: <011501c4d14e$d00b1ce0$8b1a13ac@realtek.com.tw>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"colin" <colin@realtek.com.tw> wrote:
>
> When using gdb to debug Linux kernel, I found that it cannot be stopped
> temporarily by using "ctrl+c".
> After the first strike of "ctrl+c", nothing happen.
> After the second, Linux kernel will show these messages:
>     Interrupted while waiting for the program.
>     Give up (and stop debugging it)? (y or n)
> If choose yes, kernel will totally stop and it goes back to gdb shell.
> How can I stop kernel temporarily and then resume it?

This means that the kgdb stub is no longer intercepting the serial
interrupts.  This tends to happen when someone makes changes to the serial
layer and the kgdb patch isn't updated to reflect those changes.

You failed to mention the kernel version.  The kgdb stub in 2.6.10-rc2-mm3
should work OK.

Sometimes, disabling the serial drivers in .config will help.
