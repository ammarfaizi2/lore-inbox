Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTKCVN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTKCVN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:13:58 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:22278 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S263402AbTKCVNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:13:53 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: Con Kolivas <kernel@kolivas.org>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Mon, 3 Nov 2003 21:13:14 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311022306.20825.chris@cvine.freeserve.co.uk> <200311031148.40242.kernel@kolivas.org>
In-Reply-To: <200311031148.40242.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311032113.14462.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 November 2003 12:48 am, Con Kolivas wrote:

> Well I was considering adding the swap pressure to this algorithm but I had
> hoped 2.6 behaved better than this under swap overload which is what
> appears to happen to yours. Can you try this patch? It takes into account
> swap pressure as well. It wont be as aggressive as setting the swappiness
> manually to 10, but unlike a swappiness of 10 it will be more useful over a
> wide range of hardware and circumstances.

Hi,

I applied the patch.

The test compile started in a similar way to the compile when using your first 
patch.  swappiness under no load was 37.  At the beginning of the compile it 
went up to 67, but when thrashing was well established it started to come 
down slowly.  After 40 minutes of thrashing it came down to 53.  At that 
point I stopped the compile attempt (which did not complete).

So, there is a slight move in the right direction, but given that a swappiness 
of 20 generates thrashing with 32 MB of RAM when more than about 20MB of 
memory is swapped out, it is a drop in the ocean.

The conclusion appears to be that for low end systems, once memory swapped out 
reaches about 60% of installed RAM the swap ceases to work effectively unless 
swappiness is much more aggressively low than your patch achieves.  The 
ability manually to tune it therefore seems to be required (and even then, 
2.4.22 is considerably better, compiling the test file in about 1 minute 35 
seconds).

I suppose one question is whether I would get the same thrashiness with my 
other machine (which has 512MB of RAM) once more than about 300MB is swapped 
out.  However, I cannot answer that question as I do not have anything here 
which makes memory demands of that kind.

Chris.

