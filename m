Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267064AbUBFAK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267067AbUBFAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:10:55 -0500
Received: from fmr09.intel.com ([192.52.57.35]:1510 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S267064AbUBFAKp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:10:45 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Limit hash table size
Date: Thu, 5 Feb 2004 16:10:35 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB58024C3@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Limit hash table size
Thread-Index: AcPsQ7cujdjs5t3+Rja2V3AVpVY36gAAUVVg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 06 Feb 2004 00:10:35.0806 (UTC) FILETIME=[A4C94BE0:01C3EC45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Will you merge the changes in the network area first while I'm working
on the solution suggested here for inode and dentry? The 2GB tcp hash is
the biggest problem for us right now.

- Ken


-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Thursday, February 05, 2004 3:58 PM
To: Chen, Kenneth W
Cc: linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org
Subject: Re: Limit hash table size

Ken, I remain unhappy with this patch.  If a big box has 500 million
dentries or inodes in cache (is possible), those hash chains will be
more
than 200 entries long on average.  It will be very slow.

We need to do something smarter.  At least, for machines which do not
have
the ia64 proliferation-of-zones problem.

Maybe we should leave the sizing of these tables as-is, and add some
hook
which allows the architecture to scale them back.
