Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbULIDvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbULIDvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 22:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULIDvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 22:51:16 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:55238 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261442AbULIDvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 22:51:13 -0500
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
	and xfs
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@osdl.org>
Cc: David Greaves <david@dgreaves.com>, phil@dier.us,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041208011546.2d509d1b.akpm@osdl.org>
References: <20041122130622.27edf3e6.phil@dier.us>
	 <20041122161725.21adb932.akpm@osdl.org>
	 <20041124094549.4c51d6d5.phil@dier.us>
	 <20041124151234.714f30d4.akpm@osdl.org> <41A9B693.30905@dgreaves.com>
	 <20041128102751.2dac71f7.akpm@osdl.org> <41B6C34B.7030700@dgreaves.com>
	 <20041208011546.2d509d1b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1102540749.4209.8.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 09 Dec 2004 14:50:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

On Wed, 2004-12-08 at 20:15, Andrew Morton wrote:
> David Greaves <david@dgreaves.com> wrote:
> >
> > I did as you suggested and it's been fine until I got this last night.
> > 
> >  Dec  8 06:50:04 cu kernel: slab: Internal list corruption detected in 
> >  cache 'vm_area_struct'(41), slabp cfedd000(13).
> 
> That's totally different from the previous oops (it was in dcache).
> 
> I'd be suspecting either a random memory scribble or flakey hardware.  It
> could well be the latter if you're not using any unusual
> drivers/filesystems/etc.

I'm seeing similar things occasionally with 2.6.9+kgdb+suspend2+Win4Lin
on ht/preempt/regparm/4gb highmem. I've come to the conclusion it's
probably not directly suspend (I can do 100 cycles on the trot), but
haven't been able to reliably reproduce it. The corruption is always in
fs related data, but apart from that seems random. Seeing the mention of
being unable to allocate a page at the bottom of David's email makes me
wonder if the difficulties with memory freeing are triggering some code
that's not properly handling failed page allocations.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

