Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTABXPQ>; Thu, 2 Jan 2003 18:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbTABXPQ>; Thu, 2 Jan 2003 18:15:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1472 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267300AbTABXPP>;
	Thu, 2 Jan 2003 18:15:15 -0500
Date: Thu, 02 Jan 2003 15:16:00 -0800 (PST)
Message-Id: <20030102.151600.129375771.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: lm@bitmover.com, tom@rhadamanthys.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1041549644.24829.66.camel@irongate.swansea.linux.org.uk>
References: <20030102221210.GA7704@window.dhis.org>
	<20030102222816.GF2461@work.bitmover.com>
	<1041549644.24829.66.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 02 Jan 2003 23:20:44 +0000

   On Thu, 2003-01-02 at 22:28, Larry McVoy wrote:
   > The VM cost hurts.  Badly.  Imagine that the network costs ZERO.  Then
   > the map/unmap/vm ops become the dominating term.  That's why it is a
   > fruitless approach, it still has a practical limit which is too low.
   
   It depends how predictable your content is. With a 64bit box and a porn
   server its probably quite tidy
   
Let's say you have infinite VM (which is what 64-bit almost is :) then
the cost is setting up all of these useless VMAs for each and every
file (which is a 1 time cost, ok), and also the VMA lookup each
write() call.

With sendfile() all of this goes straight to the page cache directly
without a VMA lookup.
