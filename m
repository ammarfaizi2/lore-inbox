Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263708AbUEDBpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbUEDBpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbUEDBpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:45:50 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:11273 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263708AbUEDBpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:45:49 -0400
Date: Tue, 4 May 2004 09:53:44 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Jeff Moyer <jmoyer@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
In-Reply-To: <16534.28383.871208.542553@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0405040950020.25459@wombat.indigo.net.au>
References: <20040430014658.112a6181.akpm@osdl.org>
 <Pine.LNX.4.58.0405032250060.4454@donald.themaw.net>
 <16534.28383.871208.542553@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Jeff Moyer wrote:

> ==> Regarding Re: 2.6.6-rc3-mm1; raven@themaw.net adds:
> 
> raven> The case where two process similtaneously trigger a mount in autofs4
> raven> can cause multiple requests to the daemon for the same mount. The
> raven> daemon handles this OK but it's possible an incorrect error to be
> raven> returned. For this reason I believe it is better to change the spin
> raven> lock to a semaphore in waitq.c. This makes the second and subsequent
> raven> request wait on the q as ther supposed to.
> 
> This looks good to me.  Do you also need to take the semaphore in
> autofs4_catatonic_mode(), around the hijacking of the queue?
> 

btw I've been back and forward on the spin lock semaphore use in waitq.c 
for some time. This last review has made the decision clear. I'll be 
adding it to the 2.4 patch as well.

Ian

