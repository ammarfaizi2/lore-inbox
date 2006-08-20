Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWHTPyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWHTPyf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWHTPyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:54:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9119 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750823AbWHTPyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:54:35 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Arjan van de Ven <arjan@infradead.org>
To: Solar Designer <solar@openwall.com>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820153037.GA20007@openwall.com>
References: <20060820003840.GA17249@openwall.com>
	 <20060820100706.GB6003@steel.home>  <20060820153037.GA20007@openwall.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 17:53:22 +0200
Message-Id: <1156089203.23756.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 19:30 +0400, Solar Designer wrote:
> On Sun, Aug 20, 2006 at 12:07:06PM +0200, Alex Riesen wrote:
> > Solar Designer, Sun, Aug 20, 2006 02:38:40 +0200:
> > > Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> > > set*uid() kill the current process rather than proceed with -EAGAIN when
> > > the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> > > and return anyway due to properties of the allocator, in which case the
> > > patch does not change a thing.  But better safe than sorry.
> > 
> > Why not ENOMEM?
> 
> ENOMEM would not be any better than EAGAIN from the security standpoint.
> 
> The problem is that there are lots of privileged userspace programs that
> do not bother to check the return value from set*uid() calls (or
> otherwise check that the calls succeeded) before proceeding with work
> that is only safe to do with the *uid switched as intended.

sounds like a good argument to get the setuid functions marked
__must_check in glibc...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

