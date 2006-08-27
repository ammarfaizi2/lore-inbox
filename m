Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWH0Jtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWH0Jtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWH0Jtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:49:31 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:20264 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932073AbWH0Jta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:49:30 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel. 
In-reply-to: Your message of "Sun, 27 Aug 2006 01:44:20 MST."
             <20060827084451.492329798@goop.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 Aug 2006 19:49:31 +1000
Message-ID: <11098.1156672171@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge (on Sun, 27 Aug 2006 01:44:20 -0700) wrote:
>2: entry.S constructs the stack in the shape of struct pt_regs, and this
>   is passed around the kernel so that the process's saved register
>   state can be accessed.
>--- a/arch/i386/kernel/entry.S
>+++ b/arch/i386/kernel/entry.S
>@@ -30,12 +30,14 @@
>  *	18(%esp) - %eax
>  *	1C(%esp) - %ds
>  *	20(%esp) - %es
>+ *	24(%esp) - %fs	(not saved/restored)
>+ *	28(%esp) - %gs
>+ *	2C(%esp) - orig_eax
>+ *	30(%esp) - %eip
>+ *	34(%esp) - %cs
>+ *	38(%esp) - %eflags
>+ *	3C(%esp) - %oldesp
>+ *	40(%esp) - %oldss
...
>+FS		= 0x24
>+GS		= 0x28
>+ORIG_EAX	= 0x2C
>+EIP		= 0x30
>+CS		= 0x34
>+EFLAGS		= 0x38
>+OLDESP		= 0x3C
>+OLDSS		= 0x40

Now would be a good time to get rid of those hard coded numbers and use
asm-offsets instead.

