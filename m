Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTFDHmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 03:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTFDHmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 03:42:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43990 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263077AbTFDHmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 03:42:20 -0400
Date: Wed, 04 Jun 2003 00:51:45 -0700 (PDT)
Message-Id: <20030604.005145.98890243.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: niv@us.ibm.com, kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16093.36723.418623.698303@napali.hpl.hp.com>
References: <16093.34022.445246.52398@napali.hpl.hp.com>
	<3EDD8BD2.9040008@us.ibm.com>
	<16093.36723.418623.698303@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 3 Jun 2003 23:19:31 -0700
   
   Yes, the "connection hangs/disappearances" where triggered by
   TCPAbortOnTimeout;

This is correct.

And it is the reason the connection dies silently.  Because
such write timeouts invoke tcp_done() which closes the connection
off silently.  This is correct behavior (sans the RTT bug David fixed
of course :)) because a host which hasn't responded at all from
so many repeated retransmission attempts isn't likely to get any
reset we send either :)
