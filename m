Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVDNT1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVDNT1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVDNT1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:27:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:59050 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261602AbVDNT12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:27:28 -0400
Message-ID: <425EC41A.4020307@suse.de>
Date: Thu, 14 Apr 2005 21:27:22 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org>
In-Reply-To: <20050414171127.GL3174@waste.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> Any sensible solution here is going to require remembering passwords.
> And arguably anywhere the user needs encrypted suspend, they'll want
> encrypted swap as well.

But after entering the password and resuming, the encrypted swap is
accessible again and my ssh-key may be lying around in it, right?

So we would need to zero out the suspend image in swap to prevent the
retrieval of this data from the running machine (imagine a
remote-root-hole).

Zeroing out the suspend image means "write lots of megabytes to the
disk" which takes a lot of time.

The "encrypted suspend" case avoids this. It is absolutely useless for
the "machine is stolen while suspended" case, since the key for
decrypting the suspend image is stored in the suspend header (but
destroyed during resume).

We need both:
  - encrypted swap for the "stolen while suspended" case
  - encrypted suspend for "broken into after resume while still running"
    case.

i hope this helps...

Stefan
-- 
seife
                                 Never trust a computer you can't lift.
