Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTLOUJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTLOUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:09:13 -0500
Received: from fmr06.intel.com ([134.134.136.7]:2723 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263914AbTLOUJC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:09:02 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: PCI Express support for 2.4 kernel
Date: Mon, 15 Dec 2003 12:08:43 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187B2@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Express support for 2.4 kernel
Thread-Index: AcPC869KyNNAvE84R36auTYVvkIBbgAUqVng
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Greg KH" <greg@kroah.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@redhat.com>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
X-OriginalArrivalTime: 15 Dec 2003 20:08:45.0265 (UTC) FILETIME=[3E597410:01C3C347]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/**
> > + * RRBAR (memory base for PCI-E config space) resides here.
> > + * Initialized to default address. Actually, it is platform
specific,
> and
> > + * value may vary.
> > + * I don't know how to detect it properly, it is chipset specific.
> > + */
> > +static u32 rrbar_phys=0xe0000000UL;

Sorry, this patch is not appropriate because it's hard coding this
chipset-specific address. The way of getting this address is being
defined by a public specification (I cannot tell which spec now). 

	Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Greg KH
> Sent: Monday, December 15, 2003 2:07 AM
> To: Kondratiev, Vladimir
> Cc: linux-kernel@vger.kernel.org; Alan Cox; Marcelo Tosatti
> Subject: Re: PCI Express support for 2.4 kernel
> 
> On Sun, Dec 14, 2003 at 10:00:49PM +0200, Vladimir Kondratiev wrote:
> > Please, ignore previous submission with the same subject. Patch file
> > attached was wrong one. Now correct patch attached.
> >
> > Hi,
> > PCI-Express platforms will soon appear on the market. It is worth to
> > support it.
> 
> Yes it is worth it, any chance to get access to hardware to test this
> out on?
> 
> > Following is patch for 2.4.23 kernel. I tested it on my host, it
works
> > properly.
> > I did it for i386 only, I have no other architecture to test.
> >
> > It was patch on the same subject from* Seshadri, Harinarayanan*
> > (/harinarayanan.seshadri@intel.com/
> > <mailto:harinarayanan.seshadri@intel.com>)
> > http://www.cs.helsinki.fi/linux/linux-kernel/2003-17/0247.html
> > My version differ in several aspects: it is for 2.4 (vs. 2.6); it do
not
> > ioremap/unmap page for each transaction.
> >
> > How about inclusion in 2.4.24?
> 
> No, we need to get this into 2.6 first.  Can you please forward port
> this to 2.6, clean up the formatting and address the issues everyone
> else has made so far and post it?
> 
> >  * command line argument "pci=exp" to force PCI Express, similar to
> "conf1" and "conf2"
> 
> We should be able to do this automatically, and not force this on the
> boot command line, correct?
> 
> > +/**
> > + * RRBAR (memory base for PCI-E config space) resides here.
> > + * Initialized to default address. Actually, it is platform
specific,
> and
> > + * value may vary.
> > + * I don't know how to detect it properly, it is chipset specific.
> > + */
> > +static u32 rrbar_phys=0xe0000000UL;
> 
> How about information on how to detect it as per chipset type?  We
need
> to do this automatically some how.
> 
> > +/**
> > + * Initializes PCI Express method for config space access.
> > + *
> > + * There is no standard method to recognize presence of PCI
Express,
> 
> Are you sure?  I thought there was (don't have my spec in front of me
> right now...)
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
