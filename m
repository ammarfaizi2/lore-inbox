Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSHWA7u>; Thu, 22 Aug 2002 20:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318130AbSHWA7u>; Thu, 22 Aug 2002 20:59:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14460 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318128AbSHWA7t>; Thu, 22 Aug 2002 20:59:49 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org>
	<3D62BC10.3060201@mandrakesoft.com>
	<3D62C2A3.4070701@mandrakesoft.com>
	<m1sn17pici.fsf@frodo.biederman.org>
	<3D656FDC.8040008@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Aug 2002 18:50:30 -0600
In-Reply-To: <3D656FDC.8040008@mandrakesoft.com>
Message-ID: <m1ofbupfe1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Eric W. Biederman wrote:
> > I don't see any checking for the ATA bsy flag before you start sending
> > commands.  I have seen the current IDE code fail too many times if I
> > boot to fast, because of a lack of this one simple test.  So I don't
> > see how this could be considered a proper probe.
> 
> 
> There is no ATA bsy flag check at only one point, and that is before EXECUTE
> DEVICE DIAGNOSTIC is issued.  The idea with this command is that it pretty much
> stomps up and down the ATA bus, trouncing ongoing activity in the process.

The problem is that immediately after bootup ATA devices do not respond until
their media has spun up.  Which is both required by the spec, and observed in
practice.   Which is likely a problem if this code is run a few seconds after
bootup.  Which makes it quite possible the drive will ignore the EXECUTE DEVICE
DIAGNOSTICS and your error code won't be valid when the bsy flag
clears.   I don't know how serious that would be. 

I can test and find out but I would rather confine my testing to
commands that look like they will stay within the realms of
predictable behavior.

And yes with LinuxBIOS I can reliably boot up fast enough to make this
problem show up in practice.

Eric
