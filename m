Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbTBUW0v>; Fri, 21 Feb 2003 17:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTBUW0u>; Fri, 21 Feb 2003 17:26:50 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:35541 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id <S267739AbTBUW0u>;
	Fri, 21 Feb 2003 17:26:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 15:36:51 -0700
User-Agent: KMail/1.4.3
Cc: "Moore, Robert" <robert.moore@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, t-kochi@bq.jp.nec.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com> <200302211509.15641.bjorn_helgaas@hp.com> <20030221221503.F19234@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030221221503.F19234@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302211536.51368.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
