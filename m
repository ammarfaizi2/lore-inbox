Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTFIXEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTFIXEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:04:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61336 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262273AbTFIXEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:04:09 -0400
Date: Mon, 09 Jun 2003 16:14:35 -0700 (PDT)
Message-Id: <20030609.161435.104053652.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: wa@almesberger.net, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306100113420.12110-100000@serv>
References: <Pine.LNX.4.44.0306100011230.5042-100000@serv>
	<20030609.160013.74730356.davem@redhat.com>
	<Pine.LNX.4.44.0306100113420.12110-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 10 Jun 2003 01:14:56 +0200 (CEST)

   On Mon, 9 Jun 2003, David S. Miller wrote:
   
   > netdev->dead = 1;
   > netdev->op_this = NULL;
   > netdev->op_that = NULL;
   > netdev->op_whatever = NULL;
   > synchronize_kernel();
   
   That assumes of course that the functions don't sleep.
   (RCU isn't really the answer to everything.)
   
They hold references to the object, it doesn't matter if
they sleep.  Forget the "netdev->dead" line, it isn't necessary.
