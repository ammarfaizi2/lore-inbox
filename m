Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVHFXwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVHFXwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVHFXwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 19:52:25 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:34712 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261356AbVHFXwY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 19:52:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hgHvCF48VwLSmETciVL/DaGvqUYFuSsfwWGo/EHUQv2vdSjZpzDDxoZpv+S2nqBJWbjSj8t6D3vO9o82hSnpRRVux1fnMK31+u977AXu5CeH6mpqJ1p3jMSYlAp4oF4T/hYQ/23GRe1XelomFwKbDKj+CFbF3LJhzK3DHQzSW5A=
Message-ID: <86802c4405080616526642fe39@mail.gmail.com>
Date: Sat, 6 Aug 2005 16:52:21 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Grant Grundler <iod00d@hp.com>
Subject: Re: [openib-general] Re: mthca and LinuxBIOS
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, linville@tuxdriver.com,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
In-Reply-To: <20050806043354.GA27352@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c4405080511079d01532@mail.gmail.com>
	 <86802c44050805112661d889aa@mail.gmail.com>
	 <86802c4405080512254b9cd496@mail.gmail.com>
	 <86802c4405080512451cdcae48@mail.gmail.com>
	 <86802c44050805132853070f1@mail.gmail.com>
	 <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org>
	 <20050805220015.GA3524@suse.de>
	 <Pine.LNX.4.58.0508051602350.3258@g5.osdl.org>
	 <20050805235937.GK25121@esmail.cup.hp.com>
	 <20050806043354.GA27352@esmail.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In LinuxBIOS internal structure for resource, We have index member in resource.

So the resource will be count from 0, ....7 or etc, but index member
will point to real BAR position.

I would like to see Kernel has simmliar definintion.
in LinuxBIOS
typedef uint64_t resource_t;
struct resource {
	resource_t base;	/* Base address of the resource */
	resource_t size;	/* Size of the resource */
	resource_t limit;	/* Largest valid value base + size -1 */
	unsigned long flags;	/* Descriptions of the kind of resource */
	unsigned long index;	/* Bus specific per device resource id */
	unsigned char align;	/* Required alignment (log 2) of the resource */
	unsigned char gran;	/* Granularity (log 2) of the resource */
	/* Alignment must be >= the granularity of the resource */
};



YH

On 8/5/05, Grant Grundler <iod00d@hp.com> wrote:
> On Fri, Aug 05, 2005 at 04:59:37PM -0700, Grant Grundler wrote:
> > ISTR making comments before about the offending patch on linux-pci mailing
> > list.  Is this the same patch that assumes pci_dev->resource[i] == BAR[i] ?
> 
> I meant the patch assume 1:1 for pci_dev->resource[i] and BAR[i].
> not that the two are equivalent.
> 
> grant
>
