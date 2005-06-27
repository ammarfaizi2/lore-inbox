Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVF0EXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVF0EXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVF0EXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:23:54 -0400
Received: from unused.mind.net ([69.9.134.98]:6340 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261801AbVF0EXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:23:39 -0400
Date: Sun, 26 Jun 2005 21:21:45 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050625041453.GC6981@elte.hu>
Message-ID: <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org>
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
 <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org>
 <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org>
 <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org>
 <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu>
 <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2005, Ingo Molnar wrote:

> > > do you have the NMI watchdog enabled? Find below 
> > > serial-logging-earlyprintk-nmi.txt.
> > 
> > I had a serial console up, but not NMI watchdog until now.  Here's 
> > some NMI watchdog traces from both -50-17 and -50-18:
> 
> all of these traces seem to have lockupcli involved - is that correct?  
> lockupcli is just a userspace test-app to artificially trigger a 
> hard-lockup (it disables interrupts and goes into an infinite loop). So 
> the NMI watchdog triggering on lockupcli would be normal and expected.  
> So once this works, it would be nice to reproduce whatever hard lockup 
> you are seeing and see whether the NMI watchdog produces any output to 
> the serial log. (if such log is supposed to be included in your dmesg 
> then it somehow got intermixed with lockupcli logs)

I still haven't been able to get any NMI watchdog traces with the lockups
induced by VLC and burnP6.  Early printk is enabled on the serial console.
I have noticed, however, that scheduling performance slowly degrades 
during the ~1 minute before locking up.  Once I was able to get a delayed 
SysRq response (~30s) from the serial console after the X console became 
unresponsive.  Is this possibly a scheduler starvation issue that affects 
everything, including the NMI watchdog?  Any more suggestions for catching 
a trace?

--ww
