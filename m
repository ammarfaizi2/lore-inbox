Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTDOVW6 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTDOVW6 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:22:58 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38409
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264089AbTDOVW4 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:22:56 -0400
Subject: Re: [PATCH] [2.5] include/asm-generic/bitops.h {set,clear}_bit
	return void
From: Robert Love <rml@tech9.net>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3E9C7955.7070605@gmx.net>
References: <20030415174010$3e7e@gated-at.bofh.it>
	 <200304152007.h3FK72sD003180@post.webmailer.de>  <3E9C7955.7070605@gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1050442489.3664.159.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 15 Apr 2003 17:34:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-15 at 17:27, Carl-Daniel Hailfinger wrote:

> What is the preferred way to achieve atomicity in an operation now that
> cli() and sti() are gone?

spin locks.

> The point of asm-generic is not to use the files, but to give porters a
> hint about the functionality. Quoting asm-generic/bitops.h:
> 
> /* For the benefit of those who are trying to port Linux to another
>  * architecture, here are some C-language equivalents.  You should
>  * recode these in the native assembly language, if at all possible.
>  * To guarantee atomicity, these routines call cli() and sti() to
>  * disable interrupts while they operate.  (You have to provide inline
>  * routines to cli() and sti().) */
> 
> Or is this comment wrong, too?

Well, the cli() and sti() part is definitely wrong for 2.5.

It is wrong though to assume that nothing will use these; someone may
copy them directly (and then they do not work) or someone may #include
this file.

I like Arnd's suggestion to just remove these functions and all other
instances of them -- assuming in fact they are never used.

	Robert Love

