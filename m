Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267949AbUHEV3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267949AbUHEV3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267964AbUHEV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:27:13 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:62169 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267949AbUHEVZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:25:49 -0400
Subject: Re: [PATCH] cleanup ACPI numa warnings
From: Alex Williamson <alex.williamson@hp.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091739702.31490.245.camel@nighthawk>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 05 Aug 2004 15:25:42 -0600
Message-Id: <1091741142.22406.28.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 14:01 -0700, Dave Hansen wrote:
> On Thu, 2004-08-05 at 13:46, Alex Williamson wrote:
> > +#ifdef ACPI_DEBUG_OUTPUT
> > +#define acpi_print_srat_processor_affinity(header) { \
> > +	struct acpi_table_processor_affinity *p = \
> > +	                      (struct acpi_table_processor_affinity*) header; \
> > +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] " \
> > +	                 "eid[0x%02x]) in proximity domain %d %s\n", \
> > +	                 p->apic_id, p->lsapic_eid, p->proximity_domain, \
> > +	                 p->flags.enabled?"enabled":"disabled")); }
> > +
> > +#define acpi_print_srat_memory_affinity(header) { \
> > +	struct acpi_table_memory_affinity *p = \
> > +	                         (struct acpi_table_memory_affinity*) header; \
> > +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length " \
> > +	                 "0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",\
> > +	                 p->base_addr_hi, p->base_addr_lo, p->length_hi, \
> > +	                 p->length_lo, p->memory_type, p->proximity_domain, \
> > +	                 p->flags.enabled ? "enabled" : "disabled", \
> > +	                 p->flags.hot_pluggable ? " hot-pluggable" : "")); }
> 
> Is there a reason that this can't be a normal function instead of a
> 9-line #define?

   Well, it's 9 lines, but it boils down to one printk.  I'm not sure
putting it in a function would make it any more readable, long printks
are ugly by design.  Either way would work.

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

