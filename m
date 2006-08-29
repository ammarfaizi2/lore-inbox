Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965327AbWH2Ush@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbWH2Ush (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWH2Ush
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:48:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:17296 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965327AbWH2Usg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:48:36 -0400
Subject: end_swap_bio_write error handling
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 21:48:34 +0100
Message-Id: <1156884514.5600.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experimenting with a swap block device driver which under
certain conditions generates write failures for pages. I'd presumed the
kernel would recover from a write error by restoring the copy it still
has in memory. In an ideal world it would then mark that page of the
swap device as bad although I'm fairly sure this doesn't happen. I'm not
sure about the restoring the in memory page but if it does happen, I'm
having trouble identifying the code.

When I tested this, it doesn't appear to recover and processes on the
system, presumably the ones using swap just disappear when write
failures occur.

end_swap_bio_write() simply does:

if (!uptodate)
	SetPageError(page);

I know the uptodate flag is being cleared in the error cases. I'm having
trouble working out which code the setting of an error flag for a swap
page should trigger (any pointers appreciated!). I noticed its also used
for the read case which is unrecoverable.

Should this code be marking the page as dirty and the section of the
swap device as bad instead, does it already do that or is that not
possible for some reason?

Any comments and/or pointers to documentation on this would be
appreciated.

Thanks,

Richard

