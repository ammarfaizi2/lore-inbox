Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267796AbTBUW5x>; Fri, 21 Feb 2003 17:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267797AbTBUW5x>; Fri, 21 Feb 2003 17:57:53 -0500
Received: from fmr01.intel.com ([192.55.52.18]:35575 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267796AbTBUW5u>;
	Fri, 21 Feb 2003 17:57:50 -0500
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB0F@orsmsx107.jf.intel.com>
From: "Moore, Robert" <robert.moore@intel.com>
To: "'Bjorn Helgaas'" <bjorn_helgaas@hp.com>,
       Matthew Wilcox <willy@debian.org>
Cc: "Moore, Robert" <robert.moore@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, t-kochi@bq.jp.nec.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 15:07:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is worth looking into, anyway.
memcpy is appropriate, also.
Bob


-----Original Message-----
From: Bjorn Helgaas [mailto:bjorn_helgaas@hp.com] 
Sent: Friday, February 21, 2003 2:37 PM
To: Matthew Wilcox
Cc: Moore, Robert; Grover, Andrew; Walz, Michael; t-kochi@bq.jp.nec.com;
linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling

On Friday 21 February 2003 3:15 pm, Matthew Wilcox wrote:
> On Fri, Feb 21, 2003 at 03:09:15PM -0700, Bjorn Helgaas wrote:
> > Or, since you mention a macro, maybe your question is not about
> > the usefulness of acpi_resource_to_address64() itself, but about
> > how I implemented it, namely, with the copy_field and copy_address
> > macros:
> 
> Can I suggest that you do a simple memcpy() for the case where you're
> translating an address64 into an address64?

I suppose we could.  Or maybe we should just get to the root of the
thing and make a generic acpi_resource_address structure and never
even expose the 16, 32, and 64 bit variants.  As far as I can tell,
they just make life difficult for consumers.

Then acpi_rs_address16_resource(), acpi_rs_address32_resource(),
and acpi_rs_address64_resource() could be collapsed into one function
with pretty trivial checks for the different sizes.  And there's lots
of similar collapsing that could be done.  I bet we'd even find one
or two defects in the process of removing all the duplicated code.

Of course, I guess that would change the CA interface, so that
constrains things a bit.

Bjorn
