Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbTFPWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTFPWnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:43:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20945 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264424AbTFPWnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:43:19 -0400
Date: Mon, 16 Jun 2003 15:52:51 -0700 (PDT)
Message-Id: <20030616.155251.25131382.davem@redhat.com>
To: niv@us.ibm.com
Cc: girouard@us.ibm.com, stekloff@us.ibm.com, janiceg@us.ibm.com,
       jgarzik@pobox.com, lkessler@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEE4880.3080505@us.ibm.com>
References: <OFF1F6B3DC.30C0E5DE-ON85256D47.007AEFAF@us.ibm.com>
	<20030616.152745.124055059.davem@redhat.com>
	<3EEE4880.3080505@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Mon, 16 Jun 2003 15:45:20 -0700

[ I removed this kenistonj@us.ibm.com from the CC:, it bounces... ]

   I'd agree a lot of thought (and agreement :))has to go
   into this before changing minor nits and stuff, and not
   causing too much disruption..Evolution, as opposed to
   revolution ;).  I would hope that most wouldnt need changing..

There would be absolutely ZERO disruption if you guys would use you
brains and implement what you're actually trying to achieve, a system
event logging mechanism.

We have a message queueing mechanism using sockets, called netlink,
and you can make whatever actions in the kernel you think should be
monitored go and stuff messages into this system event netlink socket.

Then, you don't have to standardize a bunch of absolutely silly
strings (I mean, the concept is so incredibly stupid), you get events
that are in a precisely defined format going over this netlink socket.

Then whoever in userspace reads out the messages can interpret them
however the fuck it wants to.  It is then trivial to parse the
messages and filter them.  Furthermore, you could even transmit such
messages over a network connection to a remote logging server as-is.

And hey, look, for network links going up and down we have the hooks
already.  Funny that...
