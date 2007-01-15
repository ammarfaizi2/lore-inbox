Return-Path: <linux-kernel-owner+w=401wt.eu-S1751747AbXAOAOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXAOAOz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXAOAOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:14:55 -0500
Received: from pat.uio.no ([129.240.10.15]:34162 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746AbXAOAOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:14:54 -0500
Subject: Re: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed
	regressions (v2)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Florin Iucha <florin@iucha.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20070114235816.GB6053@iucha.net>
References: <20070109214431.GH24369@iucha.net>
	 <Pine.LNX.4.44L0.0701101052310.3289-100000@iolanthe.rowland.org>
	 <20070114225701.GA6053@iucha.net>  <20070114235816.GB6053@iucha.net>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 19:14:37 -0500
Message-Id: <1168820077.6465.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 4CB8B4861E8C0C376B0ABCDBACB255147347506C
X-UiO-SPAM-Test: 69.242.210.120 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 17:58 -0600, Florin Iucha wrote:
> All the testing was done via a ssh into the workstation.  The console
> was left as booted into, with the gdm running.  The remote nfs4
> directory was mounted on "/mnt".
> 
> After copying the 60+ GB and testing that the keyboard was still
> functioning, I did not reboot but stayed in the same kernel and pulled
> the latest git then started bisecting.  After recompiling, I moved
> over to the workstation to reboot it, but the keyboard was not
> functioning ;(
> 
> I ran "lsusb" and it displayed all the devices. "dmesg" did not show
> any oops, anything for that matter.  I have unplugged the keyboard and
> run "lsusb" again, but it hang.  I ran "ls /mnt" and it hang as well.
> Stracing "lsusb" showed it hang (entered the kernel) at opening the device
> that used to be the keyboard.  Stracing "ls /mnt" showed that it
> hang at "stat(/mnt)".  Both processes were in "D" state.  "ls /root"
> worked without problem, so it appears that crossing mountpoints causes
> some hang in the kernel.
> 
> Based on this info, I think we can rule out any USB.  I will try
> testing with NFS3 to see if the problem persists.  Unfortunately there
> is no oops or anything in "dmesg".

Did you try an 'echo t > /proc/sysrq-trigger' in order to find out where
the stat process is hanging?

  Trond

