Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUFXEZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUFXEZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 00:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUFXEZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 00:25:12 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:6032 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261752AbUFXEZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 00:25:08 -0400
Subject: Re: [PATCH][2.6] Fix module_text_address/store_stackinfo race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <Pine.LNX.4.58.0406230349390.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406230349390.3273@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1088051071.21510.8.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 14:24:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 18:02, Zwane Mwaikambo wrote:
> store_stackinfo() does an unlocked module list walk during normal runtime
> which opens up a race with the module load/unload code. This can be
> triggered by simply unloading and loading a module in a loop with
> CONFIG_DEBUG_PAGEALLOC resulting in store_stackinfo() tripping over bad
> list pointers.

Hmmm...

	You can't move kernel_text_address into module.c, since it isn't
compiled for CONFIG_MODULES=n.

I don't really like debug code messing with this, but you might be right
about changing it to __kernel_text_address().

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

