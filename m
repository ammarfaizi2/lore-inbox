Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVDNIMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVDNIMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVDNIMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:12:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:36111 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261457AbVDNIMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:12:19 -0400
Date: Thu, 14 Apr 2005 18:08:37 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Matt Mackall <mpm@selenic.com>, Andreas Steinmetz <ast@domdv.de>,
       rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414080837.GA1264@gondor.apana.org.au>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz> <20050413233904.GA31174@gondor.apana.org.au> <20050413234602.GA10210@elf.ucw.cz> <20050414003506.GQ25554@waste.org> <20050414065124.GA1357@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414065124.GA1357@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 08:51:25AM +0200, Pavel Machek wrote:
>
> > This solution is all wrong.
> > 
> > If you want security of the suspend image while "suspended", encrypt
> > with dm-crypt. If you want security of the swap image after resume,
> > zero out the portion of swap used. If you want both, do both.

Pavel, you're not answering our questions.

How is the proposed patch any more secure compared to swsusp over dmcrypt?

In fact if anything it is less secure.  If I understand correctly the
proposal is to store the key used to encrypt the swsusp image in the
swap device.  This means that anybody who gains access to the swap
device can trivially decrypt it.

Compare this to the properly setup dmcrypt case where the swap
device can only be decrypted with a passphrase obtained from the
user at resume time.

> I want security of the swap image, and "just zeroing" is hard to do in
> failed suspend case, see previous discussion.

As to the failed suspend case, the two approaches yield identical
results.  In both cases we will be storing potentially sensitive
data encrypted on a physical storage device.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
