Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbVLHXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVLHXSn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVLHXSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:18:42 -0500
Received: from fmr19.intel.com ([134.134.136.18]:39823 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932706AbVLHXSm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:18:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] ACPI owner_id limit too low
Date: Thu, 8 Dec 2005 15:18:30 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E03A96A14@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI owner_id limit too low
thread-index: AcX8Rb6zycWndh6dSwiLQaQOPmSVvgAB5Omg
From: "Moore, Robert" <robert.moore@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 08 Dec 2005 23:18:33.0062 (UTC) FILETIME=[B5146060:01C5FC4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you felt ambitious, you could take a look at making the change to not
allocate owner IDs for the static tables (tables that cannot be
unloaded). This would really take the pressure off the Owner ID.
Requires a change to the shutdown mechanism to make sure that the
namespace is completely deleted.


> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@hp.com]
> Sent: Thursday, December 08, 2005 2:21 PM
> To: Moore, Robert
> Cc: Brown, Len; linux-kernel@vger.kernel.org; acpi-
> devel@lists.sourceforge.net
> Subject: RE: [ACPI] ACPI owner_id limit too low
> 
> On Thu, 2005-12-08 at 14:03 -0800, Moore, Robert wrote:
> > We have increased the number of owner IDs to 255 in the most recent
> > version of ACPICA, 20051202. This should hit Linux soon.
> >
> > Additionally, we plan to conserve OwnerIDs by not using them for
tables
> > that can never be unloaded, to be implemented in a future release.
> > However, 255 Ids should be plenty for now.
> >
> > Here is the text from the release memo:
> >
> > Increased the number of available Owner Ids for namespace object
> > tracking from 32 to 255. This should eliminate the OWNER_ID_LIMIT
> > exceptions seen on some machines with a large number of ACPI tables
> > (either static or dynamic).
> 
> Hi Bob,
> 
>    Sorry if I wasn't clear, I'm worried about what happens in the
> interim.  The problem will be fixed in ACPICA 20051202, but we have at
> least one, likely two stable kernels that will be tagged before that
> ACPICA version hits the upstream kernel.  We can hit the owner_id
limit
> fairly easily on a few development systems.  How many stable kernels
do
> we want out in the wild with such a low owner_id limit?  Bumping it up
> to 64, while not ideal, is sufficient for our current usage, and I
think
> the patch is trivial enough that it could be included quickly.
Thanks,
> 
> 	Alex
> 
> --
> Alex Williamson                             HP Linux & Open Source Lab

