Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVCHMoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVCHMoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCHMoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:44:11 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55789 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262045AbVCHMnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:43:11 -0500
Date: Tue, 8 Mar 2005 16:07:47 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
 2.6
Message-ID: <20050308160747.2ffc842c@zanzibar.2ka.mipt.ru>
In-Reply-To: <ACAE2383-8FCC-11D9-A2CF-000393ACC76E@mac.com>
References: <11102278521318@2ka.mipt.ru>
	<1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
	<20050308123714.07d68b90@zanzibar.2ka.mipt.ru>
	<ACAE2383-8FCC-11D9-A2CF-000393ACC76E@mac.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 15:41:50 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 07:22:01 -0500
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On Mar 08, 2005, at 04:37, Evgeniy Polyakov wrote:
> >>
> >> Did you include support for the new key/keyring infrastructure
> >> introduced a couple versions ago by David Howells?  It allows
> >> user-space to create and manage various sorts of "keys" in
> >> kernel-space.  If you create and register a few keytypes for
> >> various symmetric and asymmetric ciphers, you could then take
> >> advantage of its support for securely passing keys around in
> >> and out of userspace.
> >
> > As far as I know, it has different destination - for example
> > asynchronous block device, which uses acrypto in one of it's
> > filters, may use it.
> 
> I'm not exactly familiar with asynchronous block device, but I'm
> guessing that it would need to get its crypto keys from the user
> somehow, no?  If so, then the best way of managing them is via
> the key/keyring infrastructure.  From the point of view of other
> kernel systems, it's basically a set of BLOB<=>task associations
> that supports a reasonable inheritance and permissions model.

Yes, it is exactly how block device, not crypto layer, may operate,
but it has very limited usage for block devices in given model,
when it only encrypts storage.

Above setup may be implemeted for the userspace/kernelspace application,
which requires continuous access to the key material from 
the both sides, but asynchronous block device
(and existing cryptoloop and dm-crypt) use diferent model, when
controlling userspace application only one time provides 
required key material(using ioctl) and exits, but key material
remains in kernelspace in device's private area.

> Cheers,
> Kyle Moffett
> 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
> L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
> PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
> !y?(-)
> ------END GEEK CODE BLOCK------
> 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
