Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUCPVYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUCPVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:22:17 -0500
Received: from ozlabs.org ([203.10.76.45]:26321 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261711AbUCPVUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:20:14 -0500
Subject: Re: module scanning in kgdb 2.x
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <200403121206.16130.amitkale@emsyssoft.com>
References: <200403121206.16130.amitkale@emsyssoft.com>
Content-Type: text/plain
Message-Id: <1079471931.19722.15.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 08:18:52 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 17:36, Amit S. Kale wrote:
> Hi,

Hi Amit,

	FYI: you would have received a quicker response if you'd CC'd me.

> It does following things:
> 1. Adds MODULE_STATE_GONE to indicate that a module was removed. This is 
> differnent from MODULE_STATE_GOING. gdb needs to be notified of a module 
> event _after_ a module has been removed. Or else it'll still find the module 
> during a module list scan and will not remove it from its core.

Makes sense.

> 2. Defines a structure mod_section which stores module section names and 
> offsets preserved during loading of a module.
> 
> 3. Adds a couple of fields to struct module to keep module section 
> information.

Why not just set the section strings to SHF_ALLOC rather than copying
(and possibly truncating) the names into your struct mod_section? 
struct mod_section is then simply void *addr; char *name;

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

