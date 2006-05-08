Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWEHTcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWEHTcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWEHTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:32:16 -0400
Received: from mga03.intel.com ([143.182.124.21]:34142 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750731AbWEHTcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:32:15 -0400
X-IronPort-AV: i="4.05,102,1146466800"; 
   d="scan'208"; a="33294134:sNHT4287730426"
Subject: Re: [patch] fix pciehp compile issue when CONFIG_ACPI is not
	enabled.
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com, greg@kroah.com
In-Reply-To: <20060508192431.GB7235@mipter.zuzino.mipt.ru>
References: <1147114470.3094.14.camel@whizzy>
	 <20060508192431.GB7235@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 May 2006 12:39:43 -0700
Message-Id: <1147117183.3094.16.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 08 May 2006 19:29:28.0461 (UTC) FILETIME=[B908F3D0:01C672D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 23:24 +0400, Alexey Dobriyan wrote:
> On Mon, May 08, 2006 at 11:54:30AM -0700, Kristen Accardi wrote:
> > Fix compile error when CONFIG_ACPI is not defined.
> 
> > --- 2.6-git.orig/include/acpi/actypes.h
> > +++ 2.6-git/include/acpi/actypes.h
> > @@ -348,6 +348,7 @@ struct acpi_pointer {
> >   * Mescellaneous types
> >   */
> >  typedef u32 acpi_status;	/* All ACPI Exceptions */
> > +#define acpi_status acpi_status
> >  typedef u32 acpi_name;		/* 4-byte ACPI name */
> >  typedef char *acpi_string;	/* Null terminated ASCII string */
> >  typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
> 
> The following in include/linux/pci-acpi.h is ugly
> 
> 	#if !defined(acpi_status)
> 	typedef u32             acpi_status;
> 	#define AE_ERROR        (acpi_status) (0x0001)
> 	#endif
> 
> but you're adding more of it.

The actual solution to the problem is long.  acpi_status should not be
used outside of acpi-ca.  However, it is.  In many, many places.  The
real solution is to go around and re-write all the apis that export
acpi_status to drivers, and then fix all the drivers which rely on
acpi_status (and other acpi-caisms ).  This fix, while ugly, solves the
immediate problem in an expedient way.  However, I'm certainly open to
suggestions about nicer ways to do it.
