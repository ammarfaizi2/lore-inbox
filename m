Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRKZEps>; Sun, 25 Nov 2001 23:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRKZEpi>; Sun, 25 Nov 2001 23:45:38 -0500
Received: from gear.torque.net ([204.138.244.1]:8979 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S275743AbRKZEpc>;
	Sun, 25 Nov 2001 23:45:32 -0500
Message-ID: <3C01C919.39C732B3@torque.net>
Date: Sun, 25 Nov 2001 23:46:17 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marko van Dooren <Marko.vanDooren@cs.kuleuven.ac.be>,
        linux-kernel@vger.kernel.org
Subject: Re: philips CDD 3610 cd-writer freezes system with any 2.4 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko van Dooren wrote:

> [1.] philips CDD 3610 cd-writer freezes system with any 2.4 kernel
> [.2] with any 2.4 kernel, writing a cd results in a system freeze. fast 
> blanking works, but writing locks up everything. With 2.2.x kernels, 
> everything works fine. I have a dual celeron system (the *ss-sucking Abit BP6 
> mainboard :( )
> <snip/>

Marko,
Some of us were just discussing a Yamaha cdwriter lockup
on the cdwrite list. In that case stopping magicdev
(on GNOME) or kscd (on KDE) cured the problem.

If the maintainers of those programs are reading this,
then some cdwriters take a dim view (i.e. lock up)
if they are sent a TEST UNIT READY (or some such) SCSI
command by one of these polling programs _while_ cdrecord
is trying to do its thing. Please read the "access_count"
[via sg] and leave the device alone if some other program
(e.g. cdrecord) has the device open.

Perhaps the SCSI subsystem's access_count could be made
visible via the cdrom driver's interface.

Doug Gilbert
