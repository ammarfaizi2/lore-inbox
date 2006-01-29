Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWA2XHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWA2XHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWA2XHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:07:51 -0500
Received: from pat.uio.no ([129.240.130.16]:19621 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751208AbWA2XHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:07:50 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1BE90924-C4BF-4123-AF20-88655772C8BF@mac.com>
References: <20060127204158.GA4754@hardeman.nu>
	 <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu>
	 <1138552702.8711.12.camel@lade.trondhjem.org>
	 <20060129211310.GA20118@hardeman.nu>
	 <1138570100.8711.63.camel@lade.trondhjem.org>
	 <20060129220217.GA21832@hardeman.nu>
	 <1138572311.8711.84.camel@lade.trondhjem.org>
	 <1BE90924-C4BF-4123-AF20-88655772C8BF@mac.com>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 18:07:30 -0500
Message-Id: <1138576051.8711.123.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.149, required 12,
	autolearn=disabled, AWL 1.66, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 17:54 -0500, Kyle Moffett wrote:
> You keep mentioning proxy certificates.  So you are saying that when  
> I pass the key to some daemon to which I do not want it to have  
> permanent access, I should create a proxy certificate to pass  
> instead?  This _vastly_ increases the amount of math that needs to be  
> done.  Instead of just using my private key to encrypt data, I would  
> need to generate a new private key with the required encryption  
> strength, generate a proxy certificate, sign the proxy certificate  
> with the old private key, keep track of revocation lists somehow (how  
> do I reliably expire a proxy certificate on-demand everywhere it  
> might be without a web-server hosting the CRLs?), _then_ I can  
> finally encrypt my data with the proxy certificate.  I think this  
> qualifies as a serious performance problem, especially if I'm opening  
> and closing lots of SSH tunnels, like running remote commands on  
> every system in a cluster.

Feel free to profile it. I challenge you to find a real-life application
where the above is actually a performance problem.

> If we use this proposed in-kernel system, then I can give my  
> certificate/pubkey to the kernel code, and then my web browser, SSH,  
> and anything else can automatically use it to decrypt and sign data  
> without being able to directly access (and thus compromise) the key.   
> If I later notice what I think might be a rogue process, I can  
> instantly and globally revoke all access to that keypair.

The latter is something you can do with keyrings anyway. As for the
former, that too is completely solvable in userspace. For instance, CITI
has a scheme for issuing X509 proxy certificates given a kerberos key.
ssh can log you in automatically given the same kerberos key,...

This sort of problem is simply not a reason for sticking dsa into the
kernel.

Cheers,
  Trond

