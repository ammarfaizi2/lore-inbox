Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTDZP6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 11:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTDZP6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 11:58:52 -0400
Received: from [81.80.245.157] ([81.80.245.157]:59780 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S261805AbTDZP6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 11:58:50 -0400
Date: Sat, 26 Apr 2003 18:10:09 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426161009.GC18917@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr> <20030426143445.GC2774@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426143445.GC2774@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 10:34:45AM -0400, Ben Collins wrote:

> > And guess what ? The new patch broke (again) my setup. When I plug
> > in my iPod, the scsi layer does not see it anymore.
> 
> Good lord would you calm down.

No. You did broke the subsystem in several occasions, you do this
at the bad moment, and now you introduced a change in behaviour
in a stable kernel release, between -rc1 and -rc2, without any
warning. I think I have enough reasons to be angry.

> Run the rescan-scan-scsi.sh script floating around. Out own website
> describes having to use this for 2.4 kernels.
[...]

The FAQ on linux1394 site was indeed updated 2 days ago. I'm sorry
I didn't think to look there.

Before posting, I did try to check the linux1394 mailing lists for 
information. linux1394-announce has no new mails since march, 
linux1394-devel didn't seem to contain anything obvious about this
(besides a thread "Re: Problem with Kernel 2.4.21-rc1 - latest svn"
which I couldn't read due to sourceforge problems - it kept saying
"no such forum"...)

I did look at the subversion checkin' log. I did look at the bitkeeper
checkin' log. Nothing there.

> It was either leave sbp2
> oopsing, or rewrite the load logic so that there was no way for left
> over scsi cruft. The side affect is that the only hot-plug situation
> ieee1394 had in 2.4 is gone.

Strange, usb-storage seems to work quite fine with respect to the
scsi layer and hotplug...

> Before, loading sbp2 before loading ohci1394 gave the same affect. Now,
> loading sbp2 before ohci1394 also requires running rescan-scan-scsi.sh.
> Blame the scsi layer, not me.

BTW: hotplug removing is still half broken: the hotplug remove event
is send only when the device is physically disconnected. If I remove
the sbp2 module with rmmod, I'll get nothing.

This means that if you do
	rmmod sbp2
	modprobe sbp2
your SCSI device will be lost and you'll have to call 'rescan-scsi-bus'
by hand...

> 
> -- 
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> Deqo       - http://www.deqo.com/

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
