Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280186AbRKIVqR>; Fri, 9 Nov 2001 16:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRKIVqI>; Fri, 9 Nov 2001 16:46:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:22545 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280186AbRKIVpy>;
	Fri, 9 Nov 2001 16:45:54 -0500
Subject: Re: [PATCH] Adding KERN_INFO to some printks #2
From: Robert Love <rml@tech9.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01110923204702.00807@nemo>
In-Reply-To: <01110913474600.02130@nemo> <1005321383.1209.8.camel@phantasy> 
	<01110923204702.00807@nemo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 09 Nov 2001 16:45:48 -0500
Message-Id: <1005342348.808.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-09 at 18:20, vda wrote:
> Well... thanks man.
> I hope patch will be noticed by our tribal leaders :-)
> (Linus? Alan?)

Alan is really busy stuffing patches off to Linus, and thus he is more
concerned with getting Linus's 2.4.15 up to sync with him right now. 
Linus is probably busy with that, too.  If you don't see this in a Linus
-pre, 2.5.0 is also right around the tree.

I think the most important thing you are doing is adding loglevel values
to printk statements that have none -- that is important not just to
clarify and make sure the value is right, but because the default
loglevel can and will change (it has before).

I went over the patch and found a few things...

printk(KERN_INFO "No local APIC present or hardware disabled\n");

 I'd make this a KERN_WARNING.  Consider the case where I compile my own
kernel and I add APIC support.  If the driver is failing to find my APIC
then either (a) my BIOS is broken or (b) I should remove the driver. 
Either way I would want to know.

printk (KERN_WARNING "mtrr: your CPUs had inconsistent fixed MTRR 
printk (KERN_WARNING "mtrr: your CPUs had inconsistent variable MTRR
printk (KERN_WARNING "mtrr: your CPUs had inconsistent MTRRdefType
printk (KERN_WARNING "mtrr: probably your BIOS does not setup all 

 These can actually be KERN_INFO, because it is not a problem and the
mtrr driver fixes the issue.

There are a _lot_ of printk statements in your patch where you didn't
add a loglevel.  You modified them for some reason (in many cases to
change printk("%s" ...) to printk(pf: ...).  You can easily find them
via a search on `printk("' ... that same search can be a grep to find
on-specified printks in the whole tree, too :)

Good work.

	Robert Love

