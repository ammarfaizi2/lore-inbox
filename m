Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTAPSJf>; Thu, 16 Jan 2003 13:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbTAPSJf>; Thu, 16 Jan 2003 13:09:35 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:30928 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267041AbTAPSJe>;
	Thu, 16 Jan 2003 13:09:34 -0500
Date: Thu, 16 Jan 2003 10:18:27 -0800
To: irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       DevilKin <devilkin-lkml@blindguardian.org>
Subject: Re: Irda connectivity problems since 2.4.20
Message-ID: <20030116181827.GA11156@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DevilKin wrote :
> 
> Hello list,

	Wrong list ! Please post IrDA bug report on the Linux-IrDA
mailing list where more people will be able to help you.

> I recently switched my debian install over from 2.4.19 to 2.4.20. Since then 
> I've been having trouble syncing my Palm m500 over Irda. It works, but the 
> transfers seem to stall a lot, making the total hotsync take over 5 minutes 
> to complete.
> 
> The irda transfers work fine in 2.4.19.

	The IrDA patch that went into 2.4.20 have been on my web page
for over a year, so well tested...

> Framing or parity error!
> Framing or parity error!
> Framing or parity error!
> ... lots of framing errors

	This clearly point out to problems with the lower layer,
either the serial port or the TTY layer, not the IrDA stack. Verify
that the IrDA link is aligned and that there is no source of noise.
	By any chance, are you running a preemptible or SMP kernel ?

> I'm using the following irda related modules:
> irtty irport ircomm-tty ircomm irda

	You need to know if you are using irtty or irport.

> Any ideas?

	Do :
	> cat /proc/tty/driver/serial
	And send the result to the serial port author/mailing list. If
you see lot's of FE, that's your problem.

	Do an irdadump (with version 15 of irda-tools) while
connecting and send it the the IrDA mailing list.
	Try 2.4.21-pre3.
	With 2.4.20, revert the patch on my page called "Very
important fixes" and try again. If this fix the problem, you need to
try 2.4.21-pre3 with the patch called "Handle invalid QoS parameter"
and set max_tx_window to 1.

	Regards,

	Jean
