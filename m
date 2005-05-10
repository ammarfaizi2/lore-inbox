Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVEJPgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVEJPgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVEJPgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:36:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:30952 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261686AbVEJPfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:35:02 -0400
Subject: Re: [PATCH] sync_sb_inodes cleanup
From: Robert Love <rml@novell.com>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <1115737238.4456.320.camel@tribesman.namesys.com>
References: <1115737238.4456.320.camel@tribesman.namesys.com>
Content-Type: text/plain
Date: Tue, 10 May 2005 11:35:01 -0400
Message-Id: <1115739301.6810.15.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 19:00 +0400, Vladimir Saveliev wrote:

> This patch makes generic_sync_sb_inodes to spin lock itself.
> Please, apply this patch. It helps reiser4 to get rid of some oddities.
>
> [snip]
>
>  {
>         const unsigned long start = jiffies;    /* livelock avoidance */
>  
> +       spin_lock(&inode_lock);

Looking at what jiffies is used for, it is probably is not a big deal,
but you should move the assignment of start to after acquiring the lock,
as that could take quite some time.

	Robert Love


