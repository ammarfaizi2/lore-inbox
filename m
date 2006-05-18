Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWERHEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWERHEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWERHEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:04:32 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:41915 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751298AbWERHEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:04:31 -0400
Date: Thu, 18 May 2006 00:04:28 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some interrelated
 stability and cleanliness fixes
In-Reply-To: <adaac9g3pae.fsf@cisco.com>
Message-ID: <Pine.LNX.4.61.0605180002120.23416@osa.unixfolk.com>
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
 <fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no> <Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
 <ada4pzo5xti.fsf@cisco.com> <Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
 <adaac9g3pae.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Roland Dreier wrote:
| I do see obvious bugs in ipath_user_pages.c, though.  In
| ipath_release_user_pages_on_close(), you have:
| 
| 		mm = get_task_mm(current);
| 		if (!mm)
| 			goto bail;

It turns out that since this is called from ipath_close(),
mm will always be NULL, so what we do is leak memory, and
possibly leave some locked pages.  I've been looking at this
code this evening; fixing it is clearly needed, but doesn't help
the long delays, hangs, and watchdogs, so far.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
