Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbUCONqC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbUCONqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:46:02 -0500
Received: from fmr99.intel.com ([192.55.52.32]:52409 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262568AbUCONp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:45:59 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [cgl_discussion] Re: About Replaceable OOM Killer
Date: Mon, 15 Mar 2004 08:45:20 -0500
Message-ID: <E5DA6395B8F9614EB7A784D628184B200E34E8@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [cgl_discussion] Re: About Replaceable OOM Killer
Thread-Index: AcQFN95/at6GEJu9R+OyNjvHmyrtSwFWuP8A
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Yury V. Umanets" <umka@namesys.com>
Cc: "Guo, Min" <min.guo@intel.com>,
       =?iso-8859-2?Q?Tvrtko_A=2E_Ur=B9ulin?= <tvrtko@croadria.com>,
       <linux-kernel@vger.kernel.org>, <cgl_discussion@lists.osdl.org>
X-OriginalArrivalTime: 15 Mar 2004 13:45:21.0876 (UTC) FILETIME=[C2DA1940:01C40A93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right, once it is really OOM, you are SOL :-)  Really the only thing you can do at this point in the kernel is to not allocate any more memory, and functions that require more memory just don't work, and the recovery is to reboot..

IMO, the best answer is to detect a nearly-OOM, or trending-toward-OOM condition before it gets so bad.
This would allow userland actions, but would require more customization to tune the detection criteria, which would also imply a userland implementation of the monitoring.  We've found that PCP works pretty well for this type of thing.
See http://oss.sgi.com/projects/pcp/ and http://pcp4cgl.sourceforge.net/.  We did some work with this for CGL 1.0.

Andy Cress

-----Original Message-----
From: cgl_discussion-bounces@lists.osdl.org [mailto:cgl_discussion-bounces@lists.osdl.org] On Behalf Of Pavel Machek
Sent: Monday, March 08, 2004 6:02 AM
To: Yury V. Umanets
Cc: Guo, Min; Tvrtko A. Ur¹ulin; linux-kernel@vger.kernel.org; cgl_discussion@lists.osdl.org
Subject: [cgl_discussion] Re: About Replaceable OOM Killer


Hi!

> > Though it hasn't been updated for a while because nobody cares...
> IMHO problem with OOM killer is that it always will do wrong choice. So,
> it should be either plugin based or allow to configure it and this
> means, that it will become more complex and buggy. Does not it mean,
> that OOM killer should be moved to user space?
> 
> How about to export OOM event to user space? It might be done in manner
> like hotplug script is used.

When you are OOM, you really can't exec userland script...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

_______________________________________________
cgl_discussion mailing list
cgl_discussion@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/cgl_discussion
