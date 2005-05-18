Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVERDAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVERDAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 23:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVERDAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 23:00:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:37523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262065AbVERC7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:59:32 -0400
Date: Tue, 17 May 2005 19:58:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix to virtual terminal UTF-8 mode handling
Message-Id: <20050517195848.4a09318d.akpm@osdl.org>
In-Reply-To: <20050518030513.7fe55ef1@nim.leo>
References: <20050518030513.7fe55ef1@nim.leo>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul LeoNerd Evans <leonerd@leonerd.org.uk> wrote:
>
>  This patch fixes a bug in the virtual terminal driver, whereby the UTF-8
>  mode is reset to "off" following a console reset, such as might be
>  delivered by mingetty, screen, vim, etc...

Is it a bug?  What did earlier kernels do?  2.4.x?

>  Rather than resetting to hardcoded "0", it gets reset on or off, as
>  determined by a new sysctl located in /proc/tty/vt/default_utf8_mode.
>  This patch is best accompanied with an addition of the following line to
>  the system's init scripts:
> 
>    echo 1 >/proc/tty/vt/default_utf8_mode
> 
>  Following this, all resets to the console will leave it with UTF-8 mode
>  on.
> 
>  The default behaviour of this sysctl is as before, without the patch.
>  Namely, UTF-8 mode is switched off on reset. [I.e applying this patch
>  does not affect default behaviour].

Presumably userspace knows what mode the user wants the terminal to be
using.  Shouldn't userspace be resetting that mode after a reset?

