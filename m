Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161420AbWASUsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161420AbWASUsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWASUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:48:46 -0500
Received: from fmr23.intel.com ([143.183.121.15]:41945 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161420AbWASUsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:48:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: about sanitize_e820_map()
Date: Thu, 19 Jan 2006 12:47:37 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006F49A28@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: about sanitize_e820_map()
Thread-Index: AcYXcPaKCwt9M30KRwGXXfdYyFwelAFx7cgg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <psbfan@po.harenet.ne.jp>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 19 Jan 2006 20:47:38.0508 (UTC) FILETIME=[957E94C0:01C61D39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>Date: Thu, 12 Jan 2006 11:02:49 +0900 (JST)
>From: Toshiyuki Ishii <psbfan@po.harenet.ne.jp>
>To: linux-kernel@vger.kernel.org
>Subject: about sanitize_e820_map()
>
>
>
>Good evening.
>I am Toshiyuki Ishii at Kurashiki in Japan.
>
>I am a beginner of kernel source code,
>so sorry if I am misunderstanding.
>
>In sanitize_e820_map(),
>When sorting change_point[] by address and swapping
>two maps that represets the same memory region
>and have a different address, end address for privious change_point
>and start address for current change_point,
>"if" statement is
>
>if ((change_point[i]->addr < change_point[i-1]->addr) ||
>
>     ((change_point[i]->addr == change_point[i-1]->addr) &&
>      (change_point[i]->addr == change_point[i]->pbios->addr) &&
>      (change_point[i-1]->addr != change_point[i-1]->pbios->addr))
>
>There are two conditions and I think the first one is sorting 
>by address.
>I have a qestion in the second condition.
>
>I think second line
>
>change_point[i]->addr == change_point[i]->pbios->addr
>
>checks that current change_point represents start address.
>and third line
>
>change_point[i-1]->addr != change_point[i-1]->pbios->addr
>
>checks that previous change_point represents end address.
>If this "if" statement intends to swap maps for "the same" region
>that match these condition,

As I understand this code, this is trying to swap the start and end of
"different" regions. Start and end of same region will always be sorted 
and end will appear after start (As we check for non-zero size and 
setup change_point in a way that start is before end).

But, there can be end of one region coinciding with start of next
region. 
In which case, this sorting puts the start before the end so that we 
can properly find out overlaps later.

I think the existing code is doing the right thing.

Thanks,
Venki
