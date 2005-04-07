Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVDGUtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVDGUtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVDGUtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:49:51 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:19628 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262588AbVDGUt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:49:26 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: fix u32 vs. pm_message_t in usb
Date: Thu, 7 Apr 2005 13:49:23 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050405104202.GD1330@openzaurus.ucw.cz> <20050405213832.GJ1380@elf.ucw.cz>
In-Reply-To: <20050405213832.GJ1380@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071349.23531.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 April 2005 2:38 pm, Pavel Machek wrote:
> It seems to me that USB stack still needs some u32-vs-pm_message_t
> changes (in rc2-mm1):
> 
> Could you apply them?

I see someone changed the requirements for platform_device too ... :)

This patch is mostly NOPs, but many of them tromp on other patches I have
in the works.  So I'd rather hold off for now, using the rest of the
2.6.12-rc series for only real honest-to-gosh bugfixes.  (Isn't that
supposed to be the current goal, in any case?)

Something that's not exactly a NOP:

> --- clean-mm/drivers/usb/host/ohci-omap.c	2005-04-05 10:55:21.000000000 +0200
> +++ linux-mm/drivers/usb/host/ohci-omap.c	2005-04-05 12:13:38.000000000 +0200
> @@ -458,9 +458,11 @@
>  
>  /* states match PCI usage, always suspending the root hub except that
>   * 4 ~= D3cold (ACPI D3) with clock off (resume sees reset).
> + *
> + * FIXME: above comment is not right, and code is wrong, too :-(.

The comment is exactly right, and matches the code.  Has done so for
most of a year now, in fact.

What's wrong is the way that the pm_message_t changes have discarded
functionality ... including, as a specific example, the ability for
drivers to do the right thing based on what kind of suspend state
they're entering.  (Because pm_message_t is effectively a boolean,
rather than a something that's multi-valued.)

I'll repeat myself again, at the risk of being redundant:  we need
to actually fix this pm_message_t thing to _work_ rather than paper
over its botches by discarding functionality.

- Dave
