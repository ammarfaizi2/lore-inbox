Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135815AbRDZSDE>; Thu, 26 Apr 2001 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135810AbRDZSCz>; Thu, 26 Apr 2001 14:02:55 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:10400
	"HELO zcars0m9.nortelnetworks.com") by vger.kernel.org with SMTP
	id <S133004AbRDZSCf>; Thu, 26 Apr 2001 14:02:35 -0400
Message-ID: <3AE862A7.60D12F62@nortelnetworks.com>
Date: Thu, 26 Apr 2001 14:02:15 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: interesting problem with raw sockets
In-Reply-To: <E14pqyb-0004bf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a piece of code that is trying to use sendmsg() on a raw socket to inject
a UDP packet onto an ethernet link.  The destination IP address is set to
another machine on the same subnet, and the packet arrives at its destination.
Thus far all is well.

However, inspection of the ethernet headers using tcpdump shows that rather than
being addressed directly to the MAC address of the destination, the packet is
instead being sent to the gateway, which then appears to forward it on to the
destination.  It almost appears as though the kernel doesn't realize that the IP
address is on the same subnet.

Here's where it gets interesting.  I grabbed what I thought was all the socket
setup and sending code from the misbehaving application and stuck them into a
tiny program that builds and sends empty packets with arbitrary source and
destination addresses.  Tcpdump shows this program behaving as expected--ie the
destination MAC address in the ethernet header is set to the MAC address of the
destination, not the MAC address of the gateway.

Does anyone have any clue what might be going on?  I'm almost ready to try
strace and kernel debugging....

Thanks,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
