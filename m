Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbREAMlr>; Tue, 1 May 2001 08:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135339AbREAMlh>; Tue, 1 May 2001 08:41:37 -0400
Received: from web5202.mail.yahoo.com ([216.115.106.170]:13070 "HELO
	web5202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135318AbREAMl0>; Tue, 1 May 2001 08:41:26 -0400
Message-ID: <20010501124124.1532.qmail@web5202.mail.yahoo.com>
Date: Tue, 1 May 2001 05:41:24 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: New rtl8139 driver prevents ssh from exiting.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel thread the new rtl8139 driver spawns
apparently wants to write to stdout, because it counts
as an unfinished process that prevents an ssh session
from exiting.

I have a script that remotely reconfigures subnets in
a vpn, which gets run via an ssh in through eth0 and
does, among other things:

ifconfig eth1 down
ifconfig eth1 up

Hence kicking off the thread.  I have to run "killall
eth1" at the end of the script to make ssh exit. 
(This doesn't seem to have any negative impact on
eth1's functioning.)

Anybody feel like shedding light on this?

Rob

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
