Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTFIX2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTFIX2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:28:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3993 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262294AbTFIX2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:28:49 -0400
Date: Mon, 09 Jun 2003 16:39:15 -0700 (PDT)
Message-Id: <20030609.163915.74729355.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: wa@almesberger.net, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306100129460.12110-100000@serv>
References: <Pine.LNX.4.44.0306100113420.12110-100000@serv>
	<20030609.161435.104053652.davem@redhat.com>
	<Pine.LNX.4.44.0306100129460.12110-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 10 Jun 2003 01:34:19 +0200 (CEST)

   You also have to wait for the already running 
   operations to finish, before you can allow the module to unload.

These things run under dev_base_lock, so either they find the device
or they don't, and since they hold a spinlock they can't preempt.
