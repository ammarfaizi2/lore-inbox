Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290958AbSBRTJN>; Mon, 18 Feb 2002 14:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290816AbSBRTH3>; Mon, 18 Feb 2002 14:07:29 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:19091 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S291103AbSBRTFh>; Mon, 18 Feb 2002 14:05:37 -0500
Message-ID: <3C715253.A4DFD89B@nortelnetworks.com>
Date: Mon, 18 Feb 2002 14:13:23 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: odd issue with sending to broadcast address
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears that there has been a change in the handling of sending packets to
the broadcast IP address between 2.2 and 2.4.

I have an embedded system that has only local LAN access, no default route to
the net as a whole.  We're running 2.2.17 currently, and we use bootpc to
configure the system.

We're now looking at converting to 2.4 and are running into a problem with
bootpc getting "Network is unreachable" errors.

After some digging, it appears to be due to the fact that I don't have a default
route specified, but this is on purpose.

strace shows that bootpc is trying to run sendto() with a destination of
255.255.255.255, and this works fine on 2.2 and fails on 2.4.  Is this the
desired 2.4 behaviour?

What is the appropriate configuration for my setup?  Do I just add a route to
255.255.255.255?  Can I set it up to broadcast out all devices automatically, or
do I need to do explicit failover management?  Should I be looking to fix bootpc
instead?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
