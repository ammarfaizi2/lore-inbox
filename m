Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRKVKOT>; Thu, 22 Nov 2001 05:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRKVKOI>; Thu, 22 Nov 2001 05:14:08 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:30499 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S275743AbRKVKNx>; Thu, 22 Nov 2001 05:13:53 -0500
From: Oliver Neukum <oliver@neukum.org>
To: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions
Date: Thu, 22 Nov 2001 11:12:16 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Rick Lindsley <ricklind@us.ibm.com>
In-Reply-To: <3BFC399A.3040101@us.ibm.com>
In-Reply-To: <3BFC399A.3040101@us.ibm.com>
MIME-Version: 1.0
Message-Id: <01112211121601.00690@argo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Many of these patches simply remove the BKL from the file.  This causes
> no harm because the BKL was not really protecting anything, anyway.
> Other patches try to actually fix the locking.  Some do this by making
> use of atomic operations with the atomic_* functions, or the
> (test|set)_bit functions.  Most of these patches replace uses of normal
> integers which were used to keep open counts in the drivers.  In other
> some cases, a spinlock was added when the atomic operations could not
> guarantee proper serialization by themselves.  And, in very few cases,
> the existing locking was extended to protect more things.  These cases
> are very uncommon because locking is very uncommon in most of these
> drivers.

At least some of the removals in the input tree are probably wrong. You are 
introducing a race with deregistering of input devices.

	Regards
		Oliver
