Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTDKU7u (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDKU7u (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:59:50 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:44687 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261814AbTDKU7t (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:59:49 -0400
Message-Id: <200304112111.h3BLBWgu025834@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [ANNOUNCE] udev 0.1 release
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2003 23:09:03 +0200
References: <20030411173018$2695@gated-at.bofh.it> <20030411175011$3d7e@gated-at.bofh.it> <20030411182022$7f7a@gated-at.bofh.it> <20030411184016$1180@gated-at.bofh.it> <20030411204006$0496@gated-at.bofh.it> <20030411205018$7440@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Fri, Apr 11, 2003 at 01:29:57PM -0700, Steven Dake wrote:
>> 
>> It gets even worse, because performance of hotswap events on disk adds 
>> is critical and spawning processes is incredibly slow compared to the 
>> performance required by some telecom applications...
> 
> It's critical that we quick name this disk within X milliseconds after
> it has been added to the system?  What spec declares this?

While the problem might not really be the per-device latency, what should 
be handled correctly is the following scenario:

- Someone accidentally removes the cable that connects a few hundred 
  (mounted) disks
- The cable is replaced, but - oops - to the wrong socket
- The person notices the error and now places the cable into the right
  socket.

At this time we have four concurrent hotplug events for every single
disks that we want to be finished in order and we want every disk
to end up with its original minor number in the end. If this is not
possible, the system still needs to be in a sensible state after this.

        Arnd <><
