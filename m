Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUJOABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUJOABf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUJNWOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:14:36 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:49556 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S267409AbUJNWGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:06:10 -0400
Subject: Re: __attribute__((unused))
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041014220243.B28649@flint.arm.linux.org.uk>
References: <20041014220243.B28649@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1097791496.5788.2034.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 14 Oct 2004 23:04:56 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 22:02 +0100, Russell King wrote:
> Hi,
> 
> I notice that module.h contains stuff like:
> 
> #define MODULE_GENERIC_TABLE(gtype,name)                        \
> extern const struct gtype##_id __mod_##gtype##_table            \
>   __attribute__ ((unused, alias(__stringify(name))))
> 
> and even:
> 
> #define __MODULE_INFO(tag, name, info)                                    \
> static const char __module_cat(name,__LINE__)[]                           \
>   __attribute_used__                                                      \
>   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
> 
> My understanding is that we shouldn't be using __attribute__((unused))
> in either of these - can someone confirm.

Since the structure in question isn't explicitly referenced from
elsewhere, the compiler may feel free to omit it. Since we want the
compiler to emit it, not omit it, we use "unused" to say "yes, I know it
looks unused; please emit it anyway". Later compilers use "used" to say
"I use it really; please emit it anyway", meaning much the same thing.

Or something like that.

-- 
dwmw2


