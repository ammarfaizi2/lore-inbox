Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVIZJZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVIZJZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbVIZJZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 05:25:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:13995 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750793AbVIZJZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 05:25:16 -0400
Date: Mon, 26 Sep 2005 02:24:45 -0700
From: Greg KH <gregkh@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: export ipl device parameters
Message-ID: <20050926092445.GA4791@suse.de>
References: <20050923095002.GA20928@osiris.boeblingen.de.ibm.com> <20050924004801.GB21283@suse.de> <20050926091537.GA10062@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926091537.GA10062@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 11:15:37AM +0200, Heiko Carstens wrote:
> Hi,
> 
> > > +#ifdef CONFIG_SYSFS
> > Does anyone build a s390 kernel without sysfs?  You can probably just
> > drop this ifdef.
> 
> Yes, you're right.
> 
> > > +DEFINE_IPL_ATTR(lun, "0x%016llx\n", (unsigned long long)
> > > +DEFINE_IPL_ATTR(bootprog, "%lld\n", (unsigned long long)
> > Why have a format field, if you only use the same format?
> 
> I use two different formats (hexadecimal and decimal).

Sorry, I was referring to the (unsigned long long) duplication there,
not the format field.

> > > +	__ATTR(device, S_IRUGO, ipl_device_show, NULL);
> > Why not use __ATTR_RO() like you did above?
> 
> The name of the attribute is supposed to be 'device'. If I would use
> __ATTR_RO it stringifies the first parameter and the result would be
> 'ipl_device' because of the function name I use.
> Otherwise I would have to rename my function, which is something I
> don't want to do. Somehow __ATTR_RO doesn't fit.

Ok, fair enough.

> > > +#define IPL_PARMBLOCK_ORIGIN	0x2000
> > You are just directly addressing memory with this address, right?
> 
> Yes.
> 
> > Shouldn't you iomap it or something first?
> 
> No, we don't have memory mapped IO on S390.

Neither do we on x86, yet we force everyone to use the proper function
calls, for when that code is then ported to other arches.  No reason
s390 should be alone with getting away from that :)

> How about this:
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Remove unnecessary ifdef + unused variable.

<snip>

Looks fine to me.

thanks,

greg k-h
