Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUHBTTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUHBTTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUHBTTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:19:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53172 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262279AbUHBTTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:19:53 -0400
Subject: Re: DRM code reorganization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
In-Reply-To: <20040802185746.GA12724@redhat.com>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
	 <410E81C3.2070804@us.ibm.com>  <20040802185746.GA12724@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091470615.857.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 19:16:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 19:57, Dave Jones wrote:
>  > The problem is that each driver has different needs based on hardware 
>  > functionality.
> 
> How does this differ from any other subsystem that supports
> cards with features that may not be present in another model ?
> Other subsystems have dealt with this problem without the need
> to introduce horrors like the abstractions in DRM.

The abstractions are one big mistake IMHO. But in context their origin
is easy to understand. The original goal was to support a lot of
platforms and to minimise code writing. The Mesa layer uses this kind of
templating a lot and for the 3D client side code its a real win.

Someone I think took them a stage too far and into a place that it
didn't work out.

The memory manager is a bit more complex, a lot of drivers do have
different needs for memory management and some of it has to be client
side. Its also a really really hot path when doing direct render.

>  > AFAIK, the only drivers that have any sort of in-kernel memory manager 
>  > are the radeon (only used by the R200 driver) and i830.
> 
> ISTR SiS has some memory management code too, though I've not looked
> too closely at that for a long time.

SiS and VIA do as well. Both of them overdo the kernel side work and it
hurts performance however.

Alan

