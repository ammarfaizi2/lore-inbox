Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTFIFYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 01:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTFIFYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 01:24:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264158AbTFIFYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 01:24:30 -0400
Date: Sun, 08 Jun 2003 22:35:01 -0700 (PDT)
Message-Id: <20030608.223501.71104915.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: wa@almesberger.net, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306082228460.5042-100000@serv>
References: <Pine.LNX.4.44.0306071922350.12110-100000@serv>
	<20030607.235706.41641672.davem@redhat.com>
	<Pine.LNX.4.44.0306082228460.5042-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Mon, 9 Jun 2003 00:32:49 +0200 (CEST)

   On Sat, 7 Jun 2003, David S. Miller wrote:
   
   > We don't use module refcounts at all anymore for netdev objects.
   > That's the whole key.
   
   If I read the source correctly, unregister_netdevice() simply does rip the 
   device out and sees what happens? It's a bit primitive, but should of 
   course work too.

The transition is half complete.  Eventually even that
"wait for refcount to hit zero" part will go away, and
also we will add the logic to mark the device at "dead"
and then teach all the sysfs/procfs routines to error out
if they see the device they are examining is in this state.
