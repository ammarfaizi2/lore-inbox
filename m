Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFDLiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFDLiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 07:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVFDLiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 07:38:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36013 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261325AbVFDLiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 07:38:11 -0400
Date: Sat, 4 Jun 2005 12:38:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Ingo Oeser <ioe-lkml@axxeo.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] spinlock consolidation, v2
Message-ID: <20050604113809.GD19819@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjanv@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Ingo Oeser <ioe-lkml@axxeo.de>, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	"David S. Miller" <davem@redhat.com>
References: <20050603154029.GA2995@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603154029.GA2995@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 05:40:29PM +0200, Ingo Molnar wrote:
> 
> the latest version of the spinlock consolidation patch can be found at:
> 
>   http://redhat.com/~mingo/spinlock-patches/consolidate-spinlocks.patch
> 
> the patch is now complete in the sense that it does everything i wanted 
> it to do. If you have any other suggestions (or i have missed to 
> incorporate an earlier suggestion of yours), please yell.

Looks pretty nice, but your usage of asm-generic is totally wrong.
files in asm-generic must only ever be used for default implementations
of asm/ headers, and _never_ be included from common code.  But your
asm-generic files are only ever used from linux/spinlock.h, so there's
no point at all in splitting them out in the first time.
Similarly there's no point in a separate linux/spinlock_smp.h and
linux/spinlock_up.h - it'll only cause some driver writers to include
either of them directly and break the build for either UP or SMP.
If you absolutely want to split them add an #error if not included from
spinlock.h

Little nitpick no 2: please include linux/*.h always before asm/*.h
(in linux/jbd.h)
