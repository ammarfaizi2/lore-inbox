Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSFREU6>; Tue, 18 Jun 2002 00:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSFREU5>; Tue, 18 Jun 2002 00:20:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8606 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317306AbSFREU4>;
	Tue, 18 Jun 2002 00:20:56 -0400
Date: Mon, 17 Jun 2002 21:15:48 -0700 (PDT)
Message-Id: <20020617.211548.63484157.davem@redhat.com>
To: george@mvista.com
Cc: willy@debian.org, rml@mvista.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D0EACCA.3290139@mvista.com>
References: <3D0EACCA.3290139@mvista.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Mon, 17 Jun 2002 20:45:14 -0700

   This patch replaces the timer_bh with a tasklet.

This is going to break a lot of stuff.

For one thing, the net/core/dev.c:deliver_to_old_ones() code to
disable timers no longer will work.

If you had deleted TIMER_BH you would have noticed this breakage.

Also, aren't there some dependencies on HI_SOFTIRQ being first in
that enumeration?  This needs to be answered before going further
with this patch.

