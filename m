Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWJ3TdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWJ3TdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030577AbWJ3TdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:33:25 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:56537 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1030559AbWJ3TdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:33:23 -0500
Subject: Re: splice blocks indefinitely when len > 64k?
From: Daniel Drake <ddrake@brontes3d.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: jens.axboe@oracle.com, linux-kernel@vger.kernel.org
In-Reply-To: <45464E67.7030004@cfl.rr.com>
References: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
	 <45464E67.7030004@cfl.rr.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 14:32:54 -0500
Message-Id: <1162236774.7280.38.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 14:11 -0500, Phillip Susi wrote:
> While it should not simply hang, the splice size needs to be an even 
> multiple of the page size.

I don't think that is true, at least on this level. Firstly, splice-cp
does this:

#define BS	SPLICE_SIZE
int this_len = min((off_t) BS, sb.st_size);
int ret = splice(in_fd, NULL, pfds[1], NULL, this_len, 0);

No considerations are made regarding page size.

Secondly, the problem still exists when I increase SPLICE_SIZE to
(128*1024)

Daniel

> Daniel Drake wrote:
> > Hi,
> > 
> > I'm experimenting with splice and have run into some unusual behaviour.
> > 
> > I am using the utilities in git://brick.kernel.dk/data/git/splice.git
> > 
> > In splice.h, when changing SPLICE_SIZE from:
> > 
> > #define SPLICE_SIZE (64*1024)
> > 
> > to
> > 
> > #define SPLICE_SIZE ((64*1024)+1)
> > 
> > splice-cp hangs indefinitely when copying files sized 65537 bytes or
> > more. It hangs on the first splice() call.
> > 
> > Is this a bug? I'd like to be able to copy much more than 64kb on a
> > single splice call.
> > 
> > Thanks!
> > Daniel
> 

