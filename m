Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUENXDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUENXDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUENXDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:03:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:11441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262026AbUENXC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:02:59 -0400
Date: Fri, 14 May 2004 16:05:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2(-mm1,-bk1): SMP bug on dual AMD64
Message-Id: <20040514160524.57dd9de4.akpm@osdl.org>
In-Reply-To: <200405142328.59471.rjwysocki@sisk.pl>
References: <200405142328.59471.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> I've just compiled the 2.6.6-mm2 kernel (with gcc-3.4) and tried to run it.  
> Well, it generally works, but there seems to be an SMP bug that may be 
> triggered with the help of a USB storage device (please see the attached 
> log).  The device works fine in spite of it, though.
> 
> This bug seems to be present in the 2.6.6-mm1 and 2.6.6-bk1, but it is not 
> present in the 2.6.6, apparently.
> 
> My system is a dual Opteron and I use an add-on USB 2.0 card based on the NEC 
> chipset (the .config is attached).

The WARN_ON() backtrace is unrelated to USB - it is due to SCSI calling
vmalloc/vfree with interrupts disabled.  People are working on that.

As for this:

May 14 23:57:09 chimera kernel: usb usb2: string descriptor 0 read error: -108
May 14 23:57:09 chimera last message repeated 2 times

It has been reported before and I assume people are working it, but it
would be nice to have confirmation of that...
