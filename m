Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSLMG4u>; Fri, 13 Dec 2002 01:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSLMG4u>; Fri, 13 Dec 2002 01:56:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52397 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261581AbSLMG4t>;
	Fri, 13 Dec 2002 01:56:49 -0500
Date: Thu, 12 Dec 2002 22:59:12 -0800 (PST)
Message-Id: <20021212.225912.115906105.davem@redhat.com>
To: dlstevens@us.ibm.com
Cc: matti.aarnio@zmailer.org, niv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF38D59D15.E0619D28-ON88256C8E.0023807F@us.ibm.com>
References: <OF38D59D15.E0619D28-ON88256C8E.0023807F@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Stevens <dlstevens@us.ibm.com>
   Date: Thu, 12 Dec 2002 23:55:35 -0700
   
         I believe the very large BSD number was based on the large
   granularity of the timer (500ms for slowtimeout), designed for use on a VAX
   780. The PC on my desk is 3500 times faster than a VAX 780, and you can
   send a lot of data on Gigabit Ethernet instead of sitting on your hands for
   an enormous min timeout on modern hardware. Switched gigabit isn't exactly
   the same kind of environment as shared 10 Mbps (or 2 Mbps) when that stuff
   went in, but the min timeouts are the same.

This is well understood, the problem is that BSD's coarse timers are
going to cause all sorts of problems when a Linux stack with a reduced
MIN RTO talks to it.

Consider also, delayed ACKs and possible false retransmits this could
induce with a smaller MIN RTO.
