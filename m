Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUA0UYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265677AbUA0UYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:24:20 -0500
Received: from intra.cyclades.com ([64.186.161.6]:64395 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265673AbUA0UYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:24:11 -0500
Date: Tue, 27 Jan 2004 17:46:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
In-Reply-To: <20040126165421.679327f0.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.58L.0401271745490.11421@logos.cnet>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
 <20040126165421.679327f0.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jan 2004, Rusty Russell wrote:

> On Fri, 23 Jan 2004 16:58:24 -0200 (BRST)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > Here goes -pre number 7 of 2.4.25 series.
>
> Any chance of the forward-compatible module_param patch?
>
> Name: 2.4 module_param Forward Compatibility Macros
> Author: Rusty Russell
> Status: Tested on 2.5.24-pre6
> Version: 2.4
>
> D: Simple uses of module_param() (implemented in 2.6) can be mapped
> D: onto the old MODULE_PARM macros.
> D:
> D: New code should use module_param() because:
> D: 1) Types are checked,
> D: 2) Existence of parameters are checked,
> D: 3) Customized types are possible [1]
> D: 4) Customized set/get routines are possible [1]
> D: 5) Parameters appear as boot params with prefix "<modname>." [1]
> D: 6) Optional viewing and control through sysfs [2]
> D:
> D: [1] Not for 2.4 compatibility macros
> D: [2] Not in 2.6.1 or 2.4, and only if third arg non-zero.
>
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25425-linux-2.4.25-pre6/include/linux/moduleparam.h .25425-linux-2.4.25-pre6.updated/include/linux/moduleparam.h
> --- .25425-linux-2.4.25-pre6/include/linux/moduleparam.h	1970-01-01 10:00:00.000000000 +1000
> +++ .25425-linux-2.4.25-pre6.updated/include/linux/moduleparam.h	2004-01-21 14:24:41.000000000 +1100
> @@ -0,0 +1,25 @@
> +#ifndef _LINUX_MODULE_PARAMS_H
> +#define _LINUX_MODULE_PARAMS_H
> +/* Macros for (very simple) module parameter compatibility with 2.6. */
> +#include <linux/module.h>
> +
> +/* type is byte, short, ushort, int, uint, long, ulong, bool. (2.6
> +   has more, but they are not supported).  perm is permissions when
> +   it appears in sysfs: 0 means doens't appear, 0444 means read-only
> +   by everyone, 0644 means changable dynamically by root, etc.  name
> +   must be in scope (unlike MODULE_PARM).
> +*/
> +#define module_param(name, type, perm)					     \
> +	static inline void *__check_existence_##name(void) { return &name; } \
> +	MODULE_PARM(name, _MODULE_PARM_STRING_ ## type)
> +
> +#define _MODULE_PARM_STRING_byte "b"
> +#define _MODULE_PARM_STRING_short "h"
> +#define _MODULE_PARM_STRING_ushort "h"
> +#define _MODULE_PARM_STRING_int "i"
> +#define _MODULE_PARM_STRING_uint "i"
> +#define _MODULE_PARM_STRING_long "l"
> +#define _MODULE_PARM_STRING_ulong "l"
> +#define _MODULE_PARM_STRING_bool "i"
> +
> +#endif /* _LINUX_MODULE_PARAM_TYPES_H */

Hi Rusty,

I think it is suitable. Will apply.

Thank you.
