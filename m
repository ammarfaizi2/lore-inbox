Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUEXUel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUEXUel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbUEXUek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:34:40 -0400
Received: from mibi03.meb.uni-bonn.de ([131.220.21.4]:60935 "EHLO
	mibi03.meb.uni-bonn.de") by vger.kernel.org with ESMTP
	id S264685AbUEXUe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:34:27 -0400
Subject: Re: PROBLEM: Linux-2.6.6 with dm-crypt hangs on SMP boxes
From: "Dr. Ernst Molitor" <molitor@uni-bonn.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
       Christophe Saout <christophe@saout.de>, molitor@uni-bonn.de, em@cfce.de
In-Reply-To: <20040521185640.6bf88bdb.akpm@osdl.org>
References: <1085043539.18199.20.camel@felicia>
	 <20040521185640.6bf88bdb.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1085430830.7365.24.camel@felicia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6.2 
Date: Mon, 24 May 2004 22:33:51 +0200
X-scanner: scanned by Inflex 2.0.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew Morton, 

On Fri, 2004-05-21 at 18:56 -0700, Andrew Morton wrote:
> "Dr. Ernst Molitor" <molitor@cfce.de> wrote:
> >
> > [1.] Linux-2.6.6 caused full halts on two SMP boxes.
> > [2.] I've been using Linux-2.4.20 with   cryptoloop/cryptoapi for 156
> > days uptime; on two boxes, I have installed 2.6.6-rc3-bk5 (one box) and
> > 2.6.6-bk5 (the other one), with dm-crypt on the partitions created with
> > cryptoloop/cryptoapi. Both boxes ran like a charm, but both of them
> > repeatedly came to a halt (no screen, no network connectivity, no
> > reaction to keyboard or mouse activity: Need for hard reset) repeatedly.
> > [3.] dm-crypt, loop device (maybe other things).
> > In kern.log on the box with 2.6.6-bk5, I found the line
> >   Incorrect TSC synchronization on an SMP system (see dmesg).
> > with the 2.6.6 kernels, with 2.4.20, the message was
> >  checking TSC synchronization across CPUs: passed.
> > [4.] 2.6.6, 2.6.6-bk5
> 
> Are the machines using highmem? (What is in /proc/meminfo?)
> 
> Please add `nmi_watchdog=1' to the kernel boot command line and reboot.

thank you for your hint, I followed it meticulously, and yes, the line
starting with "NMI:" in /proc/interrupts showed increasing counts.
> 
> After booting, do:
> 
> 	echo 1 > /proc/sys/kernel/sysrq
> 
> After a machine hangs up, see if there is an NMI watchdog message on the
> console.  If not, try typing ALT-sysrq-P.  If this generates a trace, type
> it again until you capture the trace from the other CPU as well.  We'd need
> to see both those traces.  A digital camera helps...

I'm very sorry, I have non seen any watchdog messages;  ALT-sysrq-P
worked before a problem occurred, only, -  it failed to work once the
box hanged up. I had to switch off DPMI power off in the BIOS just to be
sure about this, since once the box freezes, it just does not react on
any action other than a hard reset or power off cycle.

I had the box compile gcc-3.4.0 several times to keep it busy - it took
between 2 and about 30 minutes to hang up under this task. Hanging up
did not depend on dm-crypt - it came about even when dm-crypt was not
used at all. 

By chance, I happened to read a message by Jeronimo Wanhoff on the
mailing list of the BoLUG (LUG of Bonn, Germany); he noted that his
nvidia nforce2 board hanged with local APIC support in use, and
suggested to use nolapic as a boot parameter to disable local APIC use
since this cause his box to stop hanging up.

Following his advice, I rebooted with the "nolapic" boot option; the box
has been up and running 2.6.6-bk8 for 6 hours now, and I did try and put
some load on it (recompilation of gcc-3.4.0 on an encrypted file system,
using dm-crypt/twofish). 

Please drop me a line of e-mail if I can be of any assistance in
pinpointing the problem. Could it be a hardware failure with the local
APIC which does not matter under 2.4.x?   I'd report back if the system
-  which seems to be stable now - should falter again.

Thank you very much for your patience and help.

Best wishes and regards, 

Ernst
