Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132798AbRC2Rix>; Thu, 29 Mar 2001 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRC2Rin>; Thu, 29 Mar 2001 12:38:43 -0500
Received: from www.resilience.com ([209.245.157.1]:47573 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132798AbRC2Ri3>; Thu, 29 Mar 2001 12:38:29 -0500
Message-ID: <3AC373BE.FCE96825@resilience.com>
Date: Thu, 29 Mar 2001 09:41:18 -0800
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Panic after using bonding driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on a driver similar to the bonding driver and have
come across a bug in the bonding driver code.  When the bonding driver
enslaves a device, it modifies the slave's multicast list to be the
master's multicast list.  Later, after the master is downed, the kernel
gets a panic if you try to down the slave device.

To get around this problem, there are two solutions that I see:

1)  Don't do multicasting for bonding devices
	While this works (I've tested) some peple might call this a serious
limitation.
2)  Keep track of the slave's multicast list
	This would require keeping a copy of the slave's pointer and restoring
it when the bonding
	device is downed.  Not sure if this would even work since the slave's
multicast list might
	be stale by the time it is restored.

I'd like to get this fixed in the best possible way.  What are your
folks comments in regard to the matter?


-Jeff


-- 
Jeff Golds
jgolds@resilience.com
