Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWHTTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWHTTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWHTTp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:45:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:58767 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751183AbWHTTpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:45:55 -0400
X-Authenticated: #5039886
Date: Sun, 20 Aug 2006 21:45:52 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060820194552.GB11843@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Chase Venters <chase.venters@clientec.com>,
	Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <200608201237.13194.chase.venters@clientec.com> <20060820112523.f14fc6dc.akpm@osdl.org> <200608201333.02951.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608201333.02951.chase.venters@clientec.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.20 13:32:39 -0500, Chase Venters wrote:
> On Sunday 20 August 2006 13:25, Andrew Morton wrote:
> > On Sun, 20 Aug 2006 12:36:49 -0500
> >
> > Chase Venters <chase.venters@clientec.com> wrote:
> > > Unless 'errno' has some significant reason to live on in the kernel, I
> > > think it would be better to kill it and write kernel syscall macros that
> > > don't muck with it.
> >
> > We have been working in that direction.  It's certainly something we'd like
> > to kill off.
> 
> Perhaps Arnd's patch is a good step in that direction then. A secondary 
> suggestion is to put a big comment there that explains "Yes, we know this is 
> ugly, it's going to die soon."
> 
> I'd also consider going so far as just returning -1 if we failed, since we 
> can't quite trust errno anyway.

Could we rename __syscall_return to IS_SYS_ERR (or whatever) and force
kernel syscall users to do the check? That way we could eliminate errno
and still provide the real error code to the code using the syscall.

Björn
