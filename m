Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWDXOe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDXOe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWDXOe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:34:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:39817 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750709AbWDXOe2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:34:28 -0400
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="27789894:sNHT62138342"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Mon, 24 Apr 2006 22:32:25 +0800
Message-ID: <C1989F6360C8E94B9645F0E4CF687C08C1EA07@pgsmsx412.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZnqikPaDZMG0OnTBixmBWaUAkmWAAACEoA
From: "Ong, Soo Keong" <soo.keong.ong@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Gross, Mark" <mark.gross@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 24 Apr 2006 14:32:27.0926 (UTC) FILETIME=[E9629B60:01C667AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 occasions (that I aware of) during the OS times that could
possibly trigger SMI

1. Before OS USB driver disconnect SMI from USB controller
2. ACPI driver call software SMI once
3. SpeedStep using ACPI interface
4. Error (connected to SMI) happens

I know there are always ways to improve BIOS. Allow me to look at the OS
first so that OS can be robust enough to handle different
implementations.

1 and 2 will be gone early in booting. 3 could be handled appropriately
by OS because OS knows when SpeedStep ACPI interface is called and is
done. 4 will be gone after error interrupt re-connection done by OS
after phase 1 and 2.

I am not the one who prefer error handling stay in BIOS, but many people
have different opinion from me.

I logout now.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, April 24, 2006 10:30 PM
To: Ong, Soo Keong
Cc: Gross, Mark; bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari,
Steven; Wang, Zhenyu Z
Subject: RE: Problems with EDAC coexisting with BIOS

On Llu, 2006-04-24 at 22:15 +0800, Ong, Soo Keong wrote:
> To me, periodical is not a good design for error handling, it wastes
> transaction bandwidth that should be used for other more productive
> purposes.

The periodical choice is mostly down to the brain damaged choice of NMI
as the viable alternative, which is as good as 'not usable'

> It is more appropriate to have single handler, either OS or BIOS.

Agreed but then the BIOS must provide that service to the OS reliably
and efficiently so that users can build that service into their system
wide error management and control processes.

> In general, the errors handler connect the errors to the interrupt or
> interrutps. The handler should undhide (if it s hideable) the error
> controller and read its registers upon interrupt, then carry out
> appropriate actions to handle the erros.

Actually I am dubious that the error handler can do that. If the OS
kernel just issued the first half of a config cycle what occurs when the
SMI tries to play with PCI config space ? 
