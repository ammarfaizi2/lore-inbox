Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUF1WVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUF1WVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUF1WVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:21:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:55987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265261AbUF1WVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:21:18 -0400
Date: Mon, 28 Jun 2004 15:20:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pat Gefre <pfg@sgi.com>
Cc: pfg@sgi.com, erikj@subway.americas.sgi.com, rmk+lkml@arm.linux.org.uk,
       cw@f00f.org, hch@infradead.org, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-Id: <20040628152000.4b7665c6.akpm@osdl.org>
In-Reply-To: <Pine.SGI.3.96.1040628170609.36430N-100000@fsgi900.americas.sgi.com>
References: <20040628121312.75ac9ed7.akpm@osdl.org>
	<Pine.SGI.3.96.1040628170609.36430N-100000@fsgi900.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Gefre <pfg@sgi.com> wrote:
>
> On Mon, 28 Jun 2004, Andrew Morton wrote:
> 
> + Pat Gefre <pfg@sgi.com> wrote:
> + >
> + > We think we should stick with the major/minor set we have proposed.  We
> + >  don't like hacking the 8250 code, dynamic allocation doesn't work (once
> + >  that works we will update our driver to use it), registering for our
> + >  own major/minor may not work (if we DO get one we will update the
> + >  driver to reflect it) but in the meantime we need to get something in
> + >  the community that works.
> + 
> + "we don't like" isn't a very strong argument ;)
> + 
> + It does sound to me like some work is needed in the generic serial layer to
> + teach it to get its sticky paws off the ttyS0 major/minor if there is no
> + corresponding hardware.  AFAICT nobody has scoped out exactly what has to
> + be done for a clean solution there - it may not be very complex.  So could
> + we please explore that a little further?
> + 
> + If that proves to be impractical for some reason then I'd be inclined to
> + allocate a new misc minor, stick it in devices.txt and be done with it.
> 
> I'm not sure I understand what you mean by this. Use a different major
> (one that is likely to not be used by anyone else on our system) and a
> minor that no one is assigned ?
> 

Or use dynamic allocation.  I'm trying to understand why early-boot code
needs to know the major/minor when it will be accessing the driver via
/dev/console anyway.

