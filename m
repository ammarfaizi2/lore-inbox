Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUFXEjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUFXEjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 00:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUFXEjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 00:39:54 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64130 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263059AbUFXEjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 00:39:53 -0400
Date: Thu, 24 Jun 2004 00:42:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH][2.6] Fix module_text_address/store_stackinfo race
In-Reply-To: <1088051071.21510.8.camel@bach>
Message-ID: <Pine.LNX.4.58.0406240040330.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406230349390.3273@montezuma.fsmlabs.com>
 <1088051071.21510.8.camel@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Rusty Russell wrote:

> On Wed, 2004-06-23 at 18:02, Zwane Mwaikambo wrote:
> > store_stackinfo() does an unlocked module list walk during normal runtime
> > which opens up a race with the module load/unload code. This can be
> > triggered by simply unloading and loading a module in a loop with
> > CONFIG_DEBUG_PAGEALLOC resulting in store_stackinfo() tripping over bad
> > list pointers.
>
> Hmmm...
>
> 	You can't move kernel_text_address into module.c, since it isn't
> compiled for CONFIG_MODULES=n.

Good point, how about if i make modlist_lock a global?
