Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTEOCZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTEOCZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:25:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263737AbTEOCZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:25:58 -0400
Date: Wed, 14 May 2003 19:39:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <20030514193300.58645206.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Andrew Morton wrote:

> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > Hi again, Andrew,
> > 
> > Besides the "make_KOBJ_NAME-match_BUS_ID_SIZE.patch" causing "pccard"
> > oopses, I've also found that, with 2.5.69-mm5 compiled with ACPI
> > support, my laptop is unable to power off. The kernel invokes
> > "acpi_power_off" and stays there forever.
> > 
> > I've found that reverting the "i8259-shutdown.patch" fixes the problem
> > and my laptop is able to shutdown properly (init 0) when using ACPI.
> > 
> > A hardware bug? A kernel bug?
> 
> And thanks again, again.
> 
> That's the below patch.  It looks pretty innocuous.  I'd be assuming that
> there's something in the shutdown sequence which needs 8259 functionality
> after the thing has been turned off.
> 
> This could well depend upon .config contents and linkage order.
> 
> Eric, maybe we need to turn it off by hand at the right time rather than
> relying on driver model shutdown ordering?

Interesting. This is yet more proof that system-level devices cannot be
treated as common, everyday devices. Sure, it's nice to see them show up
in sysfs with little overhead, and very nice not to have to work about
them during shutdown or power transitions. But there are just too many
special cases (like getting the ordering right ;) that you have to worry
about.

So, what do we do with them? 


	-pat

