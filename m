Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbTIMB5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 21:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTIMB5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 21:57:54 -0400
Received: from waste.org ([209.173.204.2]:745 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261983AbTIMB5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 21:57:52 -0400
Date: Fri, 12 Sep 2003 20:57:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
Message-ID: <20030913015747.GC4489@waste.org>
References: <1063378664.5059.19.camel@patehci2> <1063390768.2898.15.camel@patehci2> <20030912230637.GB4489@waste.org> <1063414148.2892.26.camel@patehci2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063414148.2892.26.camel@patehci2>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 06:49:08PM -0600, Pat LaVarre wrote:
> 
> > I'm working on this, it's rather messy. Your lockup might be caused by
> > printk spew during console switch, see if it still locks up with the
> > sleep debugging turned off.
> 
> Yes, thank you, Ctrl+Alt+F$n now works if only I
> CONFIG_DEBUG_SPINLOCK_SLEEP=n.
> 
> Also `sudo cat /proc/kmsg | tee ...` also suddenly starts working.
> 
> I wonder if somehow /proc/kmsg now working is a clue?  Back with =y, my
> `dmesg` was clean but via /proc/kmsg I was seeing garbage like
> 
> mmae t itbl
> 
> or:
> 
> mmae t itle

What video are you using? I'm guessing you've got a framebuffer console?
VESA by any chance?

> for what now again is such reassuring chatter as:
> 
> <6>scsi2 : SCSI emulation for USB Mass Storage devices
> <5>  Vendor: Iomega    Model: RRD               Rev: 23.D
> <5>  Type:   CD-ROM                             ANSI SCSI revision: 02
> <7>WARNING: USB Mass Storage data integrity not assured
> <7>USB Mass Storage device found at 3
> <4>sr1: scsi3-mmc drive: 125x/125x caddy
> <4>sr1: scsi3-mmc maybe not writeable
> <4>sr1: scsi3-mmc writable profile: 0x0002
> <7>Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0
> 
> Pat LaVarre
> 
> P.S. I could easily check to see if =y kills an ssh session or just the
> display, if that helps.

That might help track down a bug in the console, sure. Not sure what's
going on with /proc/kmsg though.
 
> P.P.S.
> 
> Tentatively I conclude "sleep debugging ... off" meant this .config
> change because I see:

Yep, that's the one.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
