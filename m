Return-Path: <linux-kernel-owner+w=401wt.eu-S1750887AbXAOP6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXAOP6c (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbXAOP6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:58:32 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:39240 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750882AbXAOP6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:58:31 -0500
Date: Mon, 15 Jan 2007 10:58:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Florin Iucha <florin@iucha.net>
cc: Jiri Kosina <jikos@jikos.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed
 regressions (v2)
In-Reply-To: <20070115020221.GC6053@iucha.net>
Message-ID: <Pine.LNX.4.44L0.0701151055010.15327-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2007, Florin Iucha wrote:

> Jiri and Trond,
> 
> On Mon, Jan 15, 2007 at 01:14:09AM +0100, Jiri Kosina wrote:
> > On Sun, 14 Jan 2007, Florin Iucha wrote:
> > 
> > > All the testing was done via a ssh into the workstation.  The console 
> > > was left as booted into, with the gdm running.  The remote nfs4 
> > > directory was mounted on "/mnt". After copying the 60+ GB and testing 
> > > that the keyboard was still functioning, I did not reboot but stayed in 
> > > the same kernel and pulled the latest git then started bisecting.  
> > 
> > Hi Florin,
> > 
> > thanks a lot for the testing. Just to verify - what kernel is 'the same 
> > kernel' mentioned above? (just to isolate whether the problem is really 
> > somewhere between 2.6.19 and 2.6.20-rc2, as you stated in previous posts, 
> > or the situation has changed).
> 
> This happened with 2.6.19.  It worked last time, but I wanted to test
> again, to make sure.  This time, it bombed, but half an hour after the 
> transfer finished.
> 
> > > After recompiling, I moved over to the workstation to reboot it, but the 
> > > keyboard was not functioning ;(
> > 
> > So this time the hang occured when the system was idle, not during the 
> > transfers, right?
> 
> Yes it was idle.  Immediately after the transfer finished, the keyboard was
> still functioning.  It "hang" minutes later, after the first bisected kernel
> was compiled and installed.
> 
> > > I ran "lsusb" and it displayed all the devices. "dmesg" did not show
> > > any oops, anything for that matter.  I have unplugged the keyboard and
> > > run "lsusb" again, but it hang.  I ran "ls /mnt" and it hang as well.
> > > Stracing "lsusb" showed it hang (entered the kernel) at opening the device
> > > that used to be the keyboard.  Stracing "ls /mnt" showed that it
> > > hang at "stat(/mnt)".  Both processes were in "D" state.  "ls /root"
> > > worked without problem, so it appears that crossing mountpoints causes
> > > some hang in the kernel.
> > 
> > Could you please do alt-sysrq-t (or "echo t > /proc/sysrq-trigger" via 
> > ssh, when your keyboard is dead) to see the calltraces of the processes 
> > which are stuck inside kernel?
> > 
> > You will probably get a lot of output after the sysrq, so please either 
> > put it somewhere on the web if possible, or just extract the interesting 
> > processes out of it (mainly the ones which are stuck).
> 
> Will do.

It would be nice to learn exactly why the keyboard stopped working.  Try
using the usbmon facility (instructions in Documentation/usb/usbmon.txt)
to see what happens when you type on the dead keyboard.  Be sure to turn
on CONFIG_USB_DEBUG as well.  And also check /proc/interrupts; each time
you hit a key the USB controller should get an interrupt.

Alan Stern

