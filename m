Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289667AbSAOVNu>; Tue, 15 Jan 2002 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSAOVNk>; Tue, 15 Jan 2002 16:13:40 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:43728 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S289668AbSAOVNZ>; Tue, 15 Jan 2002 16:13:25 -0500
Message-ID: <3C449CE3.FBA52C68@nortelnetworks.com>
Date: Tue, 15 Jan 2002 16:19:31 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: how to do DIVERT socket equivalent with netfilter?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've got a legacy app with its own message stacks, one for tcp/icmp and one for
udp/sctp.

Currently in 2.2 we're using multiple divert sockets with appropriate ipchains
rules to direct the right traffic to each socket.  The app asks for messages for
one of the two stacks, we check if there is anything on that socket, and if
there is anything we pass it up the stack.

Now we're looking to make the thing work on 2.4.  Unfortunately, it doesn't look
like DIVERT sockets are supported in 2.4, so I started looking at netfilter's
QUEUE target.  This looks fine, except that there is only a single queue and I'd
like at least two.

Does anyone know of anything that
1) gives me multiple queues/sockets based on protocol (like DIVERT sockets)
2) ensures that the kernel itself doesn't try and handle the packet, resulting
in destination unreachable error packets (like DIVERT and netfilter)
3) works on 2.4

I can always filter the incoming messages by protocol and store them in a pair
of message queues (one for each stack) in the lower level of the app itself, but
this seems kind of kludgy and I'm sure there's gotta be a better way.  If there
is something already available I'd love to hear about it.

Any ideas?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
