Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWJPQvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWJPQvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964770AbWJPQvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:51:24 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:12953 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S964769AbWJPQvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:51:23 -0400
Message-ID: <4533B889.5060302@s5r6.in-berlin.de>
Date: Mon, 16 Oct 2006 18:51:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>,
       linux1394-user@lists.sourceforge.net
Subject: Re: raw1394 problems galore
References: <4532DF11.9060704@verizon.net>
In-Reply-To: <4532DF11.9060704@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2006, Gene Heskett wrote to lkml and fedora-list:
> Greetings all;
> 
> After about 4 days of snooping around trying to get kino, either 08.xx 
> or 0.9.2, to run here, I'm getting noplace at a very high rate of speed.
> 
> System is an HP dv5120us lappy, with ddual boot of xp and FC5, with FC5 
> about as uptodate as can be managed when the kmod stuff is always 1 or 2 
> versions behind the kernel, so I'm still running 2.6.17-1.2174_FC5 for a 
> kernel.
> 
> Specifically, kino-0.8.0-2.lvn5.i386.rpm can receive and record a/v from 
> my camera, a Sony TRV-460, but cannot control it via the av/c controls 
> as it cannot 'see' a device to do the controls in the prefs->ieee1394 
> screen.

Could be version problems between kernel--library--app. Maybe somebody
else knows more about it. But it's more probably the same problem as the
following:

> Then kino-0.9.2-1.lvn5.i386.rpm cannot even see the raw1394 interface, 
> reporting on its screen that the raw1394 kernel module isn't loaded, or 
> that it cannot read/write /dev/raw1394.

HP dv5120us is based on Turion 64. Do you run a 64bit kernel on it? Then
the following bug may prevent access:
http://bugzilla.kernel.org/show_bug.cgi?id=4779
The bug has been fixed for read and write operations on /dev/raw1394 in
Linux 2.6.17 (actually 2.6.16-git11).

The bug has _not_ been fixed yet for "ioctl" operations. The so-called
rawiso interface for isochronous transmission and reception uses ioctls.
I suppose the older Kino version could have slightly more success for
you simply because it uses a different interface for iso transmission
and reception.

My last comment in the bugzilla entry points to explanations on
64bit<-->32bit compatibility code for ioctls, in case anybody feels up
to hack the kernel and contribute the rest of the fix.

Gene, if you run a 64bit kernel, check if you could switch to a 32bit
kernel --- if only to confirm or deny that this is indeed the bug that
is biting your setup. Another thing to try is to test whether gscanbus
or 1394commander can work with raw1394. But as the _very first step_,
check the kernel log for messages from the 1394 drivers.

> The module is loaded when the cable is plugged in, and the 
> /etc/security/console.perms.d/50-defaults has been edited so that 
> /dev/raw1394 as created by the hotplug event now has these perms:
> crw-rw-rw- 1 root root 171, 0 Oct 15 20:20 /dev/raw1394
> 
> This has had no effect on the performance of either version of kino.
> 
> So when do we actually get a functioning firewire interface, which we 
> DID have 18 months ago in FC2,

Did you run FC2 as 32bit environment on 32bit kernel?

> before someone just had to rewrite the 1394 stuff again?

The 1394 kernel drivers are not being rewritten. We just discover old
bugs, try to fix them on a rather slow rate, and sometimes introduce
regressions along with bug fixes. (We try not to do so, but there is
weird hardware out there.) I think similar things can be said about the
status quo of libraw1394's development; minus the regressions I hope. I
don't know about the other libraries and about the status of the
application software. The last big "rewrite" concerning the whole stack
from kernel to apps was the addition of the rawiso programming
interface, which was quite a long time ago, but migration of application
programs to it seems to be a still ongoing process, including
deployment. (Even Linux 2.4 has the rawiso interface.)

(I added linux1394-user to the Cc list. You don't need to subscribe
there; just keep all Ccs during the discussion.)
-- 
Stefan Richter
-=====-=-==- =-=- -=-==
http://arcgraph.de/sr/
