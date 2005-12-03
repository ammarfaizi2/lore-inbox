Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVLCPLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVLCPLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVLCPLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:11:17 -0500
Received: from pat.uio.no ([129.240.130.16]:12477 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751272AbVLCPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:11:17 -0500
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00e501c5f809$99c70bc0$0400a8c0@dcccs>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs>
	 <1133481721.9597.37.camel@lade.trondhjem.org>
	 <00e501c5f809$99c70bc0$0400a8c0@dcccs>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 10:11:03 -0500
Message-Id: <1133622663.7911.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.768, required 12,
	autolearn=disabled, AWL 1.04, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 14:00 +0100, JaniD++ wrote:

> Here is the strace-s output:     (20KB)
> http://download.netcenter.hu/bughunt/20051203/adduser.log
> 
> This problem is always on on 2.6.15-rc3, and newer on 2.6.14.2

OK... Looks like it is bailing out after the lines

link("/etc/passwd.2522", "/etc/passwd.lock") = 0
stat64("/etc/passwd.2522", {st_mode=S_IFREG|0600, st_size=5, ...}) = 0

I'll bet the stat64 is filing to show that the file now has 2 links.

As a first step, could you please grab the 2 patches

  http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-01-nfs-cache-init.dif
and
  http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-02-fix_cache_consistency.dif

and see if they fix the problem?

Cheers,
  Trond

