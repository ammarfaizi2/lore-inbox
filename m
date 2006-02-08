Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbWBHUkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbWBHUkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWBHUkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:40:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48353 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030612AbWBHUkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:40:17 -0500
Date: Wed, 8 Feb 2006 20:40:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] fstatat64 support
Message-ID: <20060208204015.GA25477@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Drepper <drepper@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200602082008.k18K8dqE026598@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602082008.k18K8dqE026598@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 03:08:39PM -0500, Ulrich Drepper wrote:
> The *at patches introduced fstatat and, due to inusfficient research, I
> used the newfstat functions generally as the guideline.  The result is
> that on 32-bit platforms we don't have all the information needed to
> implement fstatat64.
> 
> This patch modifies the code to pass up 64-bit information if
> __ARCH_WANT_STAT64 is defined.  I renamed the syscall entry point to
> make this clear.  Other archs will continue to use the existing code.
> On x86-64 the compat code is implemented using a new sys32_ function.
> this is what is done for the other stat syscalls as well.
> 
> 
> This patch might break some other archs (those which define
> __ARCH_WANT_STAT64 and which already wired up the syscall).  Yet
> others might need changes to accomodate the compatibility mode.
> I really don't want to do that work because all this stat handling
> is a mess (more so in glibc, but the kernel is also affected).  It
> should be done by the arch maintainers.  I'll provide some
> stand-alone test shortly.  Those who are eager could compile glibc
> and run 'make check' (no installation needed).

please remove the new from the syscall name.  just sys_fstatat64

