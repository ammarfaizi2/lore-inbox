Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUE1TqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUE1TqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbUE1TqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:46:18 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:41680 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264026AbUE1Tpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:45:36 -0400
To: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: [Proposal] DEBUG_SLAB should select DEBUG_SPINLOCK
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 28 May 2004 12:45:35 -0700
Message-ID: <528yfc72u8.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 May 2004 19:45:35.0759 (UTC) FILETIME=[584C69F0:01C444EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently had a rather amusing debugging session.  I developed some
code that worked fine on my test kernel, which had CONFIG_DEBUG_SLAB
turned on.  However, as soon as I moved to a kernel without slab
debugging to do some benchmarks, I started getting lockups.  It turns
out that I had a spinlock in my data structure that I forgot to
initialize but the poisoning from slab debugging had taken care of
initializing it for me.  I didn't catch this during development
because I had left CONFIG_DEBUG_SPINLOCK off.

Fortunately (for my sanity) I was able to diagnose this pretty quickly
with the help of the NMI oopser.  However, for other developers' sake,
I think it might make sense to add

	select DEBUG_SPINLOCK

to the DEBUG_SLAB stanza of Kconfig.

I'm not posting a patch because I wanted to find out the status of
Randy Dunlap's patch that consolidates the debugging options.  Is that
patch going to be merged, in someone's tree somewhere, dropped, or what?

If the consensus is that we don't want to do this anyway, that's
fine.  I mostly wanted to share this bug, which amused me.

Thanks,
  Roland
