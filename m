Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTK3I23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 03:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbTK3I23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 03:28:29 -0500
Received: from h062040166017.gun.cm.kabsi.at ([62.40.166.17]:35749 "EHLO
	elrond.kainz.com") by vger.kernel.org with ESMTP id S264881AbTK3I20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 03:28:26 -0500
Subject: ip routing
From: Rainer Hochreiter <rainer@hochreiter.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1070180482.1852.25.camel@freddie.hochreiter.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Nov 2003 09:24:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list!

i have a problem with ip routing!

first of all my configuration:

Tux1 .... embedded linux (kernel-2.4.10) running busybox-0.60.3
          and 2 lan interfaces in different networks
          default gateway 10.1.0.254 via eth0
R1, R2 .. router (linux for testing)
Tux2 .... linux with network different to Tux1/eth0/eth1

     eth0=10.1.0.1/16 +-----+ eth1=10.2.0.1/16
                   .--|Tux1 |--.
                   |  +-----+  |
eth1=10.1.0.254/16 |           | eth1=10.2.0.254/16
                +-----+     +-----+
   ip_forward=1 | R1  |     | R2  | ip_forward=1
                +-----+     +-----+
eth0=10.3.1.254/16 |           | eth0=10.3.2.254/16
                   |           |
                   '-----+-----'
                         | eth0=10.3.0.1/16
                      +-----+
                      |Tux2 |
                      +-----+

i want to achieve, that each packet received on Tux1/eth1 will also be
replied via this interface. this isn't the case now, because the
received packets came from a different network and therefore the replies
are sent back via Tux1/eth0 using the default route.

but the replies have to be sent even when the connection between
Tux1/et0 and R1 is not available. a possible solution is, setting a
network route for network Tux2/eth0 via Tux1/eth1, but in my special
case, i do not know from which network i'll receive the packets!

and here i reached the point where my knowledge ends;-(

i tried to solve this problem in my application running on Tux1, using
the following code:

s = socket();
bind(s, "10.2.0.1"); // bind to Tux1/eth1
listen(s);
s2 = accept(s);
int yes=1;
setsockopt(s2, SOL_SOCKET, SO_DONTROUTE, &yes, sizeof(yes));

...but setting SO_DONTROUTE on socket s2 doesn't have the effect, that
the reply packets are always sent back via Tux1/eth1! 
is it possible at all to guarantee this in any case? because this means
bypassing the routing stuff!

any hints welcome!

greetings, 
rainer

PLEASE personally CC any answers and comment to my question - thnx!


