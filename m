Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWJKTpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWJKTpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWJKTpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:45:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161184AbWJKTpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:45:45 -0400
Date: Wed, 11 Oct 2006 12:39:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       eranian@hpl.hp.com, david.mosberger@acm.org
Subject: Re: [PATCH] Add carta_random32() library routine
Message-Id: <20061011123906.1f120324.akpm@osdl.org>
In-Reply-To: <452D4491.30806@garzik.org>
References: <200610111900.k9BJ01M4021853@hera.kernel.org>
	<452D4491.30806@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:22:57 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Linux Kernel Mailing List wrote:
> > commit e0ab2928cc2202f13f0574d4c6f567f166d307eb
> > tree 3df0b8e340b1a98cd8a2daa19672ff008e8fb7f9
> > parent b611967de4dc5c52049676c4369dcac622a7cdfe
> > author Stephane Eranian <eranian@hpl.hp.com> 1160554905 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> 1160590461 -0700
> > 
> > [PATCH] Add carta_random32() library routine
> > 
> > This is a follow-up patch based on the review for perfmon2.  This patch
> > adds the carta_random32() library routine + carta_random32.h header file.
> > 
> > This is fast, simple, and efficient pseudo number generator algorithm.  We
> > use it in perfmon2 to randomize the sampling periods.  In this context, we
> > do not need any fancy randomizer.
> 
> hrm, does this really warrant inclusion into every kernel build, on 
> every platform?
> 

probly not really.  But putting it into lib.a has problems, and making it a
loadable module has problems, and making it Kconfigurable has problems. 
And it's only 150-odd bytes.

It'd be better to just start to use it.  There are a number of callers of
get_random_bytes() who just don't need such fanciness (and degradation or
/dev/urandom), such as ext2/3/4's Orlov allocator. 
