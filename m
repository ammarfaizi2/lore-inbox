Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275253AbTHGJiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275254AbTHGJiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:38:51 -0400
Received: from Mix-Lyon-308-2-184.w80-9.abo.wanadoo.fr ([80.9.175.184]:34176
	"EHLO gaston") by vger.kernel.org with ESMTP id S275253AbTHGJii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:38:38 -0400
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060249101.1077.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 11:38:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 01:52, James Simmons wrote:
> > James, if you are ok, can you get that upstream to Linus asap so
> > I can start pushing the driver bits for radeon & aty128 ?
> 
> Working on it. I'm thinking about also how it effects userland and how 
> userland affects the console if present. Basically the logic will go 
> 
> pci suspend ->  framebuffer driver supend function -> call each client
> 
> Just give me a few days to piece it together.

Right now, we don't have a proper userland notification. So far, the
main affected thing is XFree, but this is ok as it will have received
a suspend request via /dev/apm_bios (which we emulate on PowerMacs),
and so won't touch the framebuffer until resumed.

There isn't much we can do against a userland client tapping the
framebuffer that it mmap'ed previously. I don't know how feasible it
would be to sort of "hack" this process mapping on the fly (would
involve some nasty SMP synchronisation issues) so that the userland
process is just put to sleep on fb access while the fb is suspended
(or get a SEGV). We probably want to extend the notification mecanism
to userland in some way, but this isn't something i cover in this
patch.

Ben.

