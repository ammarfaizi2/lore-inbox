Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWFHCZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWFHCZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWFHCZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:25035 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932487AbWFHCZl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:25:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kraxel@suse.de, jamagallon@ono.com
Subject: Re: 2.6.17-rc6-mm1
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
	<20060607154054.cf4f2512.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 08 Jun 2006 04:25:39 +0200
In-Reply-To: <20060607154054.cf4f2512.akpm@osdl.org>
Message-ID: <p73irnctmcc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 8 Jun 2006 00:31:53 +0200
> "J.A. Magallón" <jamagallon@ono.com> wrote:
> 
> > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
> > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
> > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)
> 
> Yes, that's a false positive - doing locking from within an __init section.
> We need to shut that up somehow.

Are you sure it's false? 

I don't see an explicit check in alternatives.c for the main kernel
vs init sections and with CPU hotplug the alternatives can be applied
arbitarily after the system has booted.  So it would just stomp
over the init text pages which are used for something else now.

I guess to make it safe you would need to teach alternative.c to
ignore init sections.

-Andi
