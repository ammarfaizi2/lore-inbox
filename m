Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933287AbWKNCSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287AbWKNCSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933304AbWKNCSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:18:38 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28055 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933287AbWKNCSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:18:37 -0500
Message-ID: <455926C0.9080906@us.ibm.com>
Date: Mon, 13 Nov 2006 18:15:28 -0800
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, anton@samba.org, airlied@gmail.com,
       paulus@samba.org
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
References: <1163405790.4982.289.camel@localhost.localdomain> <20061113.163138.98554015.davem@davemloft.net>
In-Reply-To: <20061113.163138.98554015.davem@davemloft.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 13 Nov 2006 19:16:30 +1100
> 
>> X is still broken when built 32 bits on machines where PCI MMIO can be
>> above 32 bits space unfortunately. It looks like somebody (DaveM ?)
>> hacked a fix in X to handle long long resources and had the good idea
>> to wrap it in #ifdef __sparc__ :-(
> 
> Sorry, it was the only 32/64 platform at the time that old X code was
> written and the X maintainers at the time were unbelievably anal :-/
> 
> So the gist of your change is that X isn't obtaining BAR values
> in the correct context on powerpc, and so you're going to hack up
> the "devices" files output to "help" X out.
> 
> This doesn't sound sane to me.

It doesn't sound terribly sane to me.  What's wrong with just opening
/sys/bus/pci/devices/*/resource[0-5]?  It seems like that solves all the
problems.

> What sounds better to me is that X does the right thing, which is
> obtain the BAR from the PCI config space to determine what values to
> pass in to /proc/bus/pci mmap() calls.  And if it wants raw addresses
> to pass in to /dev/mem mmap()'s on platforms where that works (ie. not
> Sparc, to begin with) it should obtain those values from the "devices"
> file which must be values suitable as /dev/mem offsets.
> 
> I strongly look forward to Ian's new X code, that is for sure :-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWSbAX1gOwKyEAw8RAtceAKCc2PrYJNg8v2LcClLwTfEmo1aGzwCfRR7o
TkJnY+7IMpmWUQt/7FAW6A4=
=tDJc
-----END PGP SIGNATURE-----
