Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTIMTKb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTIMTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:10:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54162 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262175AbTIMTK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:10:28 -0400
Date: Sat, 13 Sep 2003 20:10:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Schwab <schwab@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
Message-ID: <20030913191020.GD7404@mail.jlokier.co.uk>
References: <3F621AC4.4070507@cox.net> <je65jx3hdk.fsf@sykes.suse.de> <200309121453.07111.arnd@arndb.de> <3F625A26.7050305@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F625A26.7050305@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> >I had tried that first, but found that there are places that
> >use asm/ioctl.h without including asm/posix_types.h first, so 
> >size_t might not be declared. unsigned int (or unsigned long)
> >is the better alternative here. Does this look ok to everyone?
> 
> After working on this some more this afternoon, I realize now that 
> it's much better to have the typechecking in place than not, even for 
> userspace. Maybe the best solution is to still leave the typechecking 
> (don't wrap it in #ifdef __KERNEL__), and just
> 
> #ifdef size_t
> extern size_t __invalid_size_argument_for_IOC;
> #else
> extern unsigned int __invalid_size_argument_for_IOC;
> #endif

What's wrong with __typeof__(sizeof(0))?

-- Jamie
