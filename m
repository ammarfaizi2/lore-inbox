Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUAGQtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUAGQtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:49:18 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:29329 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266242AbUAGQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:49:17 -0500
Date: Wed, 7 Jan 2004 17:49:08 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Networking problems with 2.6.1-rc2
Message-ID: <20040107164908.GA24660@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The box I'm seeing this on has a single inet interface "eth0,"
which is connected to LAN.

	# ip addr add 172.27.0.1/16 brd + dev eth0 label eth0:1
	$ nmap -sP -T Insane '172.27.*.*'

There are no live addresses from the 172.27.0.0/16 range on the LAN.
After about a minute into the ping sweep, nmap starts printing messages like:

	Strange read error from 172.27.4.26: Transport endpoint is not connected
	Strange read error from 172.27.4.27: Transport endpoint is not connected
	Strange read error from 172.27.4.28: Transport endpoint is not connected
	...

and dmesg reveals these errors:

	Neighbour table overflow.
	NET: 46 messages suppressed.
	...

Then, trying to issue a simple "ping 172.27.5.5" results in:

	connect: No buffer space available

I'm unable to reproduce the problem with a 2.4 kernel.

-- 
Tomas Szepe <szepe@pinerecords.com>
