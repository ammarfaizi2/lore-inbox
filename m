Return-Path: <linux-kernel-owner+w=401wt.eu-S1751757AbXAOAPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbXAOAPl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbXAOAPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:15:41 -0500
Received: from twin.jikos.cz ([213.151.79.26]:48702 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbXAOAPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:15:40 -0500
Date: Mon, 15 Jan 2007 01:14:09 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Florin Iucha <florin@iucha.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       Alan Stern <stern@rowland.harvard.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed
 regressions (v2)
In-Reply-To: <20070114235816.GB6053@iucha.net>
Message-ID: <Pine.LNX.4.64.0701150109190.16747@twin.jikos.cz>
References: <20070109214431.GH24369@iucha.net>
 <Pine.LNX.4.44L0.0701101052310.3289-100000@iolanthe.rowland.org>
 <20070114225701.GA6053@iucha.net> <20070114235816.GB6053@iucha.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2007, Florin Iucha wrote:

> All the testing was done via a ssh into the workstation.  The console 
> was left as booted into, with the gdm running.  The remote nfs4 
> directory was mounted on "/mnt". After copying the 60+ GB and testing 
> that the keyboard was still functioning, I did not reboot but stayed in 
> the same kernel and pulled the latest git then started bisecting.  

Hi Florin,

thanks a lot for the testing. Just to verify - what kernel is 'the same 
kernel' mentioned above? (just to isolate whether the problem is really 
somewhere between 2.6.19 and 2.6.20-rc2, as you stated in previous posts, 
or the situation has changed).

> After recompiling, I moved over to the workstation to reboot it, but the 
> keyboard was not functioning ;(

So this time the hang occured when the system was idle, not during the 
transfers, right?

> I ran "lsusb" and it displayed all the devices. "dmesg" did not show
> any oops, anything for that matter.  I have unplugged the keyboard and
> run "lsusb" again, but it hang.  I ran "ls /mnt" and it hang as well.
> Stracing "lsusb" showed it hang (entered the kernel) at opening the device
> that used to be the keyboard.  Stracing "ls /mnt" showed that it
> hang at "stat(/mnt)".  Both processes were in "D" state.  "ls /root"
> worked without problem, so it appears that crossing mountpoints causes
> some hang in the kernel.

Could you please do alt-sysrq-t (or "echo t > /proc/sysrq-trigger" via 
ssh, when your keyboard is dead) to see the calltraces of the processes 
which are stuck inside kernel?

You will probably get a lot of output after the sysrq, so please either 
put it somewhere on the web if possible, or just extract the interesting 
processes out of it (mainly the ones which are stuck).

Thanks,

-- 
Jiri Kosina
