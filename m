Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVCCWYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVCCWYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVCCWUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:20:53 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:41659 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262678AbVCCWS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:18:28 -0500
Subject: Re: [PATCH]: Speed freeing memory for suspend.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20050303032620.69add028.akpm@osdl.org>
References: <1109848654.3733.34.camel@desktop.cunningham.myip.net.au>
	 <20050303032620.69add028.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1109888419.3772.9.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Mar 2005 09:20:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are the stats:

1GB P4, 2.6.11+Suspend2 2.1.8.
Soft image size limit set to 2MB to emulate Pavel's implementation (eat
as much memory as we can).

Without patch:
Freed  16545 pages in  4000 jiffies = 16.16 MB/s
Freed  83281 pages in 14060 jiffies = 23.14 MB/s
Freed 237754 pages in 41482 jiffies = 22.39 MB/s

With patch:
Freed  52257 pages in  6700 jiffies = 30.46 MB/s
Freed 105693 pages in 11035 jiffies = 37.41 MB/s
Freed 239007 pages in 18284 jiffies = 51.06 MB/s

With a less aggressive image size limit (200MB):

Without the patch:
Freed  14600 pages in  1749 jiffies = 32.61 MB/s (Anomolous!)
Freed  88563 pages in 14719 jiffies = 23.50 MB/s
Freed 205734 pages in 32389 jiffies = 24.81 MB/s

With the patch:
Freed  68252 pages in   496 jiffies = 537.52 MB/s
Freed 116464 pages in   569 jiffies = 798.54 MB/s
Freed 209699 pages in   705 jiffies = 1161.89 MB/s

The later pages take more work to get, which accounts for the slower
MB/s with smaller numbers of pages to free. Without the patch, though,
getting the easier pages also takes longer because we do a far greater
number of invocations of shrink_all_memory in order to get the same
number of pages.

Regards,

Nigel

On Thu, 2005-03-03 at 22:26, Andrew Morton wrote: 
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> >
> > Here's a patch I've prepared which improves the speed at which memory is
> >  freed prior to suspend. It should be a big gain for swsusp.
> 
> Patch is simple enough but, as always, please back up an optimization patch
> with quantitative test results.



-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de

