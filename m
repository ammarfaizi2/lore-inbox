Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265516AbUFXPYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUFXPYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUFXPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:24:49 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:12419 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265516AbUFXPYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:24:36 -0400
Date: Thu, 24 Jun 2004 11:26:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH][2.6] Fix module_text_address/store_stackinfo race
In-Reply-To: <1088061512.22860.252.camel@bach>
Message-ID: <Pine.LNX.4.58.0406241047080.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406230349390.3273@montezuma.fsmlabs.com> 
 <1088051071.21510.8.camel@bach>  <Pine.LNX.4.58.0406240040330.3273@montezuma.fsmlabs.com>
 <1088061512.22860.252.camel@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Rusty Russell wrote:

> I keep fighting to keep it static 8)
>
> How's this:
>
> Name: Fix race between CONFIG_DEBUG_SLABALLOC and modules
> Status: Compiled on 2.6.7
> Version: -mm
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (modified)
> Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>
>
> store_stackinfo() does an unlocked module list walk during normal runtime
> which opens up a race with the module load/unload code. This can be
> triggered by simply unloading and loading a module in a loop with
> CONFIG_DEBUG_PAGEALLOC resulting in store_stackinfo() tripping over bad
> list pointers.
>
> kernel_text_address doesn't take any locks, because during an OOPS we
> don't want to deadlock.  Rename that to __kernel_text_address, and
> make kernel_text_address take the lock.

Thanks, looks good, works here.

	Zwane

