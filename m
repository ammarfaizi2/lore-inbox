Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTBKWWK>; Tue, 11 Feb 2003 17:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbTBKWWK>; Tue, 11 Feb 2003 17:22:10 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:24738 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id <S266379AbTBKWWJ>;
	Tue, 11 Feb 2003 17:22:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] 2/3 ACPI resource handling
Date: Tue, 11 Feb 2003 15:31:37 -0700
User-Agent: KMail/1.4.3
Cc: "Grover, Andrew" <andrew.grover@intel.com>, t-kochi@bq.jp.nec.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <200302111459.35380.bjorn_helgaas@hp.com> <1045001693.17351.62.camel@dell_ss3.pdx.osdl.net>
In-Reply-To: <1045001693.17351.62.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302111531.37646.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#define copy_field(out, in, field)	out->field = in->field
> > +#define copy_address(out, in)					\
> > +	copy_field(out, in, resource_type);			\
> > +	copy_field(out, in, producer_consumer);			\
> > +	copy_field(out, in, decode);				\
> > +	copy_field(out, in, min_address_fixed);			\
> > +	copy_field(out, in, max_address_fixed);			\
> > +	copy_field(out, in, attribute);				\
> > +	copy_field(out, in, granularity);			\
> > +	copy_field(out, in, min_address_range);			\
> > +	copy_field(out, in, max_address_range);			\
> > +	copy_field(out, in, address_translation_offset);	\
> > +	copy_field(out, in, address_length);			\
> > +	copy_field(out, in, resource_source);
> 
> If ACPI just used normal (ie short) variable names, then ugly macros
> like this would not be necessary.

Well, the length of variable names is really irrelevant to this patch.
I just didn't want to write

	switch (resource->id) {
	case ACPI_RSTYPE_ADDRESS16:
		address16 = (struct acpi_resource_address16 *) &resource->data;
		out->resource_type = address16->resource_type;
		out->producer_consumer = address16->producer_consumer;
		...
	case ACPI_RSTYPE_ADDRESS32:
		address32 = (struct acpi_resource_address32 *) &resource->data;
		out->resource_type = address32->resource_type;
		out->producer_consumer = address32->producer_consumer;
		...
	case ACPI_RSTYPE_ADDRESS64:
		address64 = (struct acpi_resource_address64 *) &resource->data;
		out->resource_type = address64->resource_type;
		out->producer_consumer = address64->producer_consumer;
		...

where all the cases are identical except for the 16/32/64 (and the
occasional cut-and-paste error).

If the macros are considered too ugly, I'd be glad to rewrite the
function as above.  The main thing is to put the 16/32/64 switch
ONE place, rather than duplicating it in every place that consumes
address resources.

Bjorn

