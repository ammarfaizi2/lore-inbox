Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWAZAQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWAZAQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWAZAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:16:35 -0500
Received: from amdext4.amd.com ([163.181.251.6]:12265 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751267AbWAZAQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:16:33 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Wed, 25 Jan 2006 18:16:14 -0600
User-Agent: KMail/1.8
cc: "Robin Holt" <holt@sgi.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601251648.58670.raybry@mpdtxmail.amd.com>
 <F6EF7D7093D441B7655A8755@[10.1.1.4]>
In-Reply-To: <F6EF7D7093D441B7655A8755@[10.1.1.4]>
MIME-Version: 1.0
Message-ID: <200601251816.15037.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 26 Jan 2006 00:16:17.0348 (UTC)
 FILETIME=[B9C87840:01C6220D]
X-WSS-ID: 6FC6CB5B0MS652803-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Here's another one to keep you awake at night:

mmap a shared, anonymous region of 8MB (2MB aligned), and fork off some 
children (4 is good enough for me).    In each child, munmap() a 2 MB portion 
of the shared region (starting at offset 2MB in the shared region) and then 
mmap() a private, anonymous region in its place.   Have each child store some 
unique data in that region, sleep for a bit and then go look to see if its 
data is still there.

Under 2.6.15, this works just fine.   Under 2.6.15 + shpt patch, each child 
still points at the shared region and steps on the data of the other 
children.

I imagine the above gets even more interesting if the offset or length of the 
unmapped region is not a multiple of the 2MB alignment.

All of these test cases are for Opteron.   Your alignment may vary.

(Sorry about this... )

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

