Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLGPTT>; Thu, 7 Dec 2000 10:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLGPTJ>; Thu, 7 Dec 2000 10:19:09 -0500
Received: from zcamail01.zca.compaq.com ([161.114.32.101]:55306 "HELO
	zcamail01.zca.compaq.com") by vger.kernel.org with SMTP
	id <S129226AbQLGPSy>; Thu, 7 Dec 2000 10:18:54 -0500
Date: Thu, 7 Dec 2000 09:50:32 -0500
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre6 on alpha
Message-ID: <20001207095032.A1783@linux04.mro.cpqcorp.net>
In-Reply-To: <20001206204723.A8390@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001206204723.A8390@animx.eu.org>; from wakko@animx.eu.org on Wed, Dec 06, 2000 at 08:47:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 08:47:23PM -0500, Wakko Warner wrote:
> I'm glad to say that this is the first 2.4 kernel that works on my noritake
> alpha with a pci-pci bridge.
> 
> I have a small problem.  If I reboot, the srm console can't boot from dka0.
> Doing a: show dev
> doesn't list any of the hard drives in the machine.
> doing an init causes it to reset and find all the drives again.

During boot, the Linux kernel code (on Alpha) changes the PCI resource
settings of cards and bridges alike. Some SRM consoles do not appreciate
this... ;-}

There is code in 2.2 that restores card/bridge settings before exiting
the kernel back to console mode. This code has NOT been ported to 2.4,
due primarily to the size of the changes made to 2.4 in that area.

Could you verify that 2.2 (take the latest, please) DOES exit to SRM
correctly?

A workaround for 2.4 is to set "boot_reset" to ON in SRM, which will
force a full reset before continuing the boot. Yes, I know, for a lot
of situations this is overkill, but at least it will do the right thing
under the above described situations...

Good luck.

--Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            Alpha Engineering - LINUX Project
Compaq Computer Corp. - MRO1-2/K20         (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@compaq.com
-----------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
