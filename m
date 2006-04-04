Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWDDUHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWDDUHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWDDUHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:07:19 -0400
Received: from mga03.intel.com ([143.182.124.21]:24467 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750838AbWDDUHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:07:17 -0400
X-IronPort-AV: i="4.03,164,1141632000"; 
   d="scan'208"; a="19090131:sNHT57638175"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-rc1-mm1: why did acpi_ns_build_external_path() become global?
Date: Tue, 4 Apr 2006 13:07:14 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04E48616@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-rc1-mm1: why did acpi_ns_build_external_path() become global?
Thread-Index: AcZYBWgIjH+zKUyxSkmb0Byk8yXgvQAHGvXg
From: "Moore, Robert" <robert.moore@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 04 Apr 2006 20:07:15.0875 (UTC) FILETIME=[5E795F30:01C65823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This interface is public now because it is used in common/dsrestag.c

This is the problem as I see it:

We have a continuing issue where we have a bunch of ACPI components
(interpreter, table manager, resource manager, etc.) Depending on how
the pieces are put together, various sub-parts of the components are
used or not used, depending on the application. The kernel-level code is
integrated into many different operating systems. Each OS used a
different subset of the available external interfaces. Further, each of
the user-level applications (iASL compiler, AcpiExec utility, etc.) use
different interfaces.

In this case, it is the iASL compiler that is using build_external_path.

We could certainly go so far as to put each public interface into a
separate file, allowing each application (and host OS) to pick and
choose the exact interfaces it needs (and I have seen it done this
way.), but this leads to a huge number of small files and I'm not sure
we want this.

However, attempting to track all of this with extensive #ifdefs, etc. is
awkward and ugly at best and very difficult to maintain.

I'm open to suggestions.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Adrian Bunk
> Sent: Tuesday, April 04, 2006 9:30 AM
> To: Andrew Morton; Brown, Len
> Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: 2.6.17-rc1-mm1: why did acpi_ns_build_external_path() become
> global?
> 
> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-mm2:
> >
> >  git-acpi.patch
> >...
> >  git trees.
> >...
> 
> acpi_ns_build_external_path() became global but isn't used outside the
> file it's defined in.
> 
> Was this accidental or is a usage pending?
> 
> cu
> Adrian
> 
> --
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
