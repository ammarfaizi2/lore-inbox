Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267337AbUHFECL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267337AbUHFECL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbUHFECL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:02:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:56783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267337AbUHFECE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:02:04 -0400
Date: Thu, 5 Aug 2004 20:50:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: alex.williamson@hp.com, haveblue@us.ibm.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Message-Id: <20040805205059.3fb67b71.rddunlap@osdl.org>
In-Reply-To: <249150000.1091763309@[10.10.2.4]>
References: <1091738798.22406.9.camel@tdi>
	<1091739702.31490.245.camel@nighthawk>
	<1091741142.22406.28.camel@tdi>
	<249150000.1091763309@[10.10.2.4]>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 20:35:10 -0700 Martin J. Bligh wrote:

| --Alex Williamson <alex.williamson@hp.com> wrote (on Thursday, August 05, 2004 15:25:42 -0600):
| 
| > On Thu, 2004-08-05 at 14:01 -0700, Dave Hansen wrote:
| >> On Thu, 2004-08-05 at 13:46, Alex Williamson wrote:
| >> > +#ifdef ACPI_DEBUG_OUTPUT
| >> > +#define acpi_print_srat_processor_affinity(header) { \
| >> > +	struct acpi_table_processor_affinity *p = \
| >> > +	                      (struct acpi_table_processor_affinity*) header; \
| >> > +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] " \
| >> > +	                 "eid[0x%02x]) in proximity domain %d %s\n", \
| >> > +	                 p->apic_id, p->lsapic_eid, p->proximity_domain, \
| >> > +	                 p->flags.enabled?"enabled":"disabled")); }
| >> > +
| >> > +#define acpi_print_srat_memory_affinity(header) { \
| >> > +	struct acpi_table_memory_affinity *p = \
| >> > +	                         (struct acpi_table_memory_affinity*) header; \
| >> > +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length " \
| >> > +	                 "0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",\
| >> > +	                 p->base_addr_hi, p->base_addr_lo, p->length_hi, \
| >> > +	                 p->length_lo, p->memory_type, p->proximity_domain, \
| >> > +	                 p->flags.enabled ? "enabled" : "disabled", \
| >> > +	                 p->flags.hot_pluggable ? " hot-pluggable" : "")); }
| >> 
| >> Is there a reason that this can't be a normal function instead of a
| >> 9-line #define?
| > 
| >    Well, it's 9 lines, but it boils down to one printk.  I'm not sure
| > putting it in a function would make it any more readable, long printks
| > are ugly by design.  Either way would work.
| 
| Multi-line #defines are inherently eeeeevil ;-) I'd agree with Dave - static 
| inlines are the normal way to do this.

That's surely just an opinion, right?  8;)

If they are more than a single function (like printk), I might agree,
but the Linux kernel has plenty of them already.

Using a macro for a big printk() seems to makes sense.
And there's nothing in CodingStyle that agrees with you that I could find.

--
~Randy
