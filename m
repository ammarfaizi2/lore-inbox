Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRDSRI5>; Thu, 19 Apr 2001 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRDSRIq>; Thu, 19 Apr 2001 13:08:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2231 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S131460AbRDSRIa>; Thu, 19 Apr 2001 13:08:30 -0400
Message-ID: <3ADF1B51.87609B3A@nortelnetworks.com>
Date: Thu, 19 Apr 2001 13:07:29 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: NIIBE Yutaka <gniibe@m17n.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ARP handling in case of having multiple interfaces on same segment
In-Reply-To: <200104190042.JAA23614@mule.m17n.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NIIBE Yutaka wrote:
> 
> Sometime, we have setting like following (say, in the migration
> process of changing IP networks, or perhaps wrong way of load
> balancing):
> 
>         +----------+
>         |eth0 eth1 |
>         +----------+
>            |   |
>     -------+---+------------
> 
> Current implementation of Linux doesn't handle this case.  The problem
> is ARP handling.  When ARP broadcast packet comes to the host, both
> interfaces receive the packet, and regardless of the device, we reply
> to that packet.  I think that we should not reply if the packet is not
> related to that interface.  If the ARP request is for eth1's address,
> we should not send reply from eth0.


Under later 2.2 kernels there is something called arp_filter that can be enabled
to give the exact behaviour you want. Apparently it is not yet in 2.4, but I
think that it should definately be added.

See the "ARP responses broken!" thread for more on this.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
