Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVANETO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVANETO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVANETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:19:13 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:56789 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261903AbVANES6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:18:58 -0500
Date: Thu, 13 Jan 2005 20:25:42 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Han Boetes <han@mijncomputer.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050114042542.GB64314@gaz.sfgoth.com>
References: <20050113134620.GA14127@boetes.org> <20050113140446.GA22381@infradead.org> <20050113163733.GB14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113163733.GB14127@boetes.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 13 Jan 2005 20:25:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Han Boetes wrote:
> And I got two warnings about `int __guard = '\0\0\n\777';'
> 
> lib/propolice.c:15:15: warning: octal escape sequence out of range

Yeah, I have no idea what '\777' is supposed to be - that's 9 bits wide.

> lib/propolice.c:15:15: warning: multi-character character constant

Since the __guard symbol isn't used directly by C code it doesn't matter
what type it is, right?  You should be able to just say something like:

unsigned char __guard[sizeof(int)] = { '\0', '\0', '\n', (unsighed char) -1 };

Or maybe you want those in the opposite order for endianness.. not sure.
Having the '\0' first in memory makes the most sense to me but I haven't
thought about it much.

> +static const char message[] = "propolice detects %x at function %s.\n";
> +
> +void __stack_smash_handler(int damaged, char func[])

1. "damaged" should be "unsigned int"; it's used with a "%x" format specifier
2. "func" should probably be "const char *func"
3. Why is message[] defined instead of just using it directly in the call
   to panic like panic("blah blah...", ...)  Maybe I'm missing something
   subtle there.

-Mitch
