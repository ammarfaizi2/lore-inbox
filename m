Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUJOBlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUJOBlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUJOBlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:41:31 -0400
Received: from ozlabs.org ([203.10.76.45]:23261 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268053AbUJOBl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:41:29 -0400
Subject: Re: s390(64) per_cpu in modules (ipv6)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: schwidefsky@de.ibm.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040629233537.523db68c@lembas.zaitcev.lan>
References: <20040629233537.523db68c@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1097804500.22673.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:41:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 16:35, Pete Zaitcev wrote:
> Hi, Martin,
> 
> I tried to build ipv6 as a module in 2.6.7, and it bombs, producing a
> module which wants per_cpu____icmpv6_socket (obviously, undefined).
> 
> The problem appears to be caused by this:
> 
> #define __get_got_cpu_var(var,offset) \
>   (*({ unsigned long *__ptr; \
>        asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
>        ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
>     }))


Heh, I ran into the same problem trying to do this trick for PPC64.  You
really need to use __thread and make GCC do the work, AFAICT.

The worse problem is that a (static) per-cpu var declared *inside* a
function gets renamed by gcc; IIRC some generic code used to do this.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

