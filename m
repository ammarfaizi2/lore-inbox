Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTFTUOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFTUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:14:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264590AbTFTUOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:14:20 -0400
Date: Fri, 20 Jun 2003 13:23:14 -0700 (PDT)
Message-Id: <20030620.132314.35673846.davem@redhat.com>
To: joern@wohnheim.fh-wedel.de
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au,
       dwmw2@infradead.org
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030620195658.GB22732@wohnheim.fh-wedel.de>
References: <20030620185915.GD28711@wohnheim.fh-wedel.de>
	<20030620.124510.28800472.davem@redhat.com>
	<20030620195658.GB22732@wohnheim.fh-wedel.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jörn Engel <joern@wohnheim.fh-wedel.de>
   Date: Fri, 20 Jun 2003 21:56:58 +0200

   On Fri, 20 June 2003 12:45:10 -0700, David S. Miller wrote:
   > Therefore we couldn't make the compress cryptolib interface
   > take scatterlists elements either, which is a huge problem.
   
   Is there a reason to use the zlib and nothing but the zlib for the
   cryptolib?  RFCs 1950 - 1952?  Or would any form of compression do, in
   principle at least?

Because it's not very sensible to have 2 pieces of code that
do exactly the same thing? :-)
   
   In the worst case, I consider it not too hard to add a wrapper
   interface to the zlib to do the scatter-gather handling.

It's not that simple.

Is the wrapper called in IRQ or BH or user context?  This matters
to determine what kind of kmap() operations you must use in the
wrapper.

That's merely the beginning of the problems with this kind of idea.

Don't let my statements stall your work, it was just a FYI and
something we should take care of in the 2.7.x timeframe not now.
