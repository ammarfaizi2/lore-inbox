Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbRGPQbz>; Mon, 16 Jul 2001 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbRGPQbp>; Mon, 16 Jul 2001 12:31:45 -0400
Received: from portofix.ida.liu.se ([130.236.177.25]:53177 "EHLO
	portofix.ida.liu.se") by vger.kernel.org with ESMTP
	id <S267458AbRGPQbf>; Mon, 16 Jul 2001 12:31:35 -0400
To: linux-kernel@vger.kernel.org
Subject: Raw sockets and zero-source IP packets
X-face: (@~#v$c[GP"T}a;|MU<%Dpm5*6yv"NR|7k;uk8MAISFxdZ(Og$C{u(j"9X7v$qonp}SKfhT
 g|5[Pu~/3F7XQEk70gK'4z%1R%%gg7]}=>/jD`qcBeHDgo&HS,^S!&.zoTSxh<>-O6EB?SSy96&m37
X-url: http://www.ida.liu.se/~davby/
From: David Byers <davby@ida.liu.se>
Date: 16 Jul 2001 18:31:34 +0200
Message-ID: <41elrg4yzd.fsf@sen2.ida.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologise if this is something that has already been discussed. I
haven't been keeping track of linux-kernel for very long.

For testing purposes I need to be able to send IP packets with the
source address set to zero (at the moment for testing ICMP address
mask request/reply, but I've seen that others who want to test DHCP
and BOOTP implementations also think they need this).

Since I do not want to deal with the link layer, I would prefer to use
raw IP sockets with IP_HDRINCL. As far as I can tell all such pakets
get sent through raw_getrawfrag in net/ipv4/raw.c. This function will
always overwrite a zero source address. Short of using packet sockets
I can't see a way around this feature (unless using the control
message to set the source address would work -- I haven't tried that
in combination with IP_HDRINCL).

The questions then:

* Is there a reason for never allowing source address zero on outgoing
  IP packets? I appreciate that it is convenient not to have to set
  the source address, but I fail to see why it should be impossible to
  set it to zero if you really, really want to.

* Is there a reason for never allowing packet ID zero on outgoing IP
  packets? 

* Is there a reason for not allowing the user to specify the total
  length and checksum of IP packets? Again, I appreciate the
  convenience of this feature, but sometimes it is convenient to be
  able to construct invalid packets (again, for testing purposes)
  without having to deal with link layer details.


It seems to be fairly straightforward to add a socket option (I added
one just to make sure) that would allow the user to specify which of
the source address, total length, packet ID and checksum are not to be
touched on raw sockets, regardless of their values. 

* Can invalid values in these fields cause problems elsewhere in the
  kernel?

* If not, would a patch adding a socket option to specify fields not
  to touch stand any chance whatsoever of being included in the kernel
  (provided it's well written, doesn't break other things etc.)? 

-- 
David Byers.
