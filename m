Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280258AbRJaPO0>; Wed, 31 Oct 2001 10:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280262AbRJaPOR>; Wed, 31 Oct 2001 10:14:17 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:4367 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S280258AbRJaPOD>;
	Wed, 31 Oct 2001 10:14:03 -0500
Message-ID: <20011031182212.A21776@castle.nmd.msu.ru>
Date: Wed, 31 Oct 2001 18:22:13 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: =?koi8-r?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.93.2i
In-Reply-To: =?koi8-r?Q?=3C20011031090125=2EB10751=40stud=2Entnu=2Eno=3E=3B_from_=22T?=
 =?koi8-r?Q?homas_Lang=E5s=22_on_Wed=2C_Oct_31=2C_2001_at_09:01:25AM?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 31, 2001 at 09:01:25AM +0100, Thomas Langås wrote:
> 
> I've now tried the Intel driver, no help, still get the NFS timeouts (the
> intel driver doesn't output anything to dmesg, so it's no way of telling if
> the same things occur as in the eepro100 stock-kernel driver). 
> 
> This is how I do the test:
> 
> NFS share a filesystem
> NFS mount it on another box (not running intel e100 nic)
> Start bonnie++ on the box that has mounted the nfs share
> 
> After 10-20mins, the first NFS timeout comes (which means the card is out of
> resources, and "halts" for a bit). When the card becomes out of resources,
> it seems like it uses a few minutes before it comes online again, no wonder
> why, tho.
> 
> Has anyone got any suggestions on how to start tracking down, and maybe
> fixing this problem?  Or, is this a hardware error?  Or maybe a firmware

Well, with eepro100 the start may be the following:
1. When the card stalls, start ping from that host.
This way you ensure that you have something in transmit ring.
If it's transmitting that stalls, you'll get a message from netdev watchdog.
2. If ping works, then your problem appear to be pure NFS one, i.e. inability
of NFS to recover from network operation disruption.
3. If ping is able to transmit, but not receive (you may check it by
tcpdump), then we have a receiver problem.
We'll think what to do then.

4. In any case, running eepro100-diag from scyld.com at the moment of the
stall may give some useful information.
5. In any case, searching eepro100 mailing list archive on scyld.com is a
good idea, you may learn what other people observe/do.

	Andrey

> error?  Should I start contacting Dell and tell them that's there's a
> possible error in their PowerEdge 2550-series?
