Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUHVNDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUHVNDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHVNDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:03:45 -0400
Received: from the-village.bc.nu ([81.2.110.252]:50062 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266838AbUHVNDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:03:38 -0400
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, eich@suse.de
In-Reply-To: <m3n00nwepr.fsf@averell.firstfloor.org>
References: <2vEzI-Vw-17@gated-at.bofh.it>
	 <m3n00nwepr.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093176046.24272.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 13:00:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 13:16, Andi Kleen wrote:
> At least older XFree86 (4.2/3 time frame) used to only use iopl(). I
> know it because at some point ioperm() was completely broken on
> x86-64, but the X server never hit it. I wonder why they changed
> that. Anyways, perhaps it would be better to just change the X server
> back to use iopl(), because it will be always faster than using

Xorg and XFree assume the kernel will have intelligent limits. When the
range went up the EnableIO code in turn switched to ioperm.

The actual code is:

       if (ioperm(0, 1024, 1) || iopl(3))
                FatalError("xf86EnableIOPorts: Failed to set IOPL for
I/O\n")

(os-support/linux/lnx_video.c:xf86EnableIO)

Flip those around and rebuild.


