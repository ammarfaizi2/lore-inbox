Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273960AbRIRWzF>; Tue, 18 Sep 2001 18:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273961AbRIRWyz>; Tue, 18 Sep 2001 18:54:55 -0400
Received: from ash.lnxi.com ([207.88.130.242]:43001 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S273960AbRIRWyv>;
	Tue, 18 Sep 2001 18:54:51 -0400
To: Ronald G Minnich <rminnich@lanl.gov>
Cc: <linux-kernel@vger.kernel.org>, <linuxbios@lanl.gov>
Subject: Re: LinuxBIOS + ASUS CUA + 2.4.5 works; with 2.4.6 locks up
In-Reply-To: <Pine.LNX.4.33.0109181612380.28482-100000@snaresland.acl.lanl.gov>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 18 Sep 2001 16:54:59 -0600
In-Reply-To: <Pine.LNX.4.33.0109181612380.28482-100000@snaresland.acl.lanl.gov>
Message-ID: <m3u1y0nm7w.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald G Minnich <rminnich@lanl.gov> writes:

> Here is the scenario. We have LinuxBIOS working fine with 2.4.5 on an ASUS
> CUA mainboard (Acer M1631 TNT2 northbridge, m1535d southbridge). It boots
> to multiuser and works fine. All versions of linux from 2.4.0 to 2.4.5
> also work.
> 
> If we upgrade to 2.4.6 we see the 'Posix compliance by Unifix' (or
> whatever) message and then ... that's it. The machine appears to lock up.
> Testing with the ICE shows that it is repeatedly going to address
> 0xfefe0c0, or similar (it varies). Note that is 7 digits of hex, not 8:
> it's not going after high PCI or BIOS memory, we think.
> 
> It does appear to get through creating the kernel_thread for init, and we
> think it might be dying when it goes idle, but we're not sure.

That could happen though it sounds unlikely on a PIII.
 
> We sometimes get into the kernel thread for init and can single step it
> into pci setup. At some point however the machine will again lock up. The
> last POST code is 97.
> 
> THe 0xfefec00 address is suspicious. Is there any APIC (NOT ACPI, I mean
> IO-APIC) change that came into 2.4.6? 

Yes, according to the changlog.  But apics are generally much higher.

> Is there any way the kernel could be
> trying to call the BIOS for some reason (we have APM etc. OFF). Does
> anyone have a hint at what we could look at? FWIW, we have run this kernel
> under linuxbios on other boxes. It only fails on the Acer, and only for
> 2.4.6 and later (we've tested up to 2.4.9).

It shouldn't be trying to call the BIOS.

Have you run memtest86?  Seriously knowing that you don't have
bad memory or a bad memory setup would be rule out all kinds of problems.

Hmm. 0xfefe0c0 is just below 256 megs (I assume that is what you have in your
machine).  The kernel allocates memory from the top down, at least it did last
time I looked.  I can't think of a reason it would jump there, but I
can see it having a variable allocated up there.

On the other hand an address like: 0xc0e0ef0f (reverse endian) is
really wacky but completely inside of the kernel address space.

Eric
