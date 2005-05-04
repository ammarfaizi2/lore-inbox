Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVEDVfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVEDVfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVEDVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:33:57 -0400
Received: from hera.kernel.org ([209.128.68.125]:23700 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261666AbVEDVdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:33:44 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: System call v.s. errno
Date: Wed, 4 May 2005 09:03:07 -0700
Organization: Open Source Development Lab
Message-ID: <20050504090307.07c1c50a@dxpl.pdx.osdl.net>
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
	<20050504134224.GE17420@devserv.devel.redhat.com>
	<Pine.LNX.4.61.0505040948450.8903@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1115222587 14750 10.8.0.74 (4 May 2005 16:03:07 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 4 May 2005 16:03:07 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005 09:49:37 -0400 (EDT)
"Richard B. Johnson" <linux-os@analogic.com> wrote:

> On Wed, 4 May 2005, Jakub Jelinek wrote:
> 
> > On Wed, May 04, 2005 at 09:22:09AM -0400, Richard B. Johnson wrote:
> >> Does anybody know for sure if global 'errno' is supposed to
> >> be altered after a successful system call? I'm trying to
> >> track down a problem where system calls return with EINTR
> >> even though all signal handlers are set with SA_RESTART in
> >> the flags. It appears as though there may be a race somewhere
> >> because if I directly set errno to 0x1234, within a few
> >> hundred system calls, it gets set to EINTR even though all
> >> system calls seemed to return 'good'. This makes it
> >> hard to trace down the real problem.
> >
> > http://www.opengroup.org/onlinepubs/009695399/functions/errno.html
> > is very clear on this.  Unless indicated that errno is valid after a call
> > (for many syscalls it is valid when the syscall returns -1), errno has
> > unspecified value.
> >
> > 	Jakub
> > -
> 
> Okay, thanks. That means that it's okay for it to get trashed
> NotGood(tm) for debugging.
> 
> Cheers,
> Dick Johnson

Also, on with NPTL and many thread libraries errno is really a macro
that refers to a per-thread variable.

-- 
Stephen Hemminger	<shemminger@osdl.org>
