Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVDKRG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVDKRG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVDKRG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:06:58 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:12459 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261863AbVDKRCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:02:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Oops in swsusp
Date: Mon, 11 Apr 2005 19:02:25 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <4259B425.4090105@domdv.de> <200504110859.00961.rjw@sisk.pl> <425A9F6A.8080200@domdv.de>
In-Reply-To: <425A9F6A.8080200@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111902.25900.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 of April 2005 18:01, Andreas Steinmetz wrote:
> Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, 11 of April 2005 01:17, Andreas Steinmetz wrote:
> > 
> >>Pavel,
> >>during testing of the encrypted swsusp_image on x86_64 I did get an Oops
> >>from time to time at memcpy+11 called from swsusp_save+1090 which turns
> >>out to be the memcpy in copy_data_pages() of swsusp.c.
> >>The Oops is caused by a NULL pointer (I don't remember if it was source
> >>or destination).
> > 
> > 
> > It's quite important, however.  If it's the destination, it's probably a bug in
> > swsusp.  Otherwise, the problem is more serious.  Could you, please,
> > add BUG_ON(!pbe->address) right before the memcpy() and retest?
> 
> Here's the result:
> 
> BUG_ON(!pbe->address) hits, so is seems to be a swsusp problem.
> 
> So I added a BUG_ON(!to_copy) as shown below (mangled for mailing):
> 
> if (saveable(zone, &zone_pfn)) {
>        struct page * page;
>        BUG_ON(!to_copy);
>        page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
>        pbe->orig_address = (long) page_address(page);
>        /* copy_page is not usable for copying task structs. */
>        BUG_ON(!pbe->address);
>        memcpy((void *)pbe->address, (void *)pbe->orig_address,
>               PAGE_SIZE);
>        pbe++;
>        to_copy--;
> }
> 
> The BUG_ON(!to_copy) hits, too.

Oh, I see.  You have discovered a bug in the code that was replaced
in 2.6.12-rc1. :-)  Please use 2.6.12-rc2 or the latest -mm for
testing/development of swsusp.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
