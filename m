Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWHPXY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWHPXY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHPXY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:24:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:5564 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750824AbWHPXYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:24:25 -0400
Date: Wed, 16 Aug 2006 18:24:21 -0500
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, jeff@garzik.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       jklewis@us.ibm.com, Jens.Osterkamp@de.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816232421.GN20551@austin.ibm.com>
References: <44E38157.4070805@garzik.org> <20060816.134640.115912460.davem@davemloft.net> <200608162324.47235.arnd@arndb.de> <20060816.143203.11626235.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816.143203.11626235.davem@davemloft.net>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 02:32:03PM -0700, David Miller wrote:
> 
> The best schemes seem to be to interrupt mitigate using a combination
> of time and number of TX entries pending to be purged.  This is what
> most gigabit chips seem to offer.

I seem to be having a multi-hour delay for email delivery, so maybe
we've crossed emails.

A "low watermark interrupt" is an interrupt that is generated when
some queue is "almost empty". This last set of patches implement this
for the TX queue. The interrupt pops when 3/4ths of the packets 
in the queue have been processed.  Playing with ths setting
(3/4ths or some other number) seemed to make little difference.

> On Tigon3, for example, we tell the chip to interrupt if either 53
> frames or 150usecs have passed since the first TX packet has become
> available for reclaim.

The nature of a low-watermark interrupt is that it NEVER pops, as long
as the kernel keeps putting more stuff into the queue, so as to keep 
the queue at least 1/4'th full. I don't know how to mitigate interrupts 
more than that.

--linas
