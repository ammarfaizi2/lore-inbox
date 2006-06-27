Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWF0FEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWF0FEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbWF0FEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:04:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932458AbWF0FDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 01:03:43 -0400
Date: Mon, 26 Jun 2006 22:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
 uninitialised data
Message-Id: <20060626220337.06014184.akpm@osdl.org>
In-Reply-To: <1151379392.3443.20.camel@mulgrave.il.steeleye.com>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	<20060626200433.bf0292af.akpm@osdl.org>
	<1151379392.3443.20.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 22:36:32 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Mon, 2006-06-26 at 20:04 -0700, Andrew Morton wrote:
> > I think arch code should do it before calling start_kernel(), really.
> > It's
> > just such a basic part of the kernel framework.
> 
> Hmm ... well, getting at current_thread_info()->cpu is possible, but
> nasty to audit, I would have thought (given that we're in assembler
> before start_kernel is called).

Well.  It's the assembly code which chose to call start_kernel().  It could
call something else.

> > A less wholesome but perhaps simpler solution would be to call the new
> > setup_smp_processor_id() on entry to start_kernel().
> 
> I was wondering about simply replacing boot_cpu_init() with
> smp_prepare_boot_cpu().  By and large they do the same thing on most
> archs, and mostly they don't seem to depend on setup_arch() having been
> called.

That won't fix the other bugs - we're presently calling printk() prior to
setup_arch(), and printk uses smp_procesor_id().

> However, introducing setup_smp_processor_id() will also work ... I'll
> see if I can do it in an easy way.

It's a bit odd - I think non-zero BSPs happen a bit more often than
only-on-voyager.
