Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRK1Rp5>; Wed, 28 Nov 2001 12:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRK1Rps>; Wed, 28 Nov 2001 12:45:48 -0500
Received: from toronto.mail.tucows.com ([207.136.98.42]:5651 "EHLO
	toronto.mail.tucows.com") by vger.kernel.org with ESMTP
	id <S278818AbRK1Rpk>; Wed, 28 Nov 2001 12:45:40 -0500
Message-ID: <3C0522C4.E5321021@tucows.com>
Date: Wed, 28 Nov 2001 12:45:40 -0500
From: Adrian Daminato <adrian@tucows.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hiding arp for server farms
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've seen similar posts to this, but none of them provide a solution that
I can use.

I'm running several 2.2 machines behind a Radware load balancer, which uses
something called "local triangulation".  Basically the Radware responds to ARP
requests for the IP of the farm, passes the packet to one of the servers, and
the server responds directly to the client.  Each server has an aliased
interface on the loopback for the IP of the farm, and
/proc/sys/net/ipv4/conf/all/hidden and lo/hidden are set to 1.  That works,
great, no problems.

Now, introduce an unpatched 2.4.x kernel.  The hidden option no longer exists,
and for ease of operating a production environment, we prefer to use stock
kernels straight from kernel.org, no patches at all.  I've tried many different
suggestion from the list:

1) ifconfig eth0 -arp
    We have over 60 servers on the subnet these farms are on, and they need to
be able to communicate with each other.  When I do this, I can't talk to other
servers on the network, and keeping an /etc/ethers file up to date is a daunting
task, and not practical.

2) arp_filter
    I tried using it in a couple of ways, but there doesn't appear to be very
good documentation.  I was hoping this would provide the same functionality of
the hidden in the 2.2 kernels for our current setup, but it doesn't appear to

3) I even tried adding the 'hidden' patch available, to put the hidden
functionality back in the 2.4.x kernel (currently I'm testing using a 2.4.9
kernel).  It doesn't appear to work properly either, hosts on the local network
can't ping the server farm, and hosts outside the network although able to ping
the server farm, cannot ping the real IP of the host.  It's kind of a weird
problem.

Is there any way to have this work on an unpatched 2.4.x kernel?  Any
documentation/examples for arp_filter, how it works, how it can be implemented
for this?

Any help would be appreciated.  Thanks.
-- 
Adrian Daminato 
Tucows International Corp.
http://www.tucows.com
Tel: (416) 535-0123
Fax: (416) 531-5584

Beauty awakens the soul to act.
                 - Dante
