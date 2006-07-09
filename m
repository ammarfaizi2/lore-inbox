Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWGITSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWGITSW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWGITSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:18:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:50076 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161063AbWGITSV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:18:21 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="62615462:sNHT19510848"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: RE: [PATCH] ia64: change usermode HZ to 250
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 9 Jul 2006 12:18:21 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A34B9BD@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: change usermode HZ to 250
Thread-Index: AcaiWbsVhQ8fcROeQCasys0cDwEElwBMaBfA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>, "Jeremy Higdon" <jeremy@sgi.com>
Cc: "Jes Sorensen" <jes@sgi.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "John Daiker" <jdaiker@osdl.org>, "John Hawkes" <hawkes@sgi.com>,
       "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>
X-OriginalArrivalTime: 09 Jul 2006 19:18:20.0293 (UTC) FILETIME=[70631B50:01C6A38C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So is times() is broken in IA64, or is this an exception to Alan's
> > statement?

> yes it's broken; it needs to convert it to the original HZ (1024) and


http://www.opengroup.org/onlinepubs/007908799/xsh/times.html

In which there is a typo: 

"Applications should use to determine the number of clock ticks
 per second as it may vary from system to system"

Clearly the word "sysconf" is missing between "use" and "to" (sysconf()
*is* listed in the SEE ALSO section).

I thought that part of the reason Linus raised HZ from 100 to 1000
on x86 was to help flush out pre-historic programs that didn't
know about sysconf() [With the hope that results that are off by
an order of magnitude would be absurd enough to get notice].

> make the sysconf() function also return 1024

Making sysconf lie about the actual system tick sounds such a
bad idea on so many levels!

-Tony
