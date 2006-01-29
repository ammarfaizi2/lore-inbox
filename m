Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWA2V2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWA2V2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWA2V2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:28:40 -0500
Received: from pat.uio.no ([129.240.130.16]:25264 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751169AbWA2V2k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:28:40 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060129211310.GA20118@hardeman.nu>
References: <1138312695665@2gen.com>
	 <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>
	 <1138552702.8711.12.camel@lade.trondhjem.org>
	 <20060129211310.GA20118@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Sun, 29 Jan 2006 16:28:20 -0500
Message-Id: <1138570100.8711.63.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.146, required 12,
	autolearn=disabled, AWL 1.67, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 22:13 +0100, David Härdeman wrote:

> If you agree that the kernel keyring is the best place, it shouldn't be 
> a big step to also agree that in-kernel signing is "good" since it 
> allows you to use the key while it makes it possible for the kernel to 
> refuse to divulge the private part...even to the user who added the key 
> (i.e. yourself)...

No! I agree that the kernel keyring is a good place to keep keys because
it has been designed with the correct inheritance rules. I do not agree
with the above logic that the kernel is inherently safer than userland.

By the above logic, we should put libpam, openssl, kerberos, all login
programs, kdcs, etc all in the kernel. That will not happen!

> >>>...and what does this statement about "keys being safer in the kernel"
> >>>mean?
> >> 
> >> swap-out to disk, ptrace, coredump all become non-issues. And in 
> >> combination with some other security features (such as disallowing 
> >> modules, read/write of /dev/mem + /dev/kmem, limited permissions via
> >> SELinux, etc), it becomes pretty hard for the attacker to get your 
> >> private key even if he/she manages to get access to the root account.
> >
> >Turning off coredump is trivial. All the features that LSM provide apply
> >to userland too (including security_ptrace()), so the SELinux policies
> >are not an argument for putting stuff in the kernel.
> >
> >Only the swap-out to disk is an issue, and that is less of a worry if
> >you use a time-limited proxy in the daemon.
> 
> How do you use a "time-limited proxy in the daemon" for your own 
> keys/cerificates (e.g. ssh keys)?

I don't have to. Why are you apparently insisting on this weird fallacy
that a keyring can only hold one certificate at a time?

However if you want an example of how I can do this, just look to
kerberos. What is probably the world's most commonly used security
mechanism is entirely based on the concept of time-limited tickets. When
I log in, I get a TGT, which is a time-limited proxy ticket that allows
me to obtain more tickets without having to re-enter my password. This
again allows me to obtain "service tickets", i.e. time-limited proxies
with limited capabilities for any service that requires it.

Cheers,
  Trond

