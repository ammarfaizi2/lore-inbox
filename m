Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUE0Sjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUE0Sjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265014AbUE0Sjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:39:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28383 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265000AbUE0Sji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:39:38 -0400
Message-ID: <40B635DC.4070708@pobox.com>
Date: Thu, 27 May 2004 14:39:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
References: <20040524083003.GA3330@ruslug.rutgers.edu>
In-Reply-To: <20040524083003.GA3330@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> Jeff,
> 
> Please apply the following patches to linux-2.6.7-rc1. These patches
> bring the kernel tree up to sync with prism54.org's 1.2's release.
> 
> [PATCH 1/14 linux-2.6.7-rc1] prism54: add new private ioctls

Change OK once cleanups are moved to separate patch.


> [PATCH 2/14 linux-2.6.7-rc1] prism54: reset card on tx_timeout

OK


> [PATCH 3/14 linux-2.6.7-rc1] prism54: add iwspy support

Change OK, patch rejected due to Lindent (!!!) being included in this 
patch as well as functional changes.


> [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in monitor mode

OK


> [PATCH 5/14 linux-2.6.7-rc1] prism54: new prism54 kernel compatibility

rejected, see Arjan's comments

also, prismcompat24.h doesn't belong in the 2.6 kernel.


> [PATCH 6/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 74, 75

OK


> [PATCH 7/14 linux-2.6.7-rc1] prism54: Fix 2.4 build

rejected, as per comment for patch #5


> [PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73

cleanups and bug fixes mixed together in same patch.

Change OK once cleanups are moved to separate patch.


> [PATCH 9/14 linux-2.6.7-rc1] prism54: Fix prism54.org bug 77; strengthened oid transaction

More functional changes mixed in with whitespace and formatting cleanups.

Change OK once cleanups are moved to separate patch.


> [PATCH 10/14 linux-2.6.7-rc1] prism54: Don't allow mib reads while unconfigured

Change OK once cleanups are moved to separate patch.


> [PATCH 11/14 linux-2.6.7-rc1] prism54: Touched up kernel compatibility

Rejected due to patch #5 comments.


> [PATCH 12/14 linux-2.6.7-rc1] prism54: Start using likely/unlikely

Use of likely()/unlikely() is OK.

A change to skb_reserve() was snuck into this patch, completely 
unrelated to $subject.  Also, meaningless cleanups obscure things here too.


> [PATCH 13/14 linux-2.6.7-rc1] prism54: Fix 2.4 SMP build

I agree with this change, but this patch also includes unrelated changes!!


> [PATCH 14/14 linux-2.6.7-rc1] prism54: Fix channel stats; bump to 1.2

OK


Summary:  I'm glad you broke up the changes into multiple patches. 
Thank you.  However, the patches were separated in non-sensical ways. 
Follow these guidelines:

1) With this many patches, cosmetic changes (whitespace, formatting, 
Lindent) should be in separate patches from functional changes.

2) Fully describe all the changes in the patch.  If a patch says "fix 
2.4 SMP build", it should do that and nothing else.

3) Kernel compatibility is achieved by coding for the latest kernel 
(2.6.x), and then creating back-compat definitions that make the 2.6.x 
API (as it's used in your driver) work under earlier kernels.  This is 
known as the "kcompat" approach.  See the kcompat toolkit at 
http://sf.net/projects/gkernel/ for examples.

Please resend the patch series with the changes requested.  It is OK if 
you lump Lindent/whitespace/formatting changes into one big patch, if 
you wish -- assuming that patch contains nothing else.

	Jeff


