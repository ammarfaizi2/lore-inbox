Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbSLaGsP>; Tue, 31 Dec 2002 01:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSLaGsO>; Tue, 31 Dec 2002 01:48:14 -0500
Received: from dp.samba.org ([66.70.73.150]:41090 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267175AbSLaGsM>;
	Tue, 31 Dec 2002 01:48:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Overzealous permenant mark removed 
In-reply-to: Your message of "Mon, 30 Dec 2002 11:40:43 -0000."
             <20021230114043.GD11633@suse.de> 
Date: Tue, 31 Dec 2002 17:55:03 +1100
Message-Id: <20021231065637.7FFC02C09E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021230114043.GD11633@suse.de> you write:
> On Fri, Dec 27, 2002 at 07:44:41PM +1100, Rusty Russell wrote:
> 
>  > Name: Modules without init functions don't need exit functions
>  > D: If modules don't use module_exit(), they cannot be unloaded.  This
>  > D: safety mechanism should not apply for modules which don't use
>  > D: module_init() (implying they have nothing to clean up anyway).
> 
> Just a heads up, as this bit me with agpgart which had a module_init()
> but no module_exit() and then found itself un-unloadable[1].
> I don't know if agpgart found itself in the unique position of doing
> this (It only really used its _init function to clear some vars,
> and printk a banner), but its something to keep an eye out for.

The banner, well, you know Linus' position on printing banners 8)

The rest seems superfluous:

int __init agp_init(void)
{
	static int already_initialised=0;

	if (already_initialised!=0)
		return 0;

	already_initialised = 1;

	memset(&agp_bridge, 0, sizeof(struct agp_bridge_data));
	agp_bridge.type = NOT_SUPPORTED;

	printk(KERN_INFO "Linux agpgart interface v%d.%d (c) Dave Jones\n",
	       AGPGART_VERSION_MAJOR, AGPGART_VERSION_MINOR);
	return 0;
}

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
