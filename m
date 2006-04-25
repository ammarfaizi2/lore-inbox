Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWDYBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDYBzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWDYBzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:55:11 -0400
Received: from fmr20.intel.com ([134.134.136.19]:59012 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751248AbWDYBzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:55:09 -0400
Subject: Re: 2.6.17-rc1: kernel only boots one CPU on HT system
From: Shaohua Li <shaohua.li@intel.com>
To: Kevin Baradon <kevin.baradon@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200604241926.25239.Kevin.Baradon@gmail.com>
References: <200604231434.59966.Kevin.Baradon@gmail.com>
	 <20060423141519.314ae567.akpm@osdl.org>
	 <1145843859.19994.63.camel@sli10-desk.sh.intel.com>
	 <200604241926.25239.Kevin.Baradon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Apr 2006 09:53:48 +0800
Message-Id: <1145930028.19994.68.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 19:26 +0200, Kevin Baradon wrote:
> Le Lundi 24 Avril 2006 03:57, Shaohua Li a écrit :
> > Hi,
> 
> Hello, 
> >
> > On Sun, 2006-04-23 at 14:15 -0700, Andrew Morton wrote:
> > > Kevin Baradon <kevin.baradon@gmail.com> wrote:
> > > > Hello,
> > > >
> > > > Starting with kernel 2.6.17-rc1 (also happens with 2.6.17-rc2), second
> > > > logical-CPU of my Hyperthreading system no longer boots.
> > > >
> > > > I tracked up changes in APIC code, and it appears reverting commit
> > > > 7c5c1e427b5e83807fd05419d1cf6991b9d87247 fixes this bug.
> > >
> > > That helps heaps, thanks.
> >
> > The commit doesn't look like the root cause to me. BIOS already assigns
> > unique id to ioapic, and the cpu family is 15, so with/without the patch
> > the code path hasn't any difference. Kevin, can you please make a clean
> > build and check if the patch is the real cause?
> >
> 
> You were right. Reverting this commit helps sometimes, but doesn't work 
> reliably. When my computer booted this morning, I've had only one CPU 
> detected. I've tried booting several times, even with a complete power down. 
> Nothing changed. 
> 
> I've also tried with kernel 2.6.16-rc6, which booted fine and detected two 
> CPUs.
> 
> I've applied your small patch. Debugging output is attached.
> 
> If you want, I can apply this small patch also to kernel 2.6.16-rc6, and send 
> you debugging output.
> 
> > If it still doesn't work, you might apply a small change below to
> > include/asm-i386/apic.h, and attach the dmesg, so we could analyze it.
> >
> 
> File attached.
The CPU doesn't startup. Sometime ago somebody reported a similar issue
for 2.6.16.1. But the failure isn't reliably triggered. IIRC, there
isn't a solution.

Thanks,
Shaohua

