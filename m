Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTINUqj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 16:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTINUqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 16:46:39 -0400
Received: from p508B7344.dip.t-dialin.net ([80.139.115.68]:28812 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP id S261328AbTINUqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 16:46:38 -0400
Date: Sun, 14 Sep 2003 22:46:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla1280 & __flush_cache_all
Message-ID: <20030914204632.GA25078@linux-mips.org>
References: <20030911075609.053a54ed.davem@redhat.com> <Pine.GSO.4.44.0309141410080.27187-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0309141410080.27187-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 02:11:45PM +0300, Meelis Roos wrote:

> > > Is __flush_cache_all an universal thing or just platform-specific?
> > > qla1280 seems to have started using it and it does not link on sparc64.
> > >
> > > *** Warning: "__flush_cache_all" [drivers/scsi/qla1280.ko] undefined!
> >
> > There is no reason a scsi driver should be invoking that interface.
> 
> So why is qla1280 in 2.6-current using __flush_cache_all?

Huh?

[ralf@dea linux-ci]$ grep -r __flush_cache_all drivers/scsi
[ralf@dea linux-ci]$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 0
EXTRAVERSION = -test5

You probably get this reference to __flush_cache_all() via the Sparc64
<asm/cacheflush.h>.  Still the cacheflushing in the driver is broken;
the routines in <asm/cacheflush.h> are meant only to maintain cache
coherency wrt. memory managment.

  Ralf
