Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265843AbUFDP51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUFDP51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUFDPzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:55:10 -0400
Received: from paris.dvs1.informatik.tu-darmstadt.de ([130.83.166.129]:31681
	"EHLO paris.dvs1.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S265852AbUFDPy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:54:29 -0400
Date: Fri, 4 Jun 2004 17:54:23 +0200
From: "Wesley W. Terpstra" <terpstra@gkec.tu-darmstadt.de>
To: linux-kernel@vger.kernel.org
Subject: Broken? 2.6.6 + IP_ADD_SOURCE_MEMBERSHIP + SO_REUSEADDR
Message-ID: <20040604155423.GA5656@muffin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am using the new IGMPv3 support in the 2.6.* series for Single Source
Multicast (SSM). However, the kernel appears to (incorrectly) drop packets
in some situations.

What I do is this: open a UDP port, set it SO_REUSEADDR, bind it to port
6767, and then use IP_ADD_SOURCE_MEMBERSHIP to listen to multicast group 
232.65.43.21 and with a command-line controlled sender.

If I launch the same program twice with different senders, the first program
ceases to receive multicast packets. (Neither from its own sender, nor the
second program's sender) The second program receives packets from its
designated sender only (as expected).

I know from tcpdump that the switch is delivering messages from the first
designated sender. The kernel is simply not giving them to the application.

Some more observations:

If both programs specify the same sender, then both programs receive the
message (as expected).

This is not an issue with subscribing to multiple senders in general. A
single program listening to two senders does receive messages from both.

This seems like a bug to me.

PS. I am not subscribed to this list, so please CC me.

-- 
Wesley W. Terpstra
