Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVDARVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVDARVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVDARVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:21:05 -0500
Received: from ida.rowland.org ([192.131.102.52]:13828 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262814AbVDARUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:20:45 -0500
Date: Fri, 1 Apr 2005 12:20:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: kus Kusche Klaus <kus@keba.com>
cc: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.11, USB: High latency?
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231D4@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44L0.0504011207290.1747-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005, kus Kusche Klaus wrote:

> > The biggest advantage would come from using a bottom-half 
> > handler to do 
> > most of the work.  Right now the uhci-hcd driver does 
> > everything in its 
> > interrupt handler.  This would certainly help IRQ latency; it 
> > might not 
> > affect application latency very much.
> 
> Sounds very reasonable, thanks. Also helps application latency,
> because with the RT patches, I can tune the rt prio of softirq
> execution (that's where bottom-half goes, doesn't it?) w.r.t. the
> rt prio of the application threads.

Yes.  Bear in mind, however, that if these application threads are doing 
I/O over USB then they will be forced to wait for the bottom half to 
execute, regardless of its priority.

> However, if I understand things correctly, if you really need 
> to disable all interrupts while doing the USB work, it will not
> make any difference if IRQs are disabled while you are in the
> USB IRQ handler, or if they are disabled for the same amount of 
> work/time in the bottom-half code.

For most of the USB work it will be necessary only to insure that no more
than one copy of the bottom-half handler is running at a time, which I 
think the kernel does automatically for tasklets.  There are a few places 
where all IRQs will have to be disabled, but those places are relatively 
small and short.

Right now, of course, everything runs with IRQs disabled.

> > We'll see what happens with the upcoming changes.  Maybe 
> > you'll be able to 
> > test them for me?
> 
> Basically, yes (as long as our company doesn't decide to stop the
> linux experiments).
> 
> However, I depend on Ingo's RT patch, which is against the -rc series,
> not against the -mm series. So I will probably not be able to apply
> patches created against -mm.

Okay.  It will be a while before the new code is ready and the changes on 
which it depends have gotten into -rc.

Alan Stern

