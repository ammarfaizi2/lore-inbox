Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263906AbTKZIRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 03:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTKZIRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 03:17:46 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:22283 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263906AbTKZIRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 03:17:45 -0500
Date: Wed, 26 Nov 2003 09:17:45 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: ipv4-mapped ipv4 connect() for UDP broken in test10
Message-ID: <20031126081745.GA31415@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My IPv6 port for djbdns' dnscache does not work with -test10.

The symptom is that all queries time out.

Some digging reveals that djbdns does this (with scope_id 0):

  socket(PF_INET6,...)
  bind socket to ::
  connect() socket to IP of peer (in this case, 210.81.13.179)
  send() dns query

at this point, the query is not sent over ppp0 as it should, but it is
sent to lo.  Not only that, but the queries are _received_ by the same
djbdns (with servfail), although the destination IP is as said above
210.81.13.179 and none of my local IPs: 10.0.0.6, 127.0.0.1, or
217.88.123.45.

Any ideas?  Please do not ship 2.6.0-final with a bug like this in it!

Felix
