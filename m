Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUJRL72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUJRL72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 07:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUJRL7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 07:59:07 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:62340 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S266308AbUJRL6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 07:58:55 -0400
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - intro
From: Daniele Pizzoni <auouo@tin.it>
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041018103633.GA6792@elte.hu>
References: <1098031764.3023.45.camel@pdp11.tsho.org>
	 <20041017161953.GA24810@elte.hu> <1098067288.2892.293.camel@pdp11.tsho.org>
	 <20041018103633.GA6792@elte.hu>
Content-Type: text/plain
Message-Id: <1098104383.3024.44.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 14:59:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2004-10-18 at 12:36, Ingo Molnar wrote:
> 
> ok - pr_debug() is ok i think for the APIC code. It pairs well with the
> other variants: pr_notice(), etc.
> [...] 
> i'd suggest to first do the Dprintk -> pr_debug replacement patch with
> as few output changes as possible. (output changes are unavoidable when
> converting a \n-less printout.) Then do any format cleanups in a
> separate patch.

Look, there is no pr_notice at all. The whole thing is not very clear I
think, and the pr_ macros have some problem.

This is the kernel.h part regarding the two and only pr_debug and
pr_info:

#ifdef DEBUG
#define pr_debug(fmt,arg...) \
printk(KERN_DEBUG fmt,##arg)
#else
#define pr_debug(fmt,arg...) \
do { } while (0)
#endif

#define pr_info(fmt,arg...) \
printk(KERN_INFO fmt,##arg)

I think that pr_debug does make sense, because it depends on DEBUG and
is a useful macro uniforming all the DPRINTK usage.

pr_info is alone, there are no other pr_*. I used it in the patches but
now I think I was wrong. You cannot "continue" a pr_info as you do with
printk because it always inserts the loglevel tag. I think it's better
not use it or find a better solution. In fact it is not used too much in
the kernel.

I'll try some strict dprintk -> pr_debug replacements.

Bye
Daniele


