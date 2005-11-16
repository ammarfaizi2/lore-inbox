Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVKPSXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVKPSXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVKPSXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:23:02 -0500
Received: from waste.org ([64.81.244.121]:51149 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030387AbVKPSXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:23:01 -0500
Date: Wed, 16 Nov 2005 10:21:46 -0800
From: Matt Mackall <mpm@selenic.com>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
Message-ID: <20051116182145.GP31287@waste.org>
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511160713.07632.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 07:13:07AM -0600, Rob Landley wrote:
> On Friday 11 November 2005 02:35, Matt Mackall wrote:
> > This adds configurable support for doublefault reporting on x86
> ...
> > +config DOUBLEFAULT
> > + depends X86
> > + default y if X86
> > + bool "Enable doublefault exception handler" if EMBEDDED
> > + help
> > +          This option allows trapping of rare doublefault exceptions that
> > +          would otherwise cause a system to silently reboot. Disabling
> > this +          option saves about 4k.
> > +
> 
> What causes doublefaults?  Is it triggerable from userspace, or is it 
> something funky the kernel does?

Double faults happen when a fault occurs while entering a fault
handler.

They're extremely rare in the field. In my experience, they only occur
when you've got hardware troubles or are hacking on the fault handling
code. They're rare enough that I showed one to akpm a few months back
and he claimed he'd never seen one before.

If a fault occurs while trying to invoke the double fault handler
(perhaps because you don't have one), you get a triple fault which
causes a reboot. 

> Trying to figure out when it would be worth using this...

Typical usage for this and similar options is in boxes that have no
useful logging or diagnostic facilities.

-- 
Mathematics is the supreme nostalgia of our time.
