Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUC2WCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUC2WCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:02:18 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:22406 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263147AbUC2WCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:02:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16488.40157.474575.545711@gargle.gargle.HOWL>
Date: Mon, 29 Mar 2004 17:02:05 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: John Stoffel <stoffel@lucent.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
In-Reply-To: <Pine.LNX.4.44.0403291708001.18667-100000@localhost.localdomain>
References: <16488.14980.884442.349267@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0403291708001.18667-100000@localhost.localdomain>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hugh" == Hugh Dickins <hugh@veritas.com> writes:

Hugh> On Mon, 29 Mar 2004, John Stoffel wrote:
>> 
>> I'm still wondering why swapoff dies though.  Shouldn't it complete,
>> or at least have some way *to* complete if needed?  I realize, with a
>> memory leak in the filesystem, it's a hard thing to deal with.  

Hugh> If there's not enough freeable memory for what's out on swap,
Hugh> swapoff cannot very well complete.  Either it can hang while
Hugh> other processes get killed by the OOM killer once swapoff has
Hugh> filled memory (as 2.4), until there's enough memory free to take
Hugh> in what's still needed from swap; or the OOM killer can kill it
Hugh> off (as 2.6).  I much prefer the 2.6 behaviour - unlike many
Hugh> processes, swapoff can safely be restarted.  So the admin can
Hugh> then choose what else to kill, or add replacement swap, then try
Hugh> the original swapoff again.

But in this case, there was no way to force the turning off of swap,
since the ext3 bug in 2.6.5-rc2-mm1 had filled the cache, and wasn't
going away.  Is this right?  

I wonder if there's a way to tell swap to 'go away when you can, don't
allow more swap (kill new requests), and generally work on pushing
stuff back to memory, or other swap partitions.'

This doesn't have to be the default, but it would be nice to have a
big hammer to beat on the system at times.

Thanks for the feedback Hugh, I do appreciate it.

John
