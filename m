Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSENO6q>; Tue, 14 May 2002 10:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315750AbSENO6p>; Tue, 14 May 2002 10:58:45 -0400
Received: from trained-monkey.org ([209.217.122.11]:44043 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S315753AbSENO6o>; Tue, 14 May 2002 10:58:44 -0400
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A43@srgraham.eng.emc.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 14 May 2002 10:58:43 -0400
Message-ID: <m3vg9q4vz0.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "xiangping" == chen, xiangping <chen_xiangping@emc.com> writes:

xiangping> Hi, When the system stucks, I could not get any response
xiangping> from the console or terminal.  But basically the only
xiangping> network connections on both machine are the nbd connection
xiangping> and a couple of telnet sessions. That is what shows on
xiangping> "netstat -t".

xiangping> /proc/sys/net/ipv4/tcp_[rw]mem are "4096 262144 4096000",
xiangping> /proc/sys/net/core/*mem_default are 4096000,
xiangping> /proc/sys/net/core/*mem_max are 8192000, I did not change
xiangping> /proc/sys/net/ipv4/tcp_mem.

Don't do this, setting the [rw]mem_default values to that is just
insane. Do it in the applications that needs it and nowhere else.

xiangping> The system was low in memory, I started up 20 to 40 thread
xiangping> to do block write simultaneously.

If you have a lot of outstanding connections and active threads, it's
not unlikely you run out of memory if each socket eats 4MB.

Jes
