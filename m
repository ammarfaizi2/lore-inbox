Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262090AbRFFG3L>; Wed, 6 Jun 2001 02:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbRFFG3C>; Wed, 6 Jun 2001 02:29:02 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:40718 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S262090AbRFFG2p>; Wed, 6 Jun 2001 02:28:45 -0400
Date: Tue, 5 Jun 2001 23:28:07 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proper perfect filter setup for xircom_tulip_cb.c 
In-Reply-To: <29308.991806934@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0106052317360.22593-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Keith Owens wrote:

> Nicely spotted.  The X3201-3 Software Specification says nothing about
> the segment bits for the filter, instead the information is tucked away
> in the 21143 PCI/CardBus 10/100Mb/s Ethernet LAN Controller Hardware
> Reference Manual.  So Xircom have a software specification manual that
> does not include the full software spec, oh the horrors.

If that were the only thing missing... At least I was able to catch it by 
simply being tidy -- I was going over the control bits to see which of 
them need to be/make sense to be set. 

But what about setting the hash (the imperfect filter)? The 21143 docs say
the *upper* 9 bits of the crc32 should be used; the Xircom docs are
completely silent, and the driver currently uses the *lower* 9 bits of the
crc32.

Oh, and for that matter, the hash is currently broken on the Xircom: 
unlike the 21143, the Xircom has 4 perfect filter slots in hash mode, not
one, but the driver ignores this fact. The hash layout is also severely
brain-damaged... I'll look into fixing it tomorrow -- by simply copying 
the fix from the patch I wrote for the other xircom driver (xircom_cb). :-)

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

