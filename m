Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUIHIuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUIHIuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUIHIuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:50:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:51948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268397AbUIHIt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:49:59 -0400
Date: Wed, 8 Sep 2004 01:47:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Simon Derr <simon.derr@bull.net>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.9-rc1-mm4
Message-Id: <20040908014735.7a2058dc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409071415380.10577@daphne.frec.bull.fr>
References: <20040907020831.62390588.akpm@osdl.org>
	<Pine.LNX.4.58.0409071415380.10577@daphne.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr <simon.derr@bull.net> wrote:
>
> Build fails without CONFIG_KEYS:
> 
> kernel/sys.c:283:29: macro "sys_request_key" requires 5 arguments, but only 1 given
> kernel/sys.c:283: error: `sys_request_key' defined both normally and as an alias
> kernel/sys.c:283: warning: `syscall_linkage' attribute only applies to function types
> kernel/sys.c:284:24: macro "sys_keyctl" requires 5 arguments, but only 1 given
> kernel/sys.c:284: error: `sys_keyctl' defined both normally and as an alias
> kernel/sys.c:284: warning: `syscall_linkage' attribute only applies to function types
> 
> In include/linux/key.h, sys_request_key and sys_keyctl are defined as
> macros :
> 
> #define sys_request_key(a,b,c,d,e)      (-ENOSYS)
> #define sys_keyctl(a,b,c,d,e)           (-ENOSYS)
> 
> But in kernel/sys.c, we find:
> 
> cond_syscall(sys_request_key)
> cond_syscall(sys_keyctl)
> 
> Which expects these symbols to be real functions, it seems.

Works OK here.  What compiler version are you using?  And what architecture?



With these #defines in scope:

#define sys_request_key(a,b,c,d,e)      (-ENOSYS)
#define sys_keyctl(a,b,c,d,e)           (-ENOSYS)

the preprocessor should allow

cond_syscall(sys_request_key)
cond_syscall(sys_keyctl)

to pass through unscathed.  It's a bit unpleasant though.  I guess we can
just remove those defines from key.h.

