Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268190AbUHQLae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268190AbUHQLae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268189AbUHQLad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:30:33 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:55685 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268192AbUHQL3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:29:48 -0400
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       jwendel10@comcast.net, linux-kernel@vger.kernel.org,
       Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>
	<4121A689.8030708@bio.ifi.lmu.de>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 17 Aug 2004 13:29:45 +0200
In-Reply-To: <4121A689.8030708@bio.ifi.lmu.de>
Message-ID: <m37jry57fa.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> writes:

> So what's the target in this process? Should users finally be able to
> write cds again without or only with suid bit set? It would be good to
> know if I should try to set all cd writing applications suid or just
> have to wait for some patches coming up that would allow users to
> write cds without suid again...

As far as I can tell the goal is:

    With read permissions on the device you should be able to read
    from the device, such as ripping from a CD.  So all known commands
    that don't change the state of the CD should be ok.

    With write permissions you should be able to write to media, for
    example write to a tape or blank and burn a CDRW.

    For all unknown commands you need CAP_SYS_RAWIO (which for most
    system means root permissions).  So reflashing the firmware of a
    CD needs root permissions.

Some commands are a bit questionable though, for example, should it be
possible to use GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL with only read
permissions?  

The MODE_SELECT command I belive is needed for read on some tape
drives because tape parameters such as compression and tape density
are configured this way.  But there might be a device where a
MODE_SELECT on a vendor configuration page might destroy the device,
so it might not be such a good idea to allow MODE_SELECT and in that
case I don't know how it should be handled.

Hopefully all commands needed for CD/DVD reading and writing are safe
enough to be allowed with just read or write permission.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
