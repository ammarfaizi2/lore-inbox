Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUJOMdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUJOMdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJOMdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:33:22 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:32208 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S267743AbUJOMdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:33:02 -0400
Date: Fri, 15 Oct 2004 14:33:00 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((unused))
Message-ID: <20041015123300.GA12530@janus>
References: <20041014220243.B28649@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014220243.B28649@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:02:43PM +0100, Russell King wrote:
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
> 
> The second one looks fairly dodgy since we're telling a compiler that
> it's both used and unused.  That sounds a bit like a HHGTTG puzzle (you
> have tea and no tea.)

This makes sense, assuming the gcc info pages are correct:
`unused'
     This attribute, attached to a function, means that the function is
     meant to be possibly unused.  GCC will not produce a warning for
     this function.  GNU C++ does not currently support this attribute
     as definitions without parameters are valid in C++.

`used'
     This attribute, attached to a function, means that code must be
     emitted for the function even if it appears that the function is
     not referenced.  This is useful, for example, when the function is
     referenced only in inline assembly.

So, a function could be "used" and "unused" at the same time:

	unused -> don't warn
	used -> don't discard

-- 
Frank
