Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270558AbUJTUa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270558AbUJTUa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270547AbUJTU00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:26:26 -0400
Received: from pat.uio.no ([129.240.130.16]:4001 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S270561AbUJTUZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:25:05 -0400
Subject: Re: [PATCH] lockd: replace semaphore, sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041020194522.GX16153@parcelfarce.linux.theplanet.co.uk>
References: <1098299743.20821.54.camel@thomas>
	 <20041020194522.GX16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Wed, 20 Oct 2004 22:24:27 +0200
Message-Id: <1098303867.5390.74.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Oct 20, 2004 at 09:15:43PM +0200, Thomas Gleixner wrote:
> > 
> > Use wait_event, completion instead of the obsolete sleep_on functions
> > and the abused semaphore

What is the point of all this timeout business when starting/stopping
lockd? We sure as hell don't want lockd to survive us if we are the
process that is responsible for killing it, and neither do we want to
start locking if there is no lockd to handle callbacks.
Please see the example of rpciod in net/sunrpc/sched.c for how to do
this correctly.

As for the client changes to the GRANTED mechanism, where is
wait_for_completion_timeout() defined? It is not part of Linus' kernel.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

