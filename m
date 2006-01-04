Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWADKTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWADKTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWADKTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:19:38 -0500
Received: from pat.uio.no ([129.240.130.16]:37793 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964972AbWADKTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:19:38 -0500
Subject: Re: __getname vs kmalloc
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060104063251.GA4263@filer.fsl.cs.sunysb.edu>
References: <20060104063251.GA4263@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 11:19:29 +0100
Message-Id: <1136369969.28640.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.951, required 12,
	autolearn=disabled, AWL 1.00, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 01:32 -0500, Josef Sipek wrote:
> Which is the prefered method of allocating memory __getname or kmalloc?

Depends entirely on the purpose. __getname uses the "names_cache" slab
and allocates PATH_MAX sized chunks. It is mainly supposed to be used
for temporary storage of an entire path.

> I looked at the source, and it appears to be used by 9p, smbfs, parts
> of VFS. In total there are only 10 calls to it.

Most callers use getname(), which also does the string length sanity
checks and then copies the path from userland memory.

Cheers,
  Trond

