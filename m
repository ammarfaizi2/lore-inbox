Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJBScK>; Tue, 2 Oct 2001 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276124AbRJBScA>; Tue, 2 Oct 2001 14:32:00 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:38142 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S276118AbRJBSbu>; Tue, 2 Oct 2001 14:31:50 -0400
Date: Tue, 2 Oct 2001 14:32:08 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Huge console switching lags
In-Reply-To: <E15oUD9-0005Ua-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0110021423140.22872-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, Alan Cox wrote:
>A console switch has to wait until queued I/O to that console is complete,

Ok, so fix that. (assuming that's not "waiting on the hardware" queued IO)

>Also a console switch on a frame buffer with no hardware banking can take
>a lot of time.

Oh, *grin*, forgot about those evil framebuffer consoles. (never use them
myself, they really are freakin' slow.)  Arguablly, all access to fbdev's
should be from a process context (it's like having X in the kernel.)

In that case, keventd needs to be a high priority real-time task.  If it
takes SECONDS to change consoles, I'm very likely to assume the machine is
locked and push the reset button (and I'm sure many others will do the same.)

--Ricky


