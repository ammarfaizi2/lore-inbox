Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266787AbUFYQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266787AbUFYQZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266789AbUFYQZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:25:53 -0400
Received: from gprs214-83.eurotel.cz ([160.218.214.83]:50560 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266787AbUFYQZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:25:52 -0400
Date: Fri, 25 Jun 2004 18:25:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Amit Gud <gud@eth.net>, alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040625162537.GA6201@elf.ucw.cz>
References: <004e01c45abd$35f8c0b0$b18309ca@home> <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Case closed, anyway. It belongs in the kernel only if there is no
> reasonable way to do it in userspace.

But... there's no reasonable way to do this in userspace.

Two pieces of kernel support are needed:

1) some way to indicate "this file is elastic" (okay perhaps xattrs
can do this already)

and either

2a) file selection/deletion in kernel

or

2b) assume that disk does not fill up faster than 1GB/sec, allways
keep 1GB free, make "deleting" daemon poll each second [ugly,
unreliable]

or

2c) just before returning -ENOSPC, synchronously tell userspace to
free space, and retry the operation.

BTW 2c) would be also usefull for undelete. Unfortunately 2c looks
very complex, too; it might be easier to do 2a than 2c.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
