Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFHGq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTFHGq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:46:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24970 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261151AbTFHGq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:46:29 -0400
Date: Sat, 07 Jun 2003 23:57:06 -0700 (PDT)
Message-Id: <20030607.235706.41641672.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: wa@almesberger.net, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306071922350.12110-100000@serv>
References: <20030606212026.I3232@almesberger.net>
	<20030606.235811.39162108.davem@redhat.com>
	<Pine.LNX.4.44.0306071922350.12110-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Sat, 7 Jun 2003 21:01:54 +0200 (CEST)
   
   The basic problem is still that module_exit is a synchronous interface, 
   from where you can't call any asynchronous functions, unless you prevent 
   new callbacks via try_module_get() or you have to wait for all pending 
   events.

We don't use module refcounts at all anymore for netdev objects.
That's the whole key.

Module refcounts are spurious when a subsystem does it's own sane
accounting and uses strictly dynamically allocated objects.
