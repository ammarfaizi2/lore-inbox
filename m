Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJYWAN>; Fri, 25 Oct 2002 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJYWAN>; Fri, 25 Oct 2002 18:00:13 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:12046 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261624AbSJYWAL> convert rfc822-to-8bit; Fri, 25 Oct 2002 18:00:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Date: Fri, 25 Oct 2002 17:06:21 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E1064045132C1@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Thread-Index: AcJ8bf87bIWj4pfOT86MgX0/ye55pAAACPpg
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Oct 2002 22:06:21.0949 (UTC) FILETIME=[C09DFAD0:01C27C72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, Oct 25 2002, Jens Axboe wrote:
[...] 
> of course, and likewise for the cluster check. I'll cut a 
> clean version
> tomorrow, I'm out for today..
> 
Ok, Thanks. I'm out 'til Monday.

What originally drove me down this road was not wanting to 
have:

	struct scatterlist tmpsg[XXX]; /* 8 kbytes */

on the stack for every command when XXX might be 512, which 
was what I was expecting when I started writing this patch.  
Once I got it working, empirically I saw the most I ever 
get is 64 SGs.  I don't know if that's a kernel limit, or 
if I just haven't beat on the system hard enough.

In hindsight, perhaps it would have been better for me to just put
it on the stack like before, only moreso, and just change the 
driver to use more SGs, and only later tackle the stack problem, 
if necessary.  As you noted, it's not clear that the overhead of 
the function call per scatter gather element isn't worse than 
just reformatting the entire scatter gather list in a separate 
pass, as is currently done (before my patch).  

Have a good weekend.

-- steve
 
