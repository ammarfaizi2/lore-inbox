Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUBPDLD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUBPDLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:11:03 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:7334 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265329AbUBPDLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:11:00 -0500
Subject: Re: dm-crypt using kthread
From: Christophe Saout <christophe@saout.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Mike Christie <mikenc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <403031DF.9050506@pobox.com>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <20040216014433.GA5430@leto.cs.pocnet.net>  <4030268C.6050701@pobox.com>
	 <1076899244.5601.21.camel@leto.cs.pocnet.net>  <403031DF.9050506@pobox.com>
Content-Type: text/plain
Message-Id: <1076901031.5601.55.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 04:10:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Jeff Garzik um 03:58:

> >>>+		if ((i - bio->bi_idx) == (MIN_BIO_PAGES - 1))
> >>>+			gfp_mask = (gfp_mask | __GFP_NOWARN) & ~__GFP_WAIT;
> >>
> >>If the caller said they can wait, why not wait?
> > 
> > How can the caller say this?
> 
> There is a gfp_mask there :)

I still don't get it. :(
The caller is the crypt_map function which is called by dm which is
called by generic_make_request. There are no gfp_masks there.

> This sounds like a lot of work, just to reimplement what a semaphore 
> does for you :)

It sounds more complicated than it is...

In my very first version I used semaphores. I'm turning in circles. ;)

> There is typically one special case -- killing your thread on shutdown. 
>   The typical solution is to set a flag thread_shutdown, and then up().

I'm using the kthread primitives, kthread_stop kills the thread using a
signal.


