Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422946AbWF1C5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWF1C5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 22:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbWF1C5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 22:57:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422946AbWF1C5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 22:57:50 -0400
Date: Tue, 27 Jun 2006 19:57:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
 uninitialised data
Message-Id: <20060627195743.ce18afe3.akpm@osdl.org>
In-Reply-To: <1151462735.5793.2.camel@mulgrave.il.steeleye.com>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	<20060626200433.bf0292af.akpm@osdl.org>
	<1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	<20060626220337.06014184.akpm@osdl.org>
	<1151419746.3340.13.camel@mulgrave.il.steeleye.com>
	<20060627170446.30392b00.akpm@osdl.org>
	<1151462735.5793.2.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 22:45:34 -0400
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Tue, 2006-06-27 at 17:04 -0700, Andrew Morton wrote:
> > +static void __init __attribute__((weak)) smp_setup_processor_id(void)
> 
> If you're really sure this works .. then it looks OK.

We do it quite a lot actually.
box:/usr/src/linux-2.6.17> grep -r 'attribute.*weak' . | wc -l
91

>  However, I
> thought weak was a linker attribute, not a compiler one.

Yes, it is mainly a linker thing.  But the compiler has to emit the ".weak"
pseudo-op and not inline the function.

>  How does the
> compiler know if the static inline needs to be incorporated or if a
> strong symbol is going to override it when the whole thing is linked
> together at the time it just compiles main.c?

I didn't mark it inline.

If the compiler chose to inline it then that would be rather dumb of it,
given that it had the weak attribute.  But yes, paranoia says we should be
tagging this noinline too.

> > Is that all OK?
> 
> I'll give it a whirl tomorrow when I get access to one of the voyager
> systems in Columbia.

Thanks.
