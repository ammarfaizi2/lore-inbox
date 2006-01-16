Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWAPJBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWAPJBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWAPJBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:01:45 -0500
Received: from free.wgops.com ([69.51.116.66]:28688 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751092AbWAPJBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:01:44 -0500
Date: Mon, 16 Jan 2006 02:01:21 -0700
From: Michael Loftis <mloftis@wgops.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.8 NFS not stateless and random failures?
Message-ID: <5B305675488C8F97FCE35455@dhcp-2-206.wgops.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sincere apologies if this gets posted twice, old habits die hard, and I 
was posting to rutgers instead of kernel.org!)

We recently attempted to upgrade a completely working Linux 2.4 NFS 
environment to 2.6 based server, nothing else has changed, at all, just the 
server.

On with the show, when did the 2.6 series NFS lose it's stateless ability? 
Now whenever I update NFS exports, or reboot the NFS server, I have to 
remount or reboot all NFS clients now.  I thought part of the whole point 
of NFS is it is stateless.  Indeed we didn't have this behavior before 
2.6...

Secondly we're getting weird intermittent failures, most easily seen by the 
webservers with logs along the lines of below, apparently random, and 
inconsistent.  I removed the particular path and client from the below log 
entry.  There is NOT a permissions problem on these elements.  Subsequent 
accesses will (usually) succeed.  Right after a reboot everything will be 
fine for a while...then after a bit the webserver starts to get these 
errors intermittently, with no apparent reasoning behind them.  Again, with 
2.4, we had nothing of the sort going on except in the (very very limited 
and few) legitimate cases caused by customers setting incorrect perms.

[Sun Jan 15 12:14:00 2006] [error] [client a.b.c.d] (13)Permission denied: 
access to /path... failed because search permissions are missing on a 
component of the path

Debian 3.1 Kernel 2.6.8-2-686-smp w/ ReiserFS on LVM on a qlogic QLA2342 
(2312) based PCI-X/133Mhz card.

No errors or other oddities at all being logged on NFS server, completely 
quiet.

We will probably have to roll back to 2.4, esp. since I can't reproduce 
this.

--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
