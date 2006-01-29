Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWA2VqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWA2VqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWA2VqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:46:21 -0500
Received: from pat.uio.no ([129.240.130.16]:59075 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751181AbWA2VqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:46:21 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer
	maths	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: Dax Kelson <dax@gurulabs.com>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060129212915.GB20118@hardeman.nu>
References: <20060127204158.GA4754@hardeman.nu>
	 <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>
	 <1138552702.8711.12.camel@lade.trondhjem.org>
	 <406-SnapperMsg827D11E1C002BEC0@[70.7.65.98]>
	 <1138561846.8711.33.camel@lade.trondhjem.org>
	 <20060129212915.GB20118@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Sun, 29 Jan 2006 16:46:05 -0500
Message-Id: <1138571165.8711.76.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.148, required 12,
	autolearn=disabled, AWL 1.67, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 22:29 +0100, David Härdeman wrote:
> With your system, the signature of a "trusted" binary is embedded in the 
> kernel. Now, if a bug is found in said binary, you also get to compile 
> and install a new kernel along with a new binary.

If you compile a SHA-1 signature directly into the kernel, yes.
Alternatively, you could for instance allow it to be set once and only
once upon boot.

> Since the application is trusted, a security hole in the binary equals a 
> security hole in the kernel. In addition, you are bound to a given 
> kernel <-> userspace ABI, so if it has to be changed, you get to keep 
> several different trusted binaries around for different kernel versions 
> (/sbin/module-validate-v1 for ABI version 1, /sbin/module-validate-v2 
> for ABI version 2, etc).

See modprobe. We already have that sort of dependency.

> Further, how is the module actually verified? If the trusted binary 
> reads it and checks "something" (i.e. a signature), and then says it's 
> ok, what is to say that the module is not changed on-disk between the 
> time when the binary reads it and when the kernel does so (for instance 
> by direct access to the disk). How do you expect the system to provide 
> security if you are running with nfs-root?

You have to verify the module _after_ it has been loaded into the
kernel, but before any code has been run. No difference there between a
userspace and a kernel space solution.

> In addition you must protect the user-space binary against a slew of 
> attacks (you did statically link it to protect against LD_PRELOAD, right?).

I assume so.

> What exactly is the advantage of user-space trusted binary signing?

Umm... No unnecessary junk in the kernel when you are not loading in
modules? Greater possible choice of signing mechanisms? Support for
revoking signatures?

Cheers,
  Trond

