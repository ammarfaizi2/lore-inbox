Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271199AbTGWTRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271229AbTGWTPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:15:22 -0400
Received: from H-135-207-24-16.research.att.com ([135.207.24.16]:30606 "EHLO
	linux.research.att.com") by vger.kernel.org with ESMTP
	id S271224AbTGWTOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:14:08 -0400
Date: Wed, 23 Jul 2003 15:29:03 -0400 (EDT)
From: Glenn Fowler <gsf@research.att.com>
Message-Id: <200307231929.PAA77754@raptor.research.att.com>
Organization: AT&T Labs Research
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
References: <200307231428.KAA15254@raptor.research.att.com>  <20030723074615.25eea776.davem@redhat.com>  <200307231656.MAA69129@raptor.research.att.com>  <20030723100043.18d5b025.davem@redhat.com>  <200307231724.NAA90957@raptor.research.att.com>  <20030723103135.3eac4cd2.davem@redhat.com>  <200307231814.OAA74344@raptor.research.att.com>  <20030723112307.5b8ae55c.davem@redhat.com>  <200307231854.OAA90112@raptor.research.att.com>  <20030723120457.206dc02d.davem@redhat.com>  <200307231911.PAA35164@raptor.research.att.com> <20030723121436.10d53965.davem@redhat.com>
To: davem@redhat.com, gsf@research.att.com
Subject: Re: kernel bug in socketpair()
Cc: dgk@research.att.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jul 2003 12:14:36 -0700 David S. Miller wrote:
> I missed the reason why you can't use pipes and bash
> is able to, what is it?

we have some applications, ksh included, with semantics that require
stdin be read at most one line at a time; an inefficient implementation
of this does 1 byte read()s until newline is read; an efficient
implementation does a peek read (without advancing the read/seek offset),
determines how many chars to read up to and including the newline,
and then read()s that much

linux has ioctl(I_PEEK) for stream devices and recv() for sockets,
and neither of these work on pipes; if there is a linux alternative
for pipes then we'd be glad to use it

we switched from pipe() to socketpair() to take advantage of the linux
recv() peek read

