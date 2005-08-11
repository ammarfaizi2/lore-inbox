Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVHKIOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVHKIOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVHKIOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:14:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:62951 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932290AbVHKIOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:14:17 -0400
Date: Thu, 11 Aug 2005 10:14:15 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, peterc@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <17146.43490.8672.13906@wombat.chubb.wattle.id.au>
Subject: =?ISO-8859-1?Q?Re:_fcntl(F_GETLEASE)_semantics=3F=3F?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <19888.1123748055@www44.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Peter Chubb <peterc@gelato.unsw.edu.au>
> 
> >>>>> "Trond" == Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> Trond> to den 11.08.2005 Klokka 09:48 (+1000) skreiv Peter Chubb:
> >> Hi, The LTP test fcntl23 is failing.  It does, in essence, fd =
> >> open(xxx, O_RDWR|O_CREAT, 0777); if (fcntl(fd, F_SETLEASE, F_RDLCK)
> >> == -1) fail;
> >> 
> >> fcntl always returns EAGAIN here.  The manual page says that a read
> >> lease causes notification when `another process' opens the file for
> >> writing or truncates it.  The kernel implements `any process'
> >> (including the current one).
> >> 
> >> Which semantics are correct?  Personally I think that what the
> >> kernel implements is correct (you can't get a read lease unsless
> >> there are no writers _at_ _all_)
> 
> Trond> A read lease should mean that there are no writers at all.
> 
> Trond> If we were to allow the current process to open for write, then
> Trond> that would still mean that nobody else can get a lease. In
> Trond> effect you have been granted a lease with exclusive semantics
> Trond> (i.e. a write lease). You might as well request that instead of
> Trond> pretending it is a read lease.
> 
> So the manual page is wrong.  Fine.

No.  The behavior in Linux recently, and arbitrarily (IMO) changed:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111502547506310&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=111755426027086&w=2

One of the developers of the file leases mechanism seems to have 
agreed that this change should not have occurred:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111512619520116&w=2

but the suggested patch did not (yet) make its way into the kernel.

Stephen -- what is your take on this now?

Cheers,

Michael

-- 
GMX DSL = Maximale Leistung zum minimalen Preis!
2000 MB nur 2,99, Flatrate ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
