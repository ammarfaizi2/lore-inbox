Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWA2Uwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWA2Uwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWA2Uwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:52:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11212 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750983AbWA2Uwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:52:43 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Arjan van de Ven <arjan@infradead.org>
To: Steve French <smfrench@austin.rr.com>
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <43DD2010.7010700@austin.rr.com>
References: <1138312694656@2gen.com> <1138312695665@2gen.com>
	 <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
	 <1138504829.8770.125.camel@lade.trondhjem.org>
	 <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de>
	 <1138540148.3002.9.camel@laptopd505.fenrus.org>
	 <43DD2010.7010700@austin.rr.com>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 21:52:34 +0100
Message-Id: <1138567954.17148.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I don't know the right answer 
> for the particular math library question, but I have not seen the 
> typical argument considered about whether a user space implementation of 
> this paticular function could deadlock 

it's not that kind of thing. It's basically a public key encryption
step. Putting it in the kernel can only serve one purpose: to be there
to allow other parts to use this pke for encrypting/signing/verifying
signatures. 

The keyring stuff is in the kernel for three reasons:
1) to have a secure "vault" for keys, so that userspace doesn't need to
store secret keys and manage them securely; this requires that certain
operations on these keys also happen in the kernel
2) to make session management of keys easier. Yes you can do that in
userspace too but it's a mess (ssh-agent, while it works, isn't really
it)
3) to allow kernel pieces to do key things, like the secure nfs parts of
nfsv4 or ipsec.



