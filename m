Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTBUSXq>; Fri, 21 Feb 2003 13:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbTBUSXq>; Fri, 21 Feb 2003 13:23:46 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:16846 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id <S267628AbTBUSXp>;
	Fri, 21 Feb 2003 13:23:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: "Moore, Robert" <robert.moore@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 11:33:45 -0700
User-Agent: KMail/1.4.3
Cc: t-kochi@bq.jp.nec.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302211133.45773.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) I'm not convinced that this buys a whole lot -- it just hides the code
> behind a macro (something that's not generally liked in the Linux world.)
> Would this procedure be called from more than one place?

I assume you're wondering about the value of this piece:

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn_helgaas@hp.com] 
> Sent: Tuesday, February 11, 2003 1:58 PM
> ...
>     2) Addition of acpi_resource_to_address64(), which copies
>        address16, address32, or address64 resources to an address64
>        structure, so you don't have to maintain three sets of code
>        that differ only in the size of the address they deal with.

If so, decode_acpi_resource() in drivers/hotplug/acpiphp_glue.c is a
good example of why acpi_resource_to_address64() is useful.
decode_acpi_resource() contains a switch to handle 16-, 32-,
and 64-bit addresses.

So does acpi_get_crs_addr() in arch/ia64/kernel/acpi.c.  So will
my code to support multiple IO port space on IA64 (unless we
have something like acpi_resource_to_address64()).

None of these places really cares whether the address is 16, 32,
or 64 bits; they just have to have code to use the correct structure
type.  I'm proposing that we hide that ugliness in one place, and
most places can just deal with address64 and be done with it.

Bjorn

