Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWJEWOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWJEWOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJEWOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:14:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:36010 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S932348AbWJEWOE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:14:04 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,267,1157353200"; 
   d="scan'208"; a="141038430:sNHT21975240"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Cast removal
Date: Thu, 5 Oct 2006 15:14:02 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Cast removal
Thread-Index: AcboVSnC6QWXXtUgSQ2J0rK9jV1jAgAP+3cwAA14syA=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Len Brown" <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "ACPI List" <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2006 22:14:03.0489 (UTC) FILETIME=[90F92510:01C6E8CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you're discussing this type of thing, I agree wholeheartedly:

static void acpi_processor_notify(acpi_handle handle, u32 event, void
*data)  {
-	struct acpi_processor *pr = (struct acpi_processor *)data;
+	struct acpi_processor *pr = data;


I find this one interesting, as we've put a number of them into the
ACPICA core:

-	(void) kmem_cache_destroy(cache);
+	kmem_cache_destroy(cache);

I believe that the point of the (void) is to prevent lint from
squawking, and perhaps some picky ANSI-C compilers. What is the overall
Linux policy on this?

Thanks,
Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Thursday, October 05, 2006 8:46 AM
> To: Jan Engelhardt; Andrew Morton
> Cc: Len Brown; Brown, Len; Linux Kernel Mailing List; ACPI List
> Subject: RE: [PATCH] Cast removal
> 
> I was speaking generally, as far as casting issues go with ACPICA. We
> have lots of compilers to support, as well as 16/32/64 bit issues. We
> are about to remove the 16-bit support, which will clean things up a
> bit.
> 
> I would appreciate a couple of examples of exactly what is being
> discussed.
> Thanks.
> Bob
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> > Sent: Thursday, October 05, 2006 1:00 AM
> > To: Andrew Morton
> > Cc: Len Brown; Brown, Len; Linux Kernel Mailing List; ACPI List
> > Subject: Re: [PATCH] Cast removal
> >
> >
> > >> > > I'm okay applying this patch it touches the linux-specific
> > >> > > drivers/acpi/* files only, no ACPICA files.
> > >> >
> > >> > Why?
> > >>
> > >> Why am I okay with it?
> > >
> > >No, I meant why not clean up ACPICA too?
> >
> > I was about to go through the whole kernel base for anti-casting.
> Sounds
> > like a big task, and probably is. I just did not want to do it all
at
> > once and send a mega-patch. Instead, a per-directory walk seems best
> to
> > me, and granted, "dispatcher events executer hardware namespace" and
> all
> > the other directories under drivers/acpi/ were supposed to be the
next
> > to be examined for casts.
> >     Though if you have problems with that because compiling with
ugh,
> > old or broken, compilers, be my guest.
> > http://www.velocityreviews.com/forums/t313918-void-casting.html
> > """If your compiler requires a cast, you are using a C++
compiler."""
> > Is that the case?
> >
> >
> >
> > 	-`J'
> > --
> > -
> > To unsubscribe from this list: send the line "unsubscribe
linux-acpi"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
