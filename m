Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbRFBVhe>; Sat, 2 Jun 2001 17:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbRFBVgo>; Sat, 2 Jun 2001 17:36:44 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:3540 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261502AbRFBVgh>; Sat, 2 Jun 2001 17:36:37 -0400
Date: Sat, 2 Jun 2001 23:36:33 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Frazer <mark@somanetworks.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: MII access (was [PATCH] support for Cobalt Networks (x86 only)
In-Reply-To: <E156H20-00023o-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106022302250.23145-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, Alan Cox wrote:

> > One application needs to poll link status with 1 second resolution. On a
>
> Then it needs to be privileged

Fine. Can you think of a default value for expiring cache ?

> And if the approach is to block until the time for the next read occurs is
> done then the program get stuck for 30 seconds, misses its deadline and kills
> the cluster - how is this better ??

Is not better. Well, when somebody is playing against you, you're in
trouble either way:
- rate limit: - blocking - as above
              - non-blocking - notify the user that you can't get the info
                and probably stop or aquire elevated priviledges and try
                to restart the network
- cache: get outdated info

But when a HA application runs, it's usually preferable to stop (and you
notice it) than to continue with wrong data. Especially if you set the
cache expiry to something like 30 seconds; think in terms of how many
transactions/second today's hardware allows...

> Doing the MII monitoring somewhere centralised like the routing daemons would
> certainly let more inteillgent management and reporting get done

I don't argue over this point, already several people mentioned it. But I
explained the present situation in a previous message: the MII info is
normally read at a low rate and some applications need it more often. It
doesn't matter that it's delivered through ioctl, netlink or any other
way, you have to read it from the hardware and deliver to user-space at
user request. So the "doing the MII monitoring" is the tough part.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

