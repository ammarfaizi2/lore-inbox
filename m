Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUG3DpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUG3DpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUG3DpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:45:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:23944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267563AbUG3Do2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:44:28 -0400
Date: Thu, 29 Jul 2004 20:36:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Message-Id: <20040729203603.1023ed38.rddunlap@osdl.org>
In-Reply-To: <200407292147.21463.gene.heskett@verizon.net>
References: <200407242156.40726.gene.heskett@verizon.net>
	<200407291822.47209.gene.heskett@verizon.net>
	<20040729151415.094c8d01.rddunlap@osdl.org>
	<200407292147.21463.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 21:47:21 -0400 Gene Heskett wrote:

| On Thursday 29 July 2004 18:14, Randy.Dunlap wrote:
| [...]
| I've gone clear back to a 2.6.7 kernel because thats the newest one 
| that has a diff when cmp'ing fs/dcache.c files to whats in 2.6.8-rc2.
| 
| I've had one Oops, virtually the same one, but it didn't kill the 
| machine like it would have if I was running 2.6.8-rc2.

Yeah, oopsen often don't kill the entire machine.

| >make fs/dcache.s
| 
| Aha!  Voila!! It doesn't work in the "fs" subdir, but back out to the 
| top of the src tree and it works just fine.  Duh...

Right, it needs the top-level makfile and kbuild machinery to do that.

| Now, I must confess that what I'm looking at in those two files is 
| the .s is the source assembly that would normally be fed to gas, and 
| the objdump'ed version is the dissed object translated back to gas 
| source.  If no mistakes, they should be pretty close to the same I'd 
| think.  Am I on the right track?  Or full of it?

Yes, right.

| Here's the theory thats gradually formed in whats left of my mind:
| --------------
| 5 things changed in the kernel soft when I changed the mobo.
| 1. The ide driver, from via686a to the nforce2 version.
| 2. The video driver, because the old card failed and took the mobo 
| with it.
| 3. Ethernet driver is now forcedeth instead of rtl-8139too
| 4. A different alsa driver, from via8233 to intel-8x0
| 5. The 4Gb switch is turned on in the kernel now as theres a gig of 
| ram on this board.
| --------------

You can easily use a non-high-memory enabled kernel.  It will still
use 896 MB of RAM (IIRC).  Enabling highmem gets you another 128 MB.

IDE and video are somewhat important, no?
But the ethernet and ALSA drivers should be optional, at least for some
testing... Ha, you said that below!

| I can't do anything about the first 2, but I can do without the last 
| 200 megs of ram long enough to test that, and I can switch back to 
| the rtl-8139too card for ethernet, and I can turn off alsasound.
| 
| In the meantime I turned a bunch of stuff the logs were complaining 
| about off, like sgi_fam (what the heck is that?), some ups daemons 

FAM is File Alteration Monitor, from SGI:
  http://oss.sgi.com/projects/fam/

| for brands I don't have, that sort of thing, and have a tail running 
| on the log.  So far, its clean since the restart of xinetd.  Another 
| 16 hours will tell most of the tale for this particular instant 
| configuration.
| 
| One final question if I may:  What do I turn off (or on) in the video 
| dept of the kernel so that my screen doesn't go black after vmlinuz 
| is unpacked, and not come back on till "init" is run, at which point 
| the screen comes back on in what looks to be exactly the same mode?

Hm, do you have a serial console enabled (in the kernel config and in your
kernel command line)?  If not, please send your .config file (your probably
did, but I'm lost in the maze of emails).

| Anything that goes on in that time period must be read 
| from /var/log/dmesg later if I want to see it.

--
~Randy
