Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVGVXR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVGVXR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVGVXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:17:29 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:27880 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262219AbVGVXRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:17:24 -0400
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
In-Reply-To: <Pine.LNX.4.58.0507221942540.5475@skynet>
References: <Pine.LNX.4.58.0507221942540.5475@skynet>
Date: Sat, 23 Jul 2005 00:17:20 +0100
Message-Id: <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> wrote:

> 	At OLS at lot of people were giving out about cards not resuming,
> so using a patch from Michael Marineau and help from lots of people
> sitting around in a circle at OLS I've gotten a patch that restores video
> on my laptop by going into real mode and re-posting the BIOS during
> resume,

On laptops, the code at c000:0003 may jump to BIOS code that isn't
present after system boot. In userspace, this isn't too much of a
problem - the userspace code tends to just fall over rather than hanging
the machine. What happens if the kernel hits illegal or inappropriate
code on resume?

I'm still fairly convinced that the best approach here is to carry it
out in userspace, though this may require some support for asking
framebuffers not to try to print anything until userspace is running.
The only "real" solution is for the framebuffer drivers to know how to
program the chip from scratch.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
