Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVHOShy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVHOShy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVHOShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:37:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964872AbVHOShx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:37:53 -0400
Subject: Re: [-mm PATCH 2/32] fs: fix-up schedule_timeout() usage
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: sfrench@samba.org, okir@monad.swb.de,
       Trond Myklebust <trond.myklebust@fys.uio.no>, reiserfs-dev@namesys.com,
       urban@teststation.com, xfs-masters@oss.sgi.com,
       Nathan Scott <nathans@sgi.com>, Andrew Morton <akpm@osdl.org>,
       samba-technical@lists.samba.org,
       linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
       samba@samba.org, linux-xfs@oss.sgi.com,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050815180804.GE2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
	 <20050815180804.GE2854@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1124131033.1888.438.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 15 Aug 2005 19:37:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-08-15 at 19:08, Nishanth Aravamudan wrote:

> Description: Use schedule_timeout_{,un}interruptible() instead of
> set_current_state()/schedule_timeout() to reduce kernel size.

> +++ 2.6.13-rc5-mm1-dev/fs/jbd/transaction.c	2005-08-10 15:03:33.000000000 -0700
> @@ -1340,8 +1340,7 @@ int journal_stop(handle_t *handle)
> -			set_current_state(TASK_UNINTERRUPTIBLE);
> -			schedule_timeout(1);
> +			schedule_timeout_uninterruptible(1);

This chunk at least is fine.

--Stephen

