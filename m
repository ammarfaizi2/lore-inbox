Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbQKBX4G>; Thu, 2 Nov 2000 18:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbQKBXzy>; Thu, 2 Nov 2000 18:55:54 -0500
Received: from web5205.mail.yahoo.com ([216.115.106.86]:58120 "HELO
	web5205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129436AbQKBXzp>; Thu, 2 Nov 2000 18:55:45 -0500
Message-ID: <20001102235538.25699.qmail@web5205.mail.yahoo.com>
Date: Thu, 2 Nov 2000 15:55:38 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: 255.255.255.255 won't broadcast to multiple NICs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.2.16, broadcast packets addressed to
255.255.255.255 do not go out to all interfaces in a
machine with multiple network cards.  They're getting
routed out the default gateway's interface instead.

If I ifconfig eth1 down (which has the gateway behind
it), I start getting "no route to host", even though
the other subnet's still up and the default gateway's
cleaned out of the routing tables.  Under no
circumstances can I get the broadcast packet to go out
more than one interface (I hate to say "like it does
under windows" but in this case, yes).

The packets aren't actually getting sent to the
gateway, they're just getting sent out the gateway's
interface.  They're still broadcast packets.  I.E. in
a machine with only one NIC, broadcasting
255.255.255.255 works fine.

Is there something I can echo into /proc somewhere to
make this work, or some magic combination of ifconfig
and route that will tell it to actually broadcast out
more than one interface?  Should I mess around with
the ethernet bridging code?  I don't know if any of
these will work.  The problem seems to be conceptual:
when one packet goes into the stack, only one packet
comes out.  Global broadcast means with multiple NICS,
multiple packets should come out (one per NIC), and
apparently there's no support for that.

Ummm...  Help?

(I have config info and test code if you can't
reproduce this.  I, unfortunately, have spent the
entire afternoon trying NOT to reproduce this. 
Sigh...)

Rob

__________________________________________________
Do You Yahoo!?
>From homework help to love advice, Yahoo! Experts has your answer.
http://experts.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
