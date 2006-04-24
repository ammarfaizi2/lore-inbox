Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWDXN77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDXN77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDXN77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:59:59 -0400
Received: from mga03.intel.com ([143.182.124.21]:51304 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750828AbWDXN76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:59:58 -0400
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="26985796:sNHT28018991"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Mon, 24 Apr 2006 21:59:48 +0800
Message-ID: <C1989F6360C8E94B9645F0E4CF687C08C1E9EF@pgsmsx412.gar.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZnoEVif7zzwS1wRZGIyA9RkSjbpAABmhTA
From: "Ong, Soo Keong" <soo.keong.ong@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Gross, Mark" <mark.gross@intel.com>
Cc: <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 24 Apr 2006 13:59:53.0301 (UTC) FILETIME=[5C568050:01C667A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Have you understood how the errors are connected to the interrupts
(either SMI, NMI, SCI)?

When does EDAC read the error status? Periodical or upon interrpt by
errors?

Soo Keong


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, April 24, 2006 9:19 PM
To: Gross, Mark
Cc: bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari, Steven; Ong,
Soo Keong; Wang, Zhenyu Z
Subject: Re: Problems with EDAC coexisting with BIOS

On Gwe, 2006-04-21 at 09:01 -0700, Gross, Mark wrote:
> 1) The default AMI BIOS behavior on SMI is to check the chipset error
> registers (Dev0:Fun1) and re-hide them.

The words "bad design" come to mind (followed by a large number of more
accurate phrases that are inappropriate for a public list)

> Basically if device 0 : function 1 is hidden by the platform at boot
> time un-hiding and using the device and function is a risky thing to
do,

Intel provided patches that do exactly this for some of the chip
workarounds. Are you saying the Intel chip work around also needs
fixing ?

> The driver should never get loaded by default or automatically.  If
the
> user knows enough about there BIOS to trust that the SMI behavior will
> coexist with the driver then its OK to load otherwise using this
driver
> is not a safe thing to do.

So Intel and/or the BIOS vendors also forgot to put in any kind of
indicator ? How do they expect end users to know this, or OS vendors ?
Is there a technote that covers this mess ?

> I think the best thing to do is to have the driver error out in its
init
> or probe code if the dev0:fun1 is hidden at boot time.
> 
> Comments?

Why did Intel bother implementing this functionality and then screwing
it up so that OS vendors can't use it ? It seems so bogus.

At the very least we should print a warning advising the user that the
BIOS is incompatible and to ask the BIOS vendor for an update so that
they can enable error detection and management support. 

Is only the AMI BIOS this braindamaged, should we just blacklist AMI
bioses in EDAC or is this shared Intel supplied code that may be found
in other vendors systems.

Alan
