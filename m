Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284363AbRLEM4J>; Wed, 5 Dec 2001 07:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284365AbRLEMzu>; Wed, 5 Dec 2001 07:55:50 -0500
Received: from mail002.mail.bellsouth.net ([205.152.58.22]:41862 "EHLO
	imf02bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284363AbRLEMzp>; Wed, 5 Dec 2001 07:55:45 -0500
Message-ID: <3C0E194B.2BB7E289@mandrakesoft.com>
Date: Wed, 05 Dec 2001 07:55:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Rob Myers <rob.myers@gtri.gatech.edu>, LKML <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com> <1007501048.14051.28.camel@ransom> <3C0D7CEA.2050307@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> > are references to dev->net_dev.name valid before
> > register_netdev(&dev->net_dev) in ns83820_init_one()?
> 
> Okay, so i'll move the register_netdev call earlier on in the
> initialisation and add any necessary unregister call for failures.

Not a solution but more of a problem... a user might see:

eth0: startup message
eth0: startup message
{failure, unregisters eth0}
eth0: startup message
eth0: startup message
{failure, unregisters eth0}
eth0: startup message
eth0: startup message
{failure, unregisters eth0}

That's particularly messy to diagnose when eth0 may not really be eth0. 
Further in a hotplug multi-threaded world you are reserving an ethernet
interface which may not be used.

I greatly prefer assigning board numbers (ns83820_0, ns83820_0, or ns0,
ns1, ns2) temporarily until you are sure you can register the interface
with the likelihood it will not be unregistered until module removal
time, or never [if built into kernel].

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

