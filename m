Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbULTQrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbULTQrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbULTQrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:47:04 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:27730 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261567AbULTQqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:46:53 -0500
X-Ironport-AV: i="3.88,76,1102312800"; 
   d="scan'208"; a="163631515:sNHT1416332426"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Date: Mon, 20 Dec 2004 10:46:48 -0600
Message-ID: <037BE7456155544096945D871C4709AA01A99EB3@ausx2kmps318.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Thread-Index: AcTmp+4KhIapSeZ7RNihhqmTFWXfoQACnDsg
From: <Robert_Hentosh@Dell.com>
To: <riel@redhat.com>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Dec 2004 16:46:49.0302 (UTC) FILETIME=[7FED7760:01C4E6B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mon, 20 Dec 2004, Rik van Riel wrote:
>
>> Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>"
>> will result in OOM kills, with the dirty pagecache
>> completely filling up lowmem.  This patch is part 1 to
>> fixing that problem.
>
> What I forgot to say is that in order to trigger this OOM
> Kill the dirty_limit of 40% needs to be more memory than
> what fits in low memory.  So this will work on x86 with 
> 4GB RAM, since the dirty_limit is 1.6GB, but the block 
> device cache cannot grow that big because it is restricted
> to low memory.
>
> This has the effect of all low memory being tied up in
> Dirty page cache and userspace try_to_free_pages() skipping
> the writeout of these pages because the block device is
> congested.

I am just confirming that this is a real problem.  The problem 
more frequently shows up with block sizes above 4k on the
dd and also showed up on some platforms with just a mke2fs
on a slower device such as a USB hard drive.

Rik's patch has solved the issue and has been running under
stress (via ctcs) over the weekend without failure.  

Regards,
Robert

