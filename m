Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVGLBOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVGLBOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVGLBMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 21:12:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20438 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261840AbVGLBKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 21:10:46 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.6290.734560.231978@tut.ibm.com>
Date: Mon, 11 Jul 2005 20:10:42 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Merging relayfs?
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, can you please merge relayfs?  It provides a low-overhead
logging and buffering capability, which does not currently exist in
the kernel.

relayfs key features:

- Extremely efficient high-speed logging/buffering
- Simple mechanism for user-space data retrieval
- Very short write path
- Can be used in any context, including interrupt context
- No runtime resource allocation
- Doesn't do a kmalloc for each "packet"
- No need for end-recipient
- Data may remain buffered whether it is consumed or not
- Data committed to disk in bulk, not per "packet"
- Can be used in circular-buffer mode for flight-recording

The relayfs code has been in -mm for more than three months following
the extensive review that took place on LKML at the beginning of the
year, at which time we addressed all of the issues people had.  Since
then only a few minor patches to the original codebase have been
needed, most of which were sent to us by users; we'd like to thank
those who took the time to send patches or point out problems.

The code in the -mm tree has also been pounded on very heavily through
normal use and testing, and we haven't seen any problems with it - it
appears to be very stable.

We've also tried to make it as easy as possible for people to create
'quick and dirty' (or more substantial) kernel logging applications.
Included is a link to an example that demonstrates how useful this can
be.  In a nutshell, it uses relayfs logging functions to track
kmalloc/kfree and detect memory leaks.  The only thing it does in the
kernel is to log a small binary record for each kmalloc and kfree.
The data is then post-processed in user space with a simple Perl
script.  You can see an example of the output and the example itself
here:

    http://relayfs.sourceforge.net/examples.html#kleak


Last but not least, it's still small (40k worth of source),
self-contained and unobtrusive to the rest of the kernel.

In summary, relayfs is very stable, is useful to current users and
with inclusion, would be useful to many others.  If you can think of
anything we've overlooked or should work on to get relayfs to the
point of inclusion, please let us know.

Thanks,

Tom Zanussi
Karim Yaghmour


