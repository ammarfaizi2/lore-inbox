Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWEOV1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWEOV1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWEOV1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:27:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:29751 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965262AbWEOV1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:27:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=StMGFPpUHYcODCoCoOTy0ylTisQ4limhEUdp6l+KYVMH9wJEOzIi/ECAVlQKM1oZbwEWuBqcCabYBn0AZ0mgbXPXwOluE3P5VOvsTAatEnnzNEUUiXu+UxhSm3p7Oqz6HlE7vrXrkLpFRMfShrLO5vViLQYebh35VJofy5vMu2E=
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: 2.6.17-rc1: kernel only boots one CPU on HT system
Date: Mon, 15 May 2006 23:26:56 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200604231434.59966.Kevin.Baradon@gmail.com> <200604241926.25239.Kevin.Baradon@gmail.com> <1145930028.19994.68.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1145930028.19994.68.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605152326.56674.Kevin.Baradon@gmail.com>
From: Kevin Baradon <kevin.baradon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 25 Avril 2006 03:53, Shaohua Li a écrit :
> On Mon, 2006-04-24 at 19:26 +0200, Kevin Baradon wrote:
> > Le Lundi 24 Avril 2006 03:57, Shaohua Li a écrit :
> > > Hi,
> >
> > Hello,
> >
> > > On Sun, 2006-04-23 at 14:15 -0700, Andrew Morton wrote:
> > > > Kevin Baradon <kevin.baradon@gmail.com> wrote:
> > > > > Hello,
> > > > >
> > > > > Starting with kernel 2.6.17-rc1 (also happens with 2.6.17-rc2),
> > > > > second logical-CPU of my Hyperthreading system no longer boots.
> > > > >
> > > > > I tracked up changes in APIC code, and it appears reverting commit
> > > > > 7c5c1e427b5e83807fd05419d1cf6991b9d87247 fixes this bug.
> > > >
> > > > That helps heaps, thanks.
> > >
> > > The commit doesn't look like the root cause to me. BIOS already assigns
> > > unique id to ioapic, and the cpu family is 15, so with/without the
> > > patch the code path hasn't any difference. Kevin, can you please make a
> > > clean build and check if the patch is the real cause?
> >
> > You were right. Reverting this commit helps sometimes, but doesn't work
> > reliably. When my computer booted this morning, I've had only one CPU
> > detected. I've tried booting several times, even with a complete power
> > down. Nothing changed.
> >
> > I've also tried with kernel 2.6.16-rc6, which booted fine and detected
> > two CPUs.
> >
> > I've applied your small patch. Debugging output is attached.
> >
> > If you want, I can apply this small patch also to kernel 2.6.16-rc6, and
> > send you debugging output.
> >
> > > If it still doesn't work, you might apply a small change below to
> > > include/asm-i386/apic.h, and attach the dmesg, so we could analyze it.
> >
> > File attached.
>
> The CPU doesn't startup. Sometime ago somebody reported a similar issue
> for 2.6.16.1. But the failure isn't reliably triggered. IIRC, there
> isn't a solution.

Hello,

I've found a workaround to this bug. 
Problem has already been reported in 
http://bugzilla.kernel.org/show_bug.cgi?id=5757.
Workaround described (disabling USB legacy emulation in BIOS) works reliably. 

>
> Thanks,
> Shaohua

-- 
Kevin Baradon
Telecom Student
-
