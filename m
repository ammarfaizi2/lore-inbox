Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbTIMOv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 10:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTIMOv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 10:51:27 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:11782 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261174AbTIMOvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 10:51:24 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Pat LaVarre <p.lavarre@ieee.org>, mpm@selenic.com
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
Date: Sat, 13 Sep 2003 22:49:39 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <1063378664.5059.19.camel@patehci2> <20030913015747.GC4489@waste.org> <1063460312.2905.13.camel@patehci2>
In-Reply-To: <1063460312.2905.13.camel@patehci2>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309132249.40283.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't think this is a keyboard problem and have seen
this several times related to video drivers in particular
when switching back to X.

The script below switches every $wait (5) seconds between
VT $vt (1) and X @vt$x (7). It logs to $log (log=/tmp/_vt)
syncs and waits before doing the switch to allow data to
reach the disk. So if it dies, you should know quite 
accurately when and where and if it also happens wo KB. 

Put this into a file and make it executable. It must
be run as root unless chvt is in sudoers or suid root. 

#!/bin/bash

cycle=1
log=/tmp/_vt.log
vt=1
x=7
wait=5
#rm -f $log
echo Starting VT <> X test
while ((1)); do
  echo Cycle $cycle switching to VT $vt >> $log    
  sync
  sleep $wait
  chvt $vt
  echo Cycle $cycle switching to X >> $log    
  sync
  sleep $wait
  chvt $x
  echo Cycle $cycle
  ((cycle += 1))
done
;;


On Saturday 13 September 2003 21:38, Pat LaVarre wrote:
> 
> > What video are you using?
> > I'm guessing you've got a framebuffer console?
> > VESA by any chance?
> 
> I do not yet know how to answer such questions confidently.
> 
> I see (redhat-config-xfree86 --> tab Advanced) reports:
> 
> Video Card
> Video Card Type = Intel 865
> Memory Size = 16 megabytes
> Driver = i810
> Enable Hardware 3D Acceleration = no
> 
> > > Yes, thank you, Ctrl+Alt+F$n now works
> > > if only I CONFIG_DEBUG_SPINLOCK_SLEEP=n.
> 
> Please allow me to disavow that first impression.
> 
> With CONFIG_DEBUG_SPINLOCK_SLEEP=y, I've now been counting keystrokes
> til crash.  I count each of Ctrl+Alt+F5 and Ctrl+Alt+F7 as one stroke. 
> Sometimes I crash, sometimes I do not.  I began logging life more
> carefully when first I saw a few strokes cause a crash, and thereafter,
> per boot:
> 
> 8 strokes crashed.
> 
> 60 strokes did not crash, so I gave up and rebooted to try again.
> 
> 4 strokes crashed.  The first 2 seeming had logged me out, killing my
> cat /proc/kmsg process.
> 
> 8 strokes crashed.
> 
> 26 strokes crashed.
> 
> ...
> 
> The only consistency I see is that always an even number of strokes
> cause a crash i.e. always the Ctrl+Alt+F7 switch back to my X console,
> not the switch to a text console.
> 
> To prepare to crash, I only know of: sync umount ext3.  For me as yet
> "Checking ... filesystem..." wastes less than three minutes per crash,
> and I haven't yet perceptibly lost a disk.
> 
> > > I wonder if somehow /proc/kmsg now working is a clue?
> 
> Meanwhile, whether `sudo cat /proc/kmsg | tee ...` displays printk
> intact or not also varies, without clearly correlating with whether a
> crash will or will not occur.
> 
> So far, with CONFIG_DEBUG_SPINLOCK_SLEEP=y, trying `sudo cat /proc/kmsg
> | tee ...` has never run well enough to capture the cause of the crash.
> 
> > >  I could easily check ... ssh ...
> 
> Remote ssh freezes and remote ping starts losing all packets.
> 
> Pat LaVarre
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


