Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTKBXHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 18:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTKBXHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 18:07:19 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:30989 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261758AbTKBXHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 18:07:18 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Sun, 2 Nov 2003 23:06:20 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311022306.20825.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 3:57 am, Rik van Riel wrote:
> On Wed, 29 Oct 2003, Chris Vine wrote:
> > However, on a low end machine (200MHz Pentium MMX uniprocessor with only
> > 32MB of RAM and 70MB of swap) I get poor performance once extensive use
> > is made of the swap space.
>
> Could you try the patch Con Kolivas posted on the 25th ?
>
> Subject: [PATCH] Autoregulate vm swappiness cleanup

OK.  I have now done some testing.

The default swappiness in the kernel (without Con's patch) is 60.  This gives 
hopeless swapping results on a 200MHz Pentium with 32MB of RAM once the 
amount of memory swapped out exceeds about 15 to 20MB.  A static swappiness 
of 10 gives results which work under load, with up to 40MB swapped out (I 
haven't tested beyond that).  Compile times with a test file requiring about 
35MB of swap and with everything else the same are:

2.4.22 - average of 1 minute 35 seconds
2.6.0-test9 (swappiness 10) - average of 5 minutes 56 seconds

A swappiness of 5 on the test compile causes the machine to hang in some kind 
of "won't swap/can't continue without more memory" stand-off, and a 
swappiness of 20 starts the machine thrashing to the point where I stopped 
the compile.  A swappiness of 10 would complete anything I threw at it and 
without excessive thrashing, but more slowly (and using a little more swap 
space) than 2.4.22.

With Con's dynamic swappiness patch things were worse, rather than better.  
With no load, the swappiness (now read only) was around 37.  Under load with 
the test compile, swappiness went up to around 62, thrashing began, and after 
30 minutes the compile still had not completed, swappiness had reached 70, 
and I abandoned it.

Chris.

