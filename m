Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271892AbRH1TpS>; Tue, 28 Aug 2001 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271895AbRH1To7>; Tue, 28 Aug 2001 15:44:59 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:19390
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S271892AbRH1Tot>; Tue, 28 Aug 2001 15:44:49 -0400
Message-ID: <3B8BB364.47CFD3CF@nortelnetworks.com>
Date: Tue, 28 Aug 2001 11:06:12 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Sebastien Morisset <jsmoriss@mvlan.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iproute2 routing problem.
In-Reply-To: <20010828104118.C26589@marvin.mvlan.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Sebastien Morisset wrote:

> I have an ADSL modem on ppp0, and a CableModem on eth1. The plan is to
> make all services available on the ADSL, and use the CableModem as my
> default route (load balancing and fail-over are planned). Unfortunately,
> Linux gets confused if a public IP comes in on ppp0 since it's default
> route is eth1.

Assuming that you have cable already set up as the default route, why not do
something like this:

ip rule add to 10.1.1.0/24 lookup main pref 500
ip rule add from 64.39.178.10 lookup adsl pref 1000
ip route add default via 64.39.160.16 dev ppp0 table adsl

This way anything local gets routed over eth1, and anything nonlocal coming from
your DSL address (as it would if someone connects to your services over that
address) gets sent out over the DSL connection.

You should be able to set up some kind of variation of this for failover/load
balancing.  I've done some custom work in this area for work and a local
failover takes about 5ms after detection of a problem.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
