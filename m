Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVDNIdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDNIdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDNIdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:33:20 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:61821 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261468AbVDNIbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:31:20 -0400
Date: Thu, 14 Apr 2005 01:31:19 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Steinmetz <ast@domdv.de>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: encrypted swap (was Re: [PATCH encrypted swsusp 1/3] core functionality)
Message-ID: <20050414083119.GB24892@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413233904.GA31174@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 09:39:04AM +1000, Herbert Xu wrote:
> > Andreas is right. They are encrypted in swap, but they should not be
> > there at all. And they are encrypted by key that is still available
> > after resume. Bad.
> 
> The dmcrypt swap can only be unlocked by the user with a passphrase,
> which is analogous to how you unlock your ssh private key stored
> on the disk using a passphrase.

Does dmcrypt have a simple operation mode like OpenBSD's encrypted swap?
I want to be able to 'sysctl -w kernel.swap_crypt=1' and get

 * pages are encrypted as they're written to swap
 * the key is automatically regenerated every 2 hours (or whatever); as
   pages encrypted under the old key age out, it can be freed eventually
 * I don't have to manage keys, choose algorithms, futz with /etc/fstab,
   figure out complex configs for /dev/loopN, etc

In fact, I want swap_crypt=1 to be the default (you can turn it off for
embedded systems if you want), but giving me an easy knob is a good
start for 2.6.

Everything I've seen makes me think that configuring dmcrypt is hard.
Don't make users make useless choices.  Sure, there are cases where the
complexity is warranted, but please make the 90% solution easy.

-andy
