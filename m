Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVCWKSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVCWKSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVCWKSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:18:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:39107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261496AbVCWKS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:18:26 -0500
Date: Wed, 23 Mar 2005 02:17:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4 and 2.6.12-rc1-mm1
Message-Id: <20050323021759.7326fac0.akpm@osdl.org>
In-Reply-To: <200503231042.47249.petkov@uni-muenster.de>
References: <20050316040654.62881834.akpm@osdl.org>
	<200503170942.25833.petkov@uni-muenster.de>
	<20050317011811.69062aa0.akpm@osdl.org>
	<200503231042.47249.petkov@uni-muenster.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <petkov@uni-muenster.de> wrote:
>
> On Thursday 17 March 2005 10:18, Andrew Morton wrote:
> > Borislav Petkov <petkov@uni-muenster.de> wrote:
> > > Mar 17 09:19:28 zmei kernel: [    4.109241] PM: Checking swsusp image.
> > >  Mar 17 09:19:28 zmei kernel: [    4.109244] PM: Resume from disk failed.
> > >  Mar 17 09:19:28 zmei kernel: [    4.112220] VFS: Mounted root (ext2
> > > filesystem) readonly. Mar 17 09:19:28 zmei kernel: [    4.112465] Freeing
> > > unused kernel memory: 188k freed Mar 17 09:19:28 zmei kernel: [   
> > > 4.142002] logips2pp: Detected unknown logitech mouse model 1 Mar 17
> > > 09:19:28 zmei kernel: [    4.274620] input: PS/2 Logitech Mouse on
> > > isa0060/serio1 [EOF]
> > >  <-- and here it stops waiting forever. What actually has to come next is
> > > the init process, i.e. something of the likes of:
> > >  INIT version x.xx loading
> > >  but it doesn't. And by the way, how do you debug this? serial console?
> >
> > Serial console would be useful.  Do sysrq-P and sysrq-T provide any info?
> > -
> <snip>
> 
> Hi Andrew,
> 
> I've tried 2.6.12-rc1-mm1 today and it stops booting at the same point as 
> 2.6.11-mm4. What might help is the info that rc1 boots just fine so it is 
> something in the mm series that impedes the boot process. However, sysrq-P 
> and sysrq-T do not provide anything - sysrq doesn't show any activity at all, 
> i.e. it doesn't even print the usage info message. Infact, the keyboard is 
> dead, it doesn't even turn on or off any lights (NumLock etc).
> 
> Any ideas? (Additional printk's added manually, etc..)
> 

- Make sure that io-apic is enabled, boot with `nmi_watchdog=1'.

- Make sure that CONFIG_DETECT_SOFTLOCKUP is enabled

- Add `initcall_debug' to the boot command line, see if that tells us
  anything.

- Disable CONFIG_DEBUG_PAGEALLOC, if it was enabled

- Send me your .config.

kgdb is the way to diagnose this one.

