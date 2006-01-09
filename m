Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWAIBnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWAIBnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 20:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWAIBnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 20:43:17 -0500
Received: from xenotime.net ([66.160.160.81]:24479 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751500AbWAIBnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 20:43:16 -0500
Date: Sun, 8 Jan 2006 17:43:14 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: vherva@vianova.fi, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-Id: <20060108174314.49f0e2b3.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0601082034150.15902@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com>
	<Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
	<20060105103339.GG20809@redhat.com>
	<20060108133822.GD31624@vianova.fi>
	<20060108055322.18d4236e.rdunlap@xenotime.net>
	<Pine.LNX.4.61.0601082034150.15902@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 20:35:08 +0100 (MET) Jan Engelhardt wrote:

> >> I believe kmsgdump (http://www.xenotime.net/linux/kmsgdump/) uses its own
> >> minimal 16-bit floppy driver to save the oops dump. 
> >
> >It just switches to real mode and uses BIOS calls.
> >
> 
> This technique btw is what I suggested (switch to 80x50 vga mode
> (if not in X)) in case of a longer oops trace.

kmsgdump already shows all of the kernel log buffer that is in
memory (has not been written to disk, basically).

If I (or we) had some time and motivation, I have a
contributed patch to kmsgdump that:

a.  saves and dumps all of the kernel log buffer
    (reminder:  current dump targets are display, parallel port
    printer, and legacy floppy disk)
b.  adds a hard disk dump target and attempts to make this safe
    by pre-reserving and writing each block of it with a
    signature + block number (and maybe more, I'm not sure
    right now)
c.  add x86-64 support

but I have not merged this code into kmsgdump yet, nor have
I even tested it.  I can't test the x86-64 support since I
don't (yet) have an x86-64 system available for this.

If anyone wants to work on this, I'll put the additional
code on the web.

---
~Randy
