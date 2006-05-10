Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWEJQXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWEJQXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWEJQXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:23:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:17763 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965020AbWEJQXQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:23:16 -0400
X-IronPort-AV: i="4.05,110,1146466800"; 
   d="scan'208"; a="35191586:sNHT8217051808"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] fix pciehp compile issue when CONFIG_ACPI is notenabled.
Date: Wed, 10 May 2006 09:20:35 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4423939@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] fix pciehp compile issue when CONFIG_ACPI is notenabled.
Thread-Index: AcZy1ooahz1J+0n8TVO7H4eFA50XfQBds3OQ
From: "Moore, Robert" <robert.moore@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>, <greg@kroah.com>
X-OriginalArrivalTime: 10 May 2006 16:20:36.0046 (UTC) FILETIME=[AB3726E0:01C6744D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that we are saying that acpi_status should not be used
outside of ACPICA. After all, that is what most of the external ACPICA
interfaces use for the function return value.

It would probably be best, however, to limit the use of this type to
modules that actually interface directly with ACPICA.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Kristen Accardi
> Sent: Monday, May 08, 2006 12:40 PM
> To: Alexey Dobriyan
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; Brown,
Len;
> greg@kroah.com
> Subject: Re: [patch] fix pciehp compile issue when CONFIG_ACPI is
> notenabled.
> 
> On Mon, 2006-05-08 at 23:24 +0400, Alexey Dobriyan wrote:
> > On Mon, May 08, 2006 at 11:54:30AM -0700, Kristen Accardi wrote:
> > > Fix compile error when CONFIG_ACPI is not defined.
> >
> > > --- 2.6-git.orig/include/acpi/actypes.h
> > > +++ 2.6-git/include/acpi/actypes.h
> > > @@ -348,6 +348,7 @@ struct acpi_pointer {
> > >   * Mescellaneous types
> > >   */
> > >  typedef u32 acpi_status;	/* All ACPI Exceptions */
> > > +#define acpi_status acpi_status
> > >  typedef u32 acpi_name;		/* 4-byte ACPI name */
> > >  typedef char *acpi_string;	/* Null terminated ASCII string
*/
> > >  typedef void *acpi_handle;	/* Actually a ptr to a NS Node
*/
> >
> > The following in include/linux/pci-acpi.h is ugly
> >
> > 	#if !defined(acpi_status)
> > 	typedef u32             acpi_status;
> > 	#define AE_ERROR        (acpi_status) (0x0001)
> > 	#endif
> >
> > but you're adding more of it.
> 
> The actual solution to the problem is long.  acpi_status should not be
> used outside of acpi-ca.  However, it is.  In many, many places.  The
> real solution is to go around and re-write all the apis that export
> acpi_status to drivers, and then fix all the drivers which rely on
> acpi_status (and other acpi-caisms ).  This fix, while ugly, solves
the
> immediate problem in an expedient way.  However, I'm certainly open to
> suggestions about nicer ways to do it.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
