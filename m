Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSGYGGx>; Thu, 25 Jul 2002 02:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSGYGGx>; Thu, 25 Jul 2002 02:06:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51391 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318345AbSGYGGw>;
	Thu, 25 Jul 2002 02:06:52 -0400
Date: Wed, 24 Jul 2002 22:59:21 -0700 (PDT)
Message-Id: <20020724.225921.108418454.davem@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <aho48s$2ko$1@penguin.transmeta.com>
References: <20020724170752.A14089@bougret.hpl.hp.com>
	<aho48s$2ko$1@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: torvalds@transmeta.com (Linus Torvalds)
   Date: Thu, 25 Jul 2002 06:02:04 +0000 (UTC)
   
   It gets a bit more complicated partly because you could nest cli/sti,
   and you can't nest spinlocks, but on the whole none of it is "rocket
   science". 

Actually the "rocket science" part is that these "cli()" users in the
unmaintained net stacks also want cli() to shut up input packet
processing as well as TIMER_BH.

This means they assume that cli() means "nobody can even look at the
existence of any of the timers".  Ie. they do this to ensure they
can simply del_timer and there is no possibility someone sits inside
of the actual handler.

Of course del_timer_sync can be used to deal with that specific
case.  But this specific example is just the tip of the iceberg.

I really think it is unwise to even imply that this kind of cli/sti
fixup can be done in some mindless manner, it really can't :-)
