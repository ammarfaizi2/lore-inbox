Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbTFSEVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbTFSEVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:21:31 -0400
Received: from users.ccur.com ([208.248.32.211]:37706 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265399AbTFSEV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:21:29 -0400
Date: Thu, 19 Jun 2003 00:34:41 -0400
From: "'joe.korty@ccur.com'" <joe.korty@ccur.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta sks
Message-ID: <20030619043441.GA1304@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16D38@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 06:44:42PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> Now that we are at that, it might be wise to add a higher-than-anything
> priority that the kernel code can use (what would be 100 for user space,
> but off-limits), so even FIFO 99 code in user space cannot block out
> the migration thread, keventd and friends.


I would prefer users have the ability to put one or two truly critical RT
tasks above keventd & family.  Such tasks would have to follow certain rules
.. run & sleep quick .. limited or no device IO ..  most communication to
other tasks through shared memory .. possibly others.

There are those willing to follow whatever rules necessary & split up their
application into tasks any which way in order to get high responsiveness to a
critical but small part of their application.  If you follow the rules, you
should be allowed to put a carefully crafted task above the system daemons
(with the possible exception of the migration daemon).

Joe
