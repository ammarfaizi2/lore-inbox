Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVKAXHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVKAXHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVKAXHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:07:49 -0500
Received: from amdext4.amd.com ([163.181.251.6]:20444 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751425AbVKAXHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:07:48 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Tue, 1 Nov 2005 16:10:51 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: AMD Geode GX/LX Support (Refreshed)
Message-ID: <20051101231051.GM9947@cosmic.amd.com>
References: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
 <20051028154430.GB19854@cosmic.amd.com>
 <1130711970.32734.13.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1130711970.32734.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F792AB622C4154630-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  config X86_USE_PPRO_CHECKSUM
> Does this mean you've now done actual performance analysis on whether
> this is a good idea for Geode GX/LX ?

Ok - here is some data that should put your mind at ease.  I pulled
the checksum functions from the kernel, stuck them in userland, and
ran each one N times at a variety of byte sizes (where N=10,000), took the
start and stop times with gettimeofday(), and added it all up.  The results
for the Geode LX platfrom are below.

I think the data shows that the ppro checksum is indeed useful on the
Geode LX platform (and the GX should have similar results, since the
pipelines are pretty close).  Unless I made a really boneheaded mistake
in my app, I think we should leave X86_USE_PPRO_CHECKSUM enabled for Geode
GX/LX.

Jordan

Starting non-ppro test....
Bytes   Time    Avg (usec/run)
----------------------------
16      2029    0.202900
32      1666    0.166600
64      2548    0.254800
128     3429    0.342900
256     5268    0.526800
512     8781    0.878100
1024    16031   1.603100
2048    30548   3.054800
4096    59265   5.926500
Total time: 129565

Starting ppro test....
Bytes   Time    Avg (usec/run)
----------------------------
16      1579    0.157900
32      1655    0.165500
64      1841    0.184100
128     2721    0.272100
256     3582    0.358200
512     5264    0.526400
1024    8900    0.890000
2048    15919   1.591900
4096    29369   2.936900
Total time: 70830

