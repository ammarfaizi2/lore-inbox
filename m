Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSA2VmV>; Tue, 29 Jan 2002 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbSA2VmL>; Tue, 29 Jan 2002 16:42:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1426 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280975AbSA2Vlv>;
	Tue, 29 Jan 2002 16:41:51 -0500
Date: Tue, 29 Jan 2002 13:40:15 -0800 (PST)
Message-Id: <20020129.134015.116353125.davem@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <a36t3f$oh8$1@penguin.transmeta.com>
In-Reply-To: <20020129165444.A26626@caldera.de>
	<a36t3f$oh8$1@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: torvalds@transmeta.com (Linus Torvalds)
   Date: Tue, 29 Jan 2002 19:27:43 +0000 (UTC)

   In article <20020129165444.A26626@caldera.de>,
   Christoph Hellwig  <hch@caldera.de> wrote:
   >I've ported my hacked up version of Momchil Velikov's radix tree
   >radix tree pagecache to 2.5.3-pre{5,6}.
   
   Looks good. 

I like the changes too, but I'd like to see some numbers
as well.

My only concern is that it doesn't handle one particular
case better than the ugly per-hashchain lock version.  When we're
running through a file and the task doing this changes cpus.
In that case we'll get a lock collision and the per-hashchain lock
changes would at least potentially avoid that.

For web serving sizeable files this might matter, but probably
we don't really care.  Probably it doesn't matter and we are limited
to moving one lock over in such an event anyways.
