Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRGWUN5>; Mon, 23 Jul 2001 16:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGWUNr>; Mon, 23 Jul 2001 16:13:47 -0400
Received: from [47.129.117.131] ([47.129.117.131]:37248 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S267529AbRGWUNe>; Mon, 23 Jul 2001 16:13:34 -0400
Message-ID: <3B5C855C.959ABB@nortelnetworks.com>
Date: Mon, 23 Jul 2001 16:13:16 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sourav@csa.iisc.ernet.in
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arp problem
In-Reply-To: <Pine.SOL.3.96.1010724011120.10879A-100000@kohinoor.csa.iisc.ernet.in>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sourav Sen wrote:
> 
> Hi,
>         I have a machine with multiple network cards with different IP
> addresses assigned. All are in the same network (I need this for
> whatever reason). But when a arp request
> appears on the wire for any of these IP addresses, all the interfaces go
> ahead and give their respective ethernet addresses against that IP
> address (I have seen this with tcpdump). This causes the other machines to
> pick up wrong ethernet address against the IP address.

Yep, this is the default behaviour since multiple links on one subnet is
an unusual situation (I ran into the same problem).  The solution is to apply
the arpfilter patch to the kernel, recompile, and then write a 1 to
/proc/sys/net/ipv4/conf/all/arp_filter to enable it for all interfaces.
This patch enforces that NICs will only respond to arps for IP addresses
that they own.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
