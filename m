Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWA2Qip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWA2Qip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 11:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWA2Qip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 11:38:45 -0500
Received: from pat.uio.no ([129.240.130.16]:24003 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751071AbWA2Qip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 11:38:45 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060129113320.GA21386@hardeman.nu>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com>
	 <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Sun, 29 Jan 2006 11:38:22 -0500
Message-Id: <1138552702.8711.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.052, required 12,
	autolearn=disabled, AWL 1.76, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 12:33 +0100, David Härdeman wrote:

> >Why would you want to use proxy certificates for you own use? Use your
> >own certificate for your own processes, and issue one or more proxy
> >certificates to any daemon that you want to authorise to do some limited
> >task.
> 
> I meant that you can't use proxy certs for your own use, so you still need 
> to store your own cert/key somehow...and I still believe that the kernel 
> keyring is the best place...

Agreed. Now, reread what I said above, and tell me why this is an
argument for doing dsa in the kernel?

> >...and what does this statement about "keys being safer in the kernel"
> >mean?
> 
> swap-out to disk, ptrace, coredump all become non-issues. And in 
> combination with some other security features (such as disallowing 
> modules, read/write of /dev/mem + /dev/kmem, limited permissions via
> SELinux, etc), it becomes pretty hard for the attacker to get your 
> private key even if he/she manages to get access to the root account.

Turning off coredump is trivial. All the features that LSM provide apply
to userland too (including security_ptrace()), so the SELinux policies
are not an argument for putting stuff in the kernel.

Only the swap-out to disk is an issue, and that is less of a worry if
you use a time-limited proxy in the daemon.

> >> Further, the mpi and dsa code can also be used for supporting signed 
> >> modules and binaries...the "store dsa-keys in kernel" part adds 376 
> >> lines of code (counted with wc so comments and includes etc are also 
> >> counted)...
> >
> >Signed modules sounds like a better motivation, but is a full dsa
> >implementation in the kernel really necessary to achieve this?
> 
> How would you do it otherwise?

Has anyone tried to look for simpler signing mechanisms that make use of
the crypto algorithms that are already in the kernel?

Cheers,
  Trond

