Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSHYHON>; Sun, 25 Aug 2002 03:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSHYHON>; Sun, 25 Aug 2002 03:14:13 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:5855 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317022AbSHYHOM>;
	Sun, 25 Aug 2002 03:14:12 -0400
Message-ID: <3D6884BC.5090004@candelatech.com>
Date: Sun, 25 Aug 2002 00:18:20 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: packet re-ordering on SMP machines.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears from my initial tests on 2.4.20-pre4, that packets sent on
one port, and received on another port on the same machine (via a cross-over
cable), can be re-ordered.  I see about 2000 reordered packets per 5,000,000 packets
sent (sending about 70,000 packets-per-second on a dual-port e1000 NIC.)

By re-ordered, I mean that a method called from process_backlog in dev.c
is being handed packets in a different order than they are being poked into
the driver with hard_start_xmit on the other interface.  If each CPU can be running the
process_backlog, then I can see how this could be happening.


1)  Is this expected behaviour?

2)  Is there any standard (ie configurable) way to enforce strict ordering on an
     SMP system?

3)  If answer to 2 is no, would you all be interested in a patch that
     did allow strict ordering (if indeed I can figure out how to write one)?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


