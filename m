Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946725AbWKAJcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946725AbWKAJcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946727AbWKAJcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:32:55 -0500
Received: from o-hand.com ([70.86.75.186]:59823 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S1946725AbWKAJcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:32:54 -0500
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <45483278.1080603@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
	 <1161938694.5019.83.camel@localhost.localdomain>
	 <4542E2A4.2080400@yahoo.com.au>
	 <1162032227.5555.65.camel@localhost.localdomain>
	 <454348B4.60007@yahoo.com.au>
	 <1162209347.6962.2.camel@localhost.localdomain>
	 <45483278.1080603@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 09:32:49 +0000
Message-Id: <1162373569.5564.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 16:36 +1100, Nick Piggin wrote:
> Also note that the current code *should* "gracefully" handle the failure.
> In that, it will not reclaim the page on a write error, so it isn't going
> to cause a data loss...
> 
> It's just that it currently results in unswappable pages.
> 
> Handling it more gracefully by allowing the page to be retried with another
> swap entry is OK I guess, but given the added complexity, I'm not even sure
> it is worthwhile.
> 
> Perhaps we should just do the ClearPageError in the try_to_unuse path,
> because the sysadmin should take down that swap device on failure. So if a
> new device is added, we want to be able to unpin the failed pages.

As I see it, ClearPageError in the try_to_unuse path is the correct
thing to do as once we've marked the swap page as bad, it can't retry to
the same swap page. There is nothing special about the failed pages
beyond that point so we don't need them marked.

Also, if we remove the error flag, the page is still probably on the
inactive list so other existing code is likely to take care of trying a
new write to a another swap entry? I didn't add code for this case for
that reason.

Regards,

Richard

