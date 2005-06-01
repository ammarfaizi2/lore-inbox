Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVFAJhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFAJhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFAJe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:34:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15492 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261357AbVFAJdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:33:25 -0400
Date: Wed, 1 Jun 2005 11:29:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pm <linux-pm@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: [PATCH] Don't explode on swsusp failure to find swap
Message-ID: <20050601092906.GD6693@elf.ucw.cz>
References: <1117583403.5826.72.camel@gaston> <1117608759.10003.7.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117608759.10003.7.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > More specifically, arch suspend calls swsusp_save().
> > 
> > It fails and returns the error to the arch asm code, which itself 
> > returns it to it's caller swsusp_suspend(), which does that:
> > 
> >         if ((error = swsusp_arch_suspend())) 
> >                 swsusp_free();
> I encounter a similar issue, when swsusp_swap_check failed.
> It seems the swsusp_free isn't required in the failure case,
> suspend_prepare_image has correctly handled the failure case to me.
> Other arch? I wonder why swsusp_free is called after device_power_down
> failed as well. No pages are allocated before device_power_down.

Agreed, its wrong. Also there's no reason for the swap check to be
called (even indirectly) from arch code...
								Pavel
