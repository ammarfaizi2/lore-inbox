Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTFEBe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTFEBe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:34:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45289 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264362AbTFEBe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:34:56 -0400
Date: Wed, 4 Jun 2003 18:43:41 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk+ broken networking
Message-ID: <20030604184341.A10256@beaverton.ibm.com>
References: <20030604161437.2b4d3a79.shemminger@osdl.org> <3EDE7FEB.2C7FAEC7@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EDE7FEB.2C7FAEC7@digeo.com>; from akpm@digeo.com on Wed, Jun 04, 2003 at 04:25:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 04:25:31PM -0700, Andrew Morton wrote:
> Stephen Hemminger wrote:
> > 
> > Test machine running 2.5.70-bk latest can't boot because eth2 won't
> > come up.  The same machine and configuration successfully brings up
> > all the devices and runs on 2.5.70.
> 
> kjournald is stuck waiting for IO to complete against some buffer
> during transaction commit.
> 
> I'd be suspecting block layer or device drivers.  What device driver
> is handling your /var/log?

I also can't get networking up on current bk, I don't know if this is
the same problem, the system did not hang (I'm not running NIS?).

I also got that "sender address length == 0" message, I have not seen it
before, it seems to be output by the "ip -o link".

During boot:

[ ... ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
/bin/cat: /proc/ksyms: No such file or directory
INIT: Entering runlevel: 3
Entering non-interactive startup
Setting network parameters:  [  OK  ]
Bringing up interface lo:  [  OK  ] 
sender address length == 0 
sender address length == 0
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmapper: [  OK  ]  
Starting NFS file locking services:
[ ... ]

After logging in:

[root@elm3b79 root]# ifup eth0
sender address length == 0
[root@elm3b79 root]# ip -o link
sender address length == 0
[root@elm3b79 root]# dmesg | grep eth0
eth0: Digital DS21140 Tulip rev 33 at 0xf8800000, 00:00:BC:0F:03:EB, IRQ 36.

-- Patrick Mansfield
