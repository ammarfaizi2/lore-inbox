Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSL3Ldq>; Mon, 30 Dec 2002 06:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSL3Ldq>; Mon, 30 Dec 2002 06:33:46 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:196 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266926AbSL3Ldo>;
	Mon, 30 Dec 2002 06:33:44 -0500
Date: Mon, 30 Dec 2002 11:40:43 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Overzealous permenant mark removed
Message-ID: <20021230114043.GD11633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021227084936.1DCBD2C10B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021227084936.1DCBD2C10B@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 07:44:41PM +1100, Rusty Russell wrote:

 > Name: Modules without init functions don't need exit functions
 > D: If modules don't use module_exit(), they cannot be unloaded.  This
 > D: safety mechanism should not apply for modules which don't use
 > D: module_init() (implying they have nothing to clean up anyway).

Just a heads up, as this bit me with agpgart which had a module_init()
but no module_exit() and then found itself un-unloadable[1].
I don't know if agpgart found itself in the unique position of doing
this (It only really used its _init function to clear some vars,
and printk a banner), but its something to keep an eye out for.

I fixed it by adding a null _exit function, (which later did a
sanity check just for good measure).

		Dave

[1] Coo, a new silly word.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
