Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752972AbWKHO0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbWKHO0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754584AbWKHO0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:26:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752972AbWKHO0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:26:01 -0500
Date: Wed, 8 Nov 2006 14:25:11 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061108142511.GG30653@agk.surrey.redhat.com>
Mail-Followup-To: David Chinner <dgc@sgi.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
	Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611080005.50070.rjw@sisk.pl> <45511430.8030703@redhat.com> <200611080042.03563.rjw@sisk.pl> <20061108000109.GE30653@agk.surrey.redhat.com> <20061108082722.GH8394166@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108082722.GH8394166@melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 07:27:22PM +1100, David Chinner wrote:
> But it's trivial to detect this condition - if (sb->s_frozen != SB_UNFROZEN)
> then the filesystem is already frozen and you shouldn't try to freeze
> it again. It's simple to do, and the whole problem then just goes away....
 
So is that another vote in support of explicitly supporting multiple concurrent
freeze requests, letting them all succeed, and only thawing after the last one
has requested its thaw?  (It's not enough just to check SB_UNFROZEN - also need
to track whether any other outstanding requests to avoid risk of it getting
unfrozen while something independent believes it still to be frozen.)

Alasdair
-- 
agk@redhat.com
