Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267178AbUFZQGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267178AbUFZQGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUFZQGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:06:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:22499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267178AbUFZQGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:06:16 -0400
Date: Sat, 26 Jun 2004 09:05:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.7-bk: asm/setup.h and linux/init.h
In-Reply-To: <20040626153511.A30532@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0406260903190.14449@ppc970.osdl.org>
References: <20040626153511.A30532@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, Russell King wrote:
> 
> Is there a reason why we can't delete asm/setup.h from linux/init.h
> and change that declaration to:
> 
> +extern char saved_command_line[];

Yes. A number of achitectures use something like

	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));

and that "sizeof()" would require the full declaration.

However, I don't see any reason why we couldn't make that sizeof be
COMMAND_LINE_SIZE instead, if somebody is willing to grep and do the
conversion and make sure everybody who now uses it has <asm/setup.h>
included.

Hmm?

		Linus
