Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVD1Oa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVD1Oa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVD1Oa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:30:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16608 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261562AbVD1Oau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:30:50 -0400
Date: Thu, 28 Apr 2005 09:30:30 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
Message-ID: <20050428143030.GC1023@austin.ibm.com>
References: <200504190318.32556.arnd@arndb.de> <200504280813.j3S8DNLc019256@post.webmailer.de> <20050428140558.GB1023@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428140558.GB1023@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:05:58AM -0500, Olof Johansson wrote:

> > +/* compute the hashed 6 bit index for the 4-way associative pte cache */
> > +static inline unsigned long
> > +get_ioc_hash(ioste iost_entry, unsigned long io_address)
> > +{
> > +	unsigned long iopte = get_ioptep(iost_entry, io_address);
> > +
> > +	return ((iopte & 0x000000000000001f8ul) >> 3)
> > +	     ^ ((iopte & 0x00000000000020000ul) >> 17)
> > +	     ^ ((iopte & 0x00000000000010000ul) >> 15)
> > +	     ^ ((iopte & 0x00000000000008000ul) >> 13)
> > +	     ^ ((iopte & 0x00000000000004000ul) >> 11)
> > +	     ^ ((iopte & 0x00000000000002000ul) >> 9)
> > +	     ^ ((iopte & 0x00000000000001000ul) >> 7);
> 
> Can't you reverse the subword by just doing one XOR instead of 6?

Ugh, I wrote that before I had coffee. No you can't, you can just negate
the value by doing the XOR. Nevermind.


-Olof
