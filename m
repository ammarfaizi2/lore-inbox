Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRLDEVq>; Mon, 3 Dec 2001 23:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRLDEVg>; Mon, 3 Dec 2001 23:21:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60828 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278808AbRLDEVd>;
	Mon, 3 Dec 2001 23:21:33 -0500
Date: Mon, 03 Dec 2001 20:21:30 -0800 (PST)
Message-Id: <20011203.202130.118628301.davem@redhat.com>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com>
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Mon, 03 Dec 2001 21:10:27 +0100
   
   Which other runtime checks are possible?
   Tests for correct _irq usage are not possible, several drivers use
   disable_irq().

Keep track of how many locks are being held at once, and check if it
is zero at switch_to() time.  You can also do this to measure things
like max number of locks held at once and other statistics.

I added the first bit to sparc64 while hunting down a bug.

