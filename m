Return-Path: <linux-kernel-owner+w=401wt.eu-S1754511AbWLRUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbWLRUHw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbWLRUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:07:52 -0500
Received: from pat.uio.no ([129.240.10.15]:44138 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511AbWLRUHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:07:51 -0500
Subject: Re: NFS Filesystem Size Limit?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612181419010.2396@p34.internal.lan>
References: <Pine.LNX.4.64.0612181419010.2396@p34.internal.lan>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 15:07:35 -0500
Message-Id: <1166472455.5742.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: 141.211.133.154 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 14:21 -0500, Justin Piszcz wrote:
> I have a question I could not quickly find on Google/mailing lists--
> 
> Say I have some sort of global filesystem or NFS which is 200TB.
> 
> Is there a limit either:
> 
> A) In the Linux kernel
> or
> B) In the NFS spec
> 
> That would limit the client as to what it could see via NFS or global 
> filesystem?

No.

> Or could both 2.4 and 2.6 kernels 'see' the 200TB global filesystem over 
> NFS or global filesystem?

'df' may or may not report the filesystem size correctly (depends on
whether you have VFS support for 64-bit filesystems enabled, and whether
or not you are using NFSv3 or above), but you should be able to store
200TB worth or data on it irrespective of that.

The one thing that may be limited is the size of individual files. The
NFSv2 protocol limits file sizes to 2GB, whereas NFSv3 and v4 should
allow you to read and write full 64-bit sized files.
Note though, that on most 32-bit hardware, the Linux VM design limits
you to 44-bit file sizes (due to the 32-bit page table + 4k page size).

Cheers
  Trond

