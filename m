Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278221AbRJWUpG>; Tue, 23 Oct 2001 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278258AbRJWUo4>; Tue, 23 Oct 2001 16:44:56 -0400
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:53670 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278221AbRJWUoi>; Tue, 23 Oct 2001 16:44:38 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Patrick Mochel <mochel@osdl.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Tue, 23 Oct 2001 22:22:58 +0200
Message-Id: <20011023202258.5598@smtp.wanadoo.fr>
In-Reply-To: <p05100303b7fb36bf20f5@[207.213.214.37]>
In-Reply-To: <p05100303b7fb36bf20f5@[207.213.214.37]>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Stop accepting new requests" is nontrivial as well, in the general 
>case. New requests that can't be discarded need to be queued 
>somewhere. Whose responsibility is that? Ideally at some point where 
>a queue already exists, possibly in the requester.

Some driver already handle queues. In the case of network driver, just
stop your network queue and stop accepting incoming packets. If your
driver is too simple to have queues, a simple semaphore on entry points
can often be enough. You shouldn't deadlock as you are not supposed to
re-enter a sleeping driver in step 2.

The above, is ensured by the tree layout which does the dependency
ordering. You might have slightly off-tree dependencies, like I have
in a couple of case on macs. But I figured that all of them could be
handled as special case in some parent nodes without beeing that
dirty (in most case, those are Apple specific ASICs containing devices
with inter-deps, and the workaround is to move some devices sleep code
to the node of the ASIC itself).

Ben.


