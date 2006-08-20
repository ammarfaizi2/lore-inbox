Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWHTUlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWHTUlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWHTUlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:41:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751211AbWHTUlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:41:12 -0400
Subject: Re: [PATCH] introduce kernel_execve function to replace
	__KERNEL_SYSCALLS__
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>,
       Arnd Bergmann <arnd@arndb.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20060820203604.GD11843@atjola.homenet>
References: <20060819073031.GA25711@atjola.homenet>
	 <200608201237.13194.chase.venters@clientec.com>
	 <20060820112523.f14fc6dc.akpm@osdl.org>
	 <200608201333.02951.chase.venters@clientec.com>
	 <20060820194552.GB11843@atjola.homenet>
	 <1156103446.23756.60.camel@laptopd505.fenrus.org>
	 <20060820201118.GC11843@atjola.homenet>
	 <1156105229.23756.65.camel@laptopd505.fenrus.org>
	 <20060820203604.GD11843@atjola.homenet>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Sun, 20 Aug 2006 22:40:41 +0200
Message-Id: <1156106442.23756.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 22:36 +0200, Björn Steinbrink wrote:
> On 2006.08.20 22:20:28 +0200, Arjan van de Ven wrote:
> > On Sun, 2006-08-20 at 22:11 +0200, Björn Steinbrink wrote:
> > > On 2006.08.20 21:50:46 +0200, Arjan van de Ven wrote:
> > > > \
> > > > > Could we rename __syscall_return to IS_SYS_ERR (or whatever) and force
> > > > > kernel syscall users to do the check? That way we could eliminate errno
> > > > 
> > > > s/users/user/ .. there's one left that should die out soon ;)
> > > > 
> > > 
> > > Only one in unistd.h, but throughout the kernel there are quite a few
> > > unless I'm missing something here:
> > > doener@atjola:~/src/kernel/linux-2.6$ grep \ _syscall * -R | \
> > > > grep -v define\\\|undef\\\|clobber | wc -l
> > > 116
> > > 
> > > Are these just going to be replaced by calls to sys_whatever?
> > 
> > they're not the users of this, they're the definitions... ;)
> 
> Well, I assume that if some code defines a syscall, it will actually use
> it. Of course I meant to ask if the users of those definitions are going
> to just call sys_whatever.
> For example check_host_supports_tls in arch/um/os-Linux/sys-i386/tls.c
> which even uses the global errno (although in that case the whole
> else part could probably be just removed).

um uses glibc, and is thus special.. lets ignore that ;)
(really, it's an entire different beast in this regard)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

