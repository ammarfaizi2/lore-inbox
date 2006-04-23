Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWDWFvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWDWFvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 01:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWDWFvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 01:51:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20187
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751312AbWDWFvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 01:51:11 -0400
Date: Sat, 22 Apr 2006 22:51:10 -0700 (PDT)
Message-Id: <20060422.225110.34182257.davem@davemloft.net>
To: joern@wohnheim.fh-wedel.de
Cc: netdev@axxeo.de, simlo@phys.au.dk, linux-kernel@vger.kernel.org,
       mingo@elte.hu, netdev@vger.kernel.org, ioe-lkml@rameria.de
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060422114846.GA6629@wohnheim.fh-wedel.de>
References: <20060420.120955.28255828.davem@davemloft.net>
	<200604211852.47335.netdev@axxeo.de>
	<20060422114846.GA6629@wohnheim.fh-wedel.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jörn Engel <joern@wohnheim.fh-wedel.de>
Date: Sat, 22 Apr 2006 13:48:46 +0200

> Unless I completely misunderstand something, one of the main points of
> the netchannels if to have *zero* fields written to by both producer
> and consumer.  Receiving and sending a lot can be expected to be the
> common case, so taking a performance hit in this case is hardly a good
> idea.

That's absolutely correct, this is absolutely critical to
the implementation.

If you're doing any atomic operations, or any write operations by both
consumer and producer to the same cacheline, you've broken things :-)
