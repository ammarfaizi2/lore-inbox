Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265723AbRF2PKO>; Fri, 29 Jun 2001 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265845AbRF2PKE>; Fri, 29 Jun 2001 11:10:04 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:5790 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S265723AbRF2PJz>; Fri, 29 Jun 2001 11:09:55 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>
Subject: VFS locking & HFS problems (2.4.6pre6)
Date: Fri, 29 Jun 2001 17:09:42 +0200
Message-Id: <20010629150942.1359@smtp.adsl.oleane.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a deadlock twice with 2.4.6pre6 today. It's an SMP kernel
running on an UP box (a PowerBook Pismo).

The deadlock happen in the HFS filesystem in hfs_cat_put(), apparently
(quickly looking at addresses) in spin_lock().

I don't have the complete backtrace at hand right now, but it basically
went up to kswapd without anything evidently getting that spinlock,
I'll try to gather more details.

So my question: Is there any document explaining the various locking
requirements & re-entrency possibilities in a filesystem.

What I think might happen after a quick look is that HFS may be causing
schedule() to be called while holding the spinlock, and gets then
re-entered from another process context. I have to look at it in more
detail (is there an HFS maintainer ?) but some background informations
on VFS locking & reentrancy issues would be helpful.

Ben.




