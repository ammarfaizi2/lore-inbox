Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTBUSP1>; Fri, 21 Feb 2003 13:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTBUSP1>; Fri, 21 Feb 2003 13:15:27 -0500
Received: from fmr01.intel.com ([192.55.52.18]:25026 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267622AbTBUSP0>;
	Fri, 21 Feb 2003 13:15:26 -0500
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
From: "Moore, Robert" <robert.moore@intel.com>
To: "'Bjorn Helgaas'" <bjorn_helgaas@hp.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>
Cc: t-kochi@bq.jp.nec.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Fri, 21 Feb 2003 10:25:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) This seems like a good idea to simplify the parsing of the resource lists

2) I'm not convinced that this buys a whole lot -- it just hides the code
behind a macro (something that's not generally liked in the Linux world.)
Would this procedure be called from more than one place?

3) Fallout from (1), ok.

Bob


-----Original Message-----
From: Bjorn Helgaas [mailto:bjorn_helgaas@hp.com] 
Sent: Tuesday, February 11, 2003 1:58 PM
To: Grover, Andrew
Cc: t-kochi@bq.jp.nec.com; linux-kernel@vger.kernel.org;
acpi-devel@lists.sourceforge.net
Subject: [ACPI] [PATCH] 1/3 ACPI resource handling

These patches against acpi-20030123-2.5.59.diff.gz make it more
convenient to handle ACPI resources and reduce code duplication.

The changes fall into three pieces:

    1) Addition of acpi_walk_resources(), which calls a callback for
       each resource in _CRS or _PRS.  This is handy because you don't
       have to allocate/free buffers, loop over resource lists, or
       make assumptions about the order in which resources appear.

    2) Addition of acpi_resource_to_address64(), which copies
       address16, address32, or address64 resources to an address64
       structure, so you don't have to maintain three sets of code
       that differ only in the size of the address they deal with.

    3) Changes to the EC, PCI link, and ACPI PCI hot-plug drivers to
       use acpi_walk_resources() instead of acpi_get_current_resources().

So far this is just "cleanup" in the sense that there's no new
functionality.  As soon as any issues with these patches are
worked out, I have additional patches that build on them to
add ia64 support for multiple I/O port spaces.

Bjorn


