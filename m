Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTICTsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTICTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:47:12 -0400
Received: from dp.samba.org ([66.70.73.150]:29322 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264186AbTICTpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:45:38 -0400
Date: Thu, 4 Sep 2003 05:44:02 +1000
From: Anton Blanchard <anton@samba.org>
To: linas@austin.ibm.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, mingo@redhat.com,
       riel@redhat.com, mranweil@us.ibm.com
Subject: Re: PATCH: kernel-2.4 brlock livelock
Message-ID: <20030903194401.GA688@krispykreme>
References: <20030903142150.A48064@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903142150.A48064@forte.austin.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> The patch changes the non-atomic code. It grabs the write lock, and
> then spins, waiting for all of the existing readers to finish. 
> New readers are held off.  This seems (to me) to be a reasonable 
> thing to do, based on the following logic:

The problem is with recursive readers. One cpu takes a br read lock then
wants to take the same lock again. It must be allowed to get that read lock.

We need to drop the write spinlock or else we will deadlock.

Anton
