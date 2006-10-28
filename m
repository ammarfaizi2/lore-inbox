Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWJ1Q3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWJ1Q3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 12:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWJ1Q3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 12:29:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751010AbWJ1Q3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 12:29:39 -0400
Date: Sat, 28 Oct 2006 09:29:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
Message-Id: <20061028092906.6c1562e3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610281153180.2091@localhost.localdomain>
References: <Pine.LNX.4.64.0610281153180.2091@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 11:56:24 -0400 (EDT)
"Robert P. J. Day" <rpjday@mindspring.com> wrote:

> 
>   it seems odd that the purpose of the "probe_kernel_address()" macro
> is, in fact, to probe a *user* address (from linux/uaccess.h):
> 
> #define probe_kernel_address(addr, retval)              \
>         ({                                              \
>                 long ret;                               \
>                                                         \
>                 inc_preempt_count();                    \
>                 ret = __get_user(retval, addr);         \
>                 dec_preempt_count();                    \
>                 ret;                                    \
>         })
> 
>   given that that routine is referenced only 5 places in the entire
> source tree, wouldn't it be more meaningful to use a more appropriate
> name?
> 

You'll notice that all callers are indeed probing kernel addresses.  The
function _could_ be used for user addresses and could perhaps be called
probe_address().

One of the reasons this wrapper exists is to communicate that the
__get_user() it is in fact not being used to access user memory.
