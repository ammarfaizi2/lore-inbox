Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271183AbTGWRm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271185AbTGWRmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:42:25 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:40186 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271183AbTGWRmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:42:17 -0400
Subject: Re: kernel bug in socketpair()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Glenn Fowler <gsf@research.att.com>
Cc: davem@redhat.com, dgk@research.att.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <200307231656.MAA69129@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	 <20030723074615.25eea776.davem@redhat.com>
	 <200307231656.MAA69129@raptor.research.att.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058982641.5520.98.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 18:50:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 17:56, Glenn Fowler wrote:
> you can eliminate the security implications for all fd types by
> simply translating
> 	open("/dev/fd/N",...)
> to
> 	dup(atoi(N))
> w.r.t. fd N in the current process

This has very different semantics. Consider lseek().

> otherwise there is a bug in the /dev/fd/N -> /proc/self/fd/N implementation
> and /dev/fd/N should be separated out to its (original) dup(atoi(N))
> semantics

I don't see a bug. I see differing behaviour between Linux and BSD on a
completely non standards defined item. Also btw nobody ever really wrote
a /dev/fd/ for Linux - it was just a byproduct of the proc stuff someone
noticed. I guess someone could write a Plan-9 style dev/fd or devfdfs
for Linux if they wanted.

Alan

