Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRHaRWw>; Fri, 31 Aug 2001 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268675AbRHaRWm>; Fri, 31 Aug 2001 13:22:42 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:706
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S268432AbRHaRWd>; Fri, 31 Aug 2001 13:22:33 -0400
Message-ID: <3B8FC7E8.2710D1EC@nortelnetworks.com>
Date: Fri, 31 Aug 2001 13:22:48 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: valentyn@nospam.openoffice.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: iproute2, portfw oddities (2.2.19 ppp)
In-Reply-To: <3B8FB778.E055FBD7@openoffice.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valentijn Sessink wrote:

> The ppp's all could have a "default route" to the Internet, only the ISP
> filters source addresses, so you cannot possibly send a ppp0 IP-address
> through ppp1 or vice versa.
> 
> Now policy routing seemed the correct solution for this and I tried this
> for ppp1:
> 
> # ip ru list
> 0:      from all lookup local
> 1001:   from 194.10.21.181 lookup ppp1
> 32766:  from all lookup main
> 32767:  from all lookup default
> # ip route list table ppp1
> default dev ppp1  scope link
> 
> This works, as I can ping the ppp1 address from the outside. (which
> could not be done before).
> 
> Unfortunately, when I try to put a portfw rule on top of this, things go
> wrong:
> 
> # ipmasqadm portfw -a -P tcp -L 194.10.21.181 80 -R 192.168.0.133 80
> 
> Strangely, this results in packets from 192.168.0.133 being renamed
> 194.10.21.181 *but being directed via ppp0*: tcpdump ppp0 sees packets
> coming from IP address 194.10.21.181.



I'm guessing that the IP address mangling is happening after deciding which
device to send the packet out of.

However, I'm not an expert on routing, so lets see what the real gurus say.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
