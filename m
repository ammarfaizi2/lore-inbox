Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425415AbWLHLnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425415AbWLHLnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425414AbWLHLnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:43:07 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:2646 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425412AbWLHLnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:43:03 -0500
Subject: Re: [RFC][PATCH] Pseudo-random number generator
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200612071943.14153.arnd@arndb.de>
References: <1164979155.5882.23.camel@bender>
	 <200612071606.33951.arnd@arndb.de> <1165504796.5607.17.camel@bender>
	 <200612071943.14153.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 12:42:15 +0100
Message-Id: <1165578135.5343.15.camel@bender>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 19:43 +0100, Arnd Bergmann wrote:
> On Thursday 07 December 2006 16:19, Jan Glauber wrote:
> > Hm, why is /dev/urandom implemented in the kernel?
> > 
> > It could be done completely in user-space (like libica already does)
> > but I think having a device node where you can read from is the simplest
> > implementation. Also, if we can solve the security flaw we could use it
> > as replacement for /dev/urandom.
> 
> urandom is more useful, because can't be implemented in user space at
> all. /dev/urandom will use the real randomness from the kernel as a seed
> without depleting the entropy pool. How does your /dev/prandom device
> compare to /dev/urandom performance-wise? If it can be made to use
> the same input data and it turns out to be significantly faster, I can
> see some use for it.

The performance of the PRNG without constantly adding entropy is up tp
factor 40 faster than /dev/urandom ;- , depending on the block size of
the read.

With the current patch it performs not so well because of the STCKE loop
before every KMC. I think about removing them and changing the
periodically seed to use get_random_bytes instead.

Jan

