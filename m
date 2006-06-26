Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWFZPxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWFZPxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWFZPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:52:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750721AbWFZPw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:52:59 -0400
Date: Mon, 26 Jun 2006 08:52:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PM_TRACE corrupts RTC
In-Reply-To: <20060625232322.af3f4f6c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606260851000.3747@g5.osdl.org>
References: <20060625232322.af3f4f6c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jun 2006, Andrew Morton wrote:
> 
> On a Sony Vaio, after a suspend-to-disk and a resume, `hwclock' says
> 
>   The Hardware Clock registers contain values that are either invalid
>   (e.g.  50th day of month) or beyond the range we can handle (e.g.  Year
>   2095).
> 
> and after a reboot the machine takes a trip back to 1969.  Setting
> CONFIG_PM_TRACE=n prevents this.

That's how it works. It's by design. The RTC is where the trace events are 
stored, since that's the only piece of hw that reliably survives a reboot.

The help-text says:

        This enables some cheesy code to save the last PM event point in the
        RTC across reboots, so that you can debug a machine that just hangs
        during suspend (or more commonly, during resume).

Heh.

		Linus
