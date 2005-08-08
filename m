Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVHHW67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVHHW67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHHW66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:58:58 -0400
Received: from pat.uio.no ([129.240.130.16]:43505 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932338AbVHHW65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:58:57 -0400
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 18:58:46 -0400
Message-Id: <1123541926.8249.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.203, required 12,
	autolearn=disabled, AWL 0.61, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 09.08.2005 Klokka 00:27 (+0200) skreiv Miklos Szeredi:
> I'd like to make my filesystem be able to do file creation and opening
> atomically.  This is needed for filesystems which cannot separate
> checking open permission from the actual open operation.
> 
> Usually any filesystem served from userspace by an unprivileged (no
> CAP_DAC_OVERRIDE) process will be such (ftp, sftp, etc.).
> 
> With nameidata->intent.open.* it is possible to do the actual open
> from ->lookup() or ->create().  However there's no easy way to
> associate the 'struct file *' returned by dentry_open() with the
> filesystem's private file object.  Also if there's some error after
> the file has been opened but before a successful return of the file
> pointer, the filesystem has no way to know that it should destroy the
> private file object.

We've already got a patch that does this, and that I'm queueing up for
inclusion. See

http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-63-open_file_intents.dif

As for the "orig flags" thing. What is the point of that?

Cheers,
  Trond

