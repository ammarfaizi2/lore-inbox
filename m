Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271618AbRIBNNa>; Sun, 2 Sep 2001 09:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRIBNNU>; Sun, 2 Sep 2001 09:13:20 -0400
Received: from ns.suse.de ([213.95.15.193]:59909 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271618AbRIBNNK>;
	Sun, 2 Sep 2001 09:13:10 -0400
To: Elisheva Alexander <ealexand@checkpoint.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buffer_head slab memory leak, Linux bug?
In-Reply-To: <20010902140126.E28228@checkpoint.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Sep 2001 15:13:27 +0200
In-Reply-To: Elisheva Alexander's message of "2 Sep 2001 13:18:17 +0200"
Message-ID: <oupbsktzqfc.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elisheva Alexander <ealexand@checkpoint.com> writes:


> it happens quite often (at random), so it's not too hard to recreate it.

It is linux telling you that your code is crappy ;)

It's easy to fix. You just need to fix the lock to not turn off interrupts
for such a long time. If you're writing non driver network code you likely don't need
an _irqsave lock anyways, as a _bh lock should suffice. Better would be to use 
a different lock structure however for such long locks that do not depend on blocking 
bottom halves or interrupts (e.g. see how the TCP socket lock works as an example) 

-Andi

