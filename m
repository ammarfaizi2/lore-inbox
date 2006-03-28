Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWC1NhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWC1NhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWC1NhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:37:22 -0500
Received: from pat.uio.no ([129.240.10.6]:58068 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932192AbWC1NhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:37:18 -0500
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Edward Chernenko <edwardspec@yahoo.com>
Cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
In-Reply-To: <20060328101407.96598.qmail@web37710.mail.mud.yahoo.com>
References: <20060328101407.96598.qmail@web37710.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 08:36:30 -0500
Message-Id: <1143552990.8009.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.071, required 12,
	autolearn=disabled, AWL 1.74, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 02:14 -0800, Edward Chernenko wrote:
> --- Trond Myklebust <trond.myklebust@fys.uio.no>
> wrote:
> >
> > Justification, please.
> > 
> > You haven't even tried to explain to us what is so
> > broken about the
> > userland identd that it needs to be replaced with a
> > kernel version.
> > 
> 
> My point is that everything which follows this
> conditions should be moved into kernel:
>  - must dispatch requests in a fixed time
>  - must work rarely, sleep most time
>  - must depend on internal kernel variables (for
> example, established connections table)
> 
> Don't forget that many years ago there was echo daemon
> in userspace. But as it's highly effective to dispatch
> all echo requests in kernel, it was moved into
> low-level TCP implementation. 
> 
> I think that ident protocol also matches this
> criteria.

Most servers are designed for low latency. A lot of them sleep a lot,
and a fair number of them also go poking around the kernel variables
in /proc (which exists precisely in order to export internal kernel
variables to userspace programs). I'll bet even your average Oracle
database application fits those criteria.

Echo made sense to move into the kernel because in addition to the above
it is a required feature on all Internet hosts, is pretty much stateless
(and/or depends only on internal IP stack state), and needs extra low
latency because it is designed to be used for timing purposes by
clients.
The same criteria hardly apply to identd.

Cheers,
  Trond

