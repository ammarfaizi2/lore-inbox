Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262503AbTCMRuH>; Thu, 13 Mar 2003 12:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbTCMRuH>; Thu, 13 Mar 2003 12:50:07 -0500
Received: from NODE-1.HOSTING-NETWORK.COM ([66.186.193.1]:41746 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262503AbTCMRuF>; Thu, 13 Mar 2003 12:50:05 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 13:11:33(EST) on March 13, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: Oops in firewire (2.4.21-pre5 with 2.4.21-pre4 firewire driver)
From: Torrey Hoffman <thoffman@arnor.net>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030313061144.GV563@phunnypharm.org>
References: <1047517628.1172.8.camel@rohan.arnor.net> 
	<20030313061144.GV563@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Mar 2003 10:00:45 -0800
Message-Id: <1047578447.1039.43.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 22:11, Ben Collins wrote:
> On Wed, Mar 12, 2003 at 05:06:23PM -0800, Torrey Hoffman wrote:
[ohci1394 / sbp2 problems] 

> I'd suggest with trying the latest BK cset patch (which fixes -pre5 and
> also fixes some things in general).

Thanks for the response.

Last night I (finally) installed bitkeeper, pulled the latest 2.4 tree,
and gave it a try.  It seems to have solved the problem on my single CPU
machine.  I will try my SMP machine tonight and see how things go there.

I run reiserfs on my firewire drives but ext3 on some other partitions. 
These oops have often occurred when doing rsync's between the reiserfs
on firewire and an ext3 or reiserfs partition on a regular disk or raid5
setup.  

On my SMP machine this morning (using Red Hat's 2.4.18-18smp kernel) I
had a similar oops with references to kjournald under a heavy firewire
load.   The machine didn't die, and after the bus resets completed, the
rsync from the firewire drive continued.  

These oopses have been very reproducible while loading ohci1394, and
sometimes while transferring data after loading.  They don't occur if
the sbp2 device is not attached.   I have hacked my rc.sysinit script to
always load the drivers, since Red Hat's autodetection stuff there quit
working around 2.4.18-17, and as long as the device isn't attached
2.4.18-24 boots fine and loads the drivers.

Up until installing 2.4-bk last night, I normally booted to Red Hat's
2.4.18-24 kernel, except when I need to use firewire. 2.4.18-24 doesn't
work at all for me under firewire, and 2.4.18-18 "mostly" works.)

Anyway, I will upgrade all my machines to the latest -bk snapshot and
will be back with more bug reports if I see any glitches...

Hopefully Red Hat will update their official kernel with the firewire
fixes.  And fix their rc.sysinit script too, while they are at it.  (No,
I haven't submitted a bugzilla report yet, will do so if -bk fixes
things for me...)

Thanks again,

Torrey Hoffman


> 
> > I got an oops while loading the driver.  I will continue to experiment
> > with recent kernels, and try to find a bitkeeper snapshot with the
> > latest firewire fixes.  Any suggestions are welcome.
> 
> > >>EIP; c016e639 <__journal_remove_checkpoint+39/90>   <=====
> 
> This happened in the kjournald thread context. I'm not sure it is
> ieee1394 related, but it is suspect that it happened in the middle of
> handling an ieee1394 bus reset.
> 
> Is this reproducible when loading the ohci1394 driver? If so, does it
> occur when you turn off hotplug (IOW, don't load sbp2 driver) or if the
> sbp2 device is not attached?
> 
> -- 
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> Deqo       - http://www.deqo.com/
> 


