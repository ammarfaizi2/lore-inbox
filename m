Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTIMNhi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 09:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTIMNhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 09:37:38 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:38854 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262148AbTIMNhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 09:37:36 -0400
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
From: Pat LaVarre <p.lavarre@ieee.org>
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030913015747.GC4489@waste.org>
References: <1063378664.5059.19.camel@patehci2>
	 <1063390768.2898.15.camel@patehci2> <20030912230637.GB4489@waste.org>
	 <1063414148.2892.26.camel@patehci2>  <20030913015747.GC4489@waste.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063460312.2905.13.camel@patehci2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Sep 2003 07:38:32 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2003 13:37:35.0558 (UTC) FILETIME=[30E59E60:01C379FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What video are you using?
> I'm guessing you've got a framebuffer console?
> VESA by any chance?

I do not yet know how to answer such questions confidently.

I see (redhat-config-xfree86 --> tab Advanced) reports:

Video Card
Video Card Type = Intel 865
Memory Size = 16 megabytes
Driver = i810
Enable Hardware 3D Acceleration = no

> > Yes, thank you, Ctrl+Alt+F$n now works
> > if only I CONFIG_DEBUG_SPINLOCK_SLEEP=n.

Please allow me to disavow that first impression.

With CONFIG_DEBUG_SPINLOCK_SLEEP=y, I've now been counting keystrokes
til crash.  I count each of Ctrl+Alt+F5 and Ctrl+Alt+F7 as one stroke. 
Sometimes I crash, sometimes I do not.  I began logging life more
carefully when first I saw a few strokes cause a crash, and thereafter,
per boot:

8 strokes crashed.

60 strokes did not crash, so I gave up and rebooted to try again.

4 strokes crashed.  The first 2 seeming had logged me out, killing my
cat /proc/kmsg process.

8 strokes crashed.

26 strokes crashed.

...

The only consistency I see is that always an even number of strokes
cause a crash i.e. always the Ctrl+Alt+F7 switch back to my X console,
not the switch to a text console.

To prepare to crash, I only know of: sync umount ext3.  For me as yet
"Checking ... filesystem..." wastes less than three minutes per crash,
and I haven't yet perceptibly lost a disk.

> > I wonder if somehow /proc/kmsg now working is a clue?

Meanwhile, whether `sudo cat /proc/kmsg | tee ...` displays printk
intact or not also varies, without clearly correlating with whether a
crash will or will not occur.

So far, with CONFIG_DEBUG_SPINLOCK_SLEEP=y, trying `sudo cat /proc/kmsg
| tee ...` has never run well enough to capture the cause of the crash.

> >  I could easily check ... ssh ...

Remote ssh freezes and remote ping starts losing all packets.

Pat LaVarre



