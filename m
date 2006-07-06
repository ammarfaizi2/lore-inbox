Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWGFXTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWGFXTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGFXTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:19:40 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:30222 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750734AbWGFXTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:19:39 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] spinlocks: remove 'volatile'
Date: Thu, 6 Jul 2006 16:19:00 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCECBNAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.61.0607060816110.8320@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 06 Jul 2006 16:14:22 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 06 Jul 2006 16:14:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look at:
>
>  	http://en.wikipedia.org/wiki/Volatile_variable
>
> This is just what is needed to prevent the compiler from making
> non working
> code during optimization.

	That article is totally and completely wrong, in fact it's so wrong it's
harmful. For example, it says:

... [A] variable that might be concurrently modified by multiple
threads (without locks or a similar form of mutual exclusion) should be
declared volatile.

	Without pointing out that the use of 'volatile' is neither required nor
sufficient, this is an utterly false statement. The reference to "mutual
exclusion" is puzzling, since the problem is cached data, not concurrent
accesses.

	It talks about controlling compiler optimizations. What difference does it
make to me whether an optimization that breaks my code is made by the
compiler or the processor?

	The most serious problem with the article is that it does not point out
what is guaranteed behavior and what happens to be true for some particular
platforms. In fact, the only platform I know of where the behavior the
article implies is guaranteed is (at least arguably) actually guaranteed is
Win32. (And I'm not sure of what value a guarantee is that you have to argue
is implied mostly by omission.)

	Sadly, it omits any mention of the *actual* legitimate use of 'volatile'.
That is, the cases where it has guaranteed semantics and actually is both
necessary and sufficient.

	DS


