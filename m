Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTIFHXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTIFHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:23:15 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:13028 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263620AbTIFHXO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:23:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] idle using PNI monitor/mwait (take 3)
Date: Sat, 6 Sep 2003 00:22:50 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D243@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait (take 3)
Thread-Index: AcN0QWvCzjVMTZaHTwWm7SEoqkaeeAAAZPHQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 07:22:51.0218 (UTC) FILETIME=[AE4B5B20:01C37447]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk]
> On Fri, 5 Sep 2003, Nakajima, Jun wrote:
> 
> > +		if (!pm_idle) {
> > +			pm_idle = mwait_idle;
> > +		}
> > +		return;
> > +	}
> > +	pm_idle = default_idle;
> 
> You don't have to set that.
> 

The idea is to handle smp systems with asymmetric CPUs (if any such system 
is built one day :)). We will use mwait, only if all the CPUs support it.
If any CPU doesn't support mwait, then we switch back to default_idle. 
Note that pm_idle will be NULL by default. 

Thanks,
-Venkatesh
