Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVCMCDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVCMCDv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 21:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVCMCDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 21:03:51 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:42439 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261341AbVCMCDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 21:03:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eP2c+oFSXeldpO0gr6uR6MplR9QI4+Hz5sMuhjWEKt9WhusYV06NUM87fUajHlYd9iLYvJzA5g2SuJPAGsN5KvzimrqPqJLt3/2A57SiOL3cH648f8U1s6w0UrDqos0QzCDYIOdAMImbYCdlgrIfc0t6ydoCigAYn3e4x8W9uSE=
Message-ID: <9e47339105031218035f323d68@mail.gmail.com>
Date: Sat, 12 Mar 2005 21:03:39 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110568448.15927.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <1110568448.15927.74.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 19:14:13 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> I posted a proposal for this sometime ago because X has some uses for
> it. The idea being you'd pass a struct that describes
> 
> 1.      What tells you an IRQ occurred on this device
> 2.      How to clear it
> 3.      How to enable/disable it.
> 
> Something like
> 
>         struct {
>                 u8 type;                /* 8, 16, 32  I/O or MMIO */
>                 u8 bar;                 /* PCI bar to use */
>                 u32 offset;             /* Into bar */
>                 u32 mask;               /* Bits to touch/compare */
>                 u32 value;              /* Value to check against/set */
>         }
>

It might useful to add this to the main kernel API, and then over time
modify all of the drivers to use it. If a driver does this it would be
safe to transparently move it to user space like in UML or xen.  I've
been told that PCI Express and MSI does not have this problem.

-- 
Jon Smirl
jonsmirl@gmail.com
