Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263495AbRFANP6>; Fri, 1 Jun 2001 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263496AbRFANPt>; Fri, 1 Jun 2001 09:15:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61853 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263495AbRFANPi>;
	Fri, 1 Jun 2001 09:15:38 -0400
Message-ID: <3B179579.F9C9C721@mandrakesoft.com>
Date: Fri, 01 Jun 2001 09:15:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.LNX.4.33.0106011503030.18082-100000@kenzo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> No way! If I implement a HA application which depends on link status, I
> want the info to be accurate, I don't want to know that 30 seconds ago I
> had good link.

To tangent a little bit, and add netdev to the CC...

The loss and regain of link status should be proactively signalled to
userspace using netlink or something similar.  Currently we have
netif_carrier_{on,off,ok} but it is only passively checked. 
netif_carrier_{on,off} should probably schedule_task() to fire off a
netlink message...

For your HA application specifically, right now, I would suggest making
sure your net driver calls netif_carrier_xxx correctly, then checking
for IFF_RUNNING interface flag.  IFF_RUNNING will disappear if the
interface is up, but there is no carrier [as according to
netif_carrier_ok].

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
