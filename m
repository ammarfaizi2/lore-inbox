Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVH1MuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVH1MuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 08:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVH1MuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 08:50:04 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:61122 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1751159AbVH1MuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 08:50:03 -0400
To: Michael Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Radeon acpi vgapost
In-Reply-To: <43111298.80507@engr.orst.edu>
References: <43111298.80507@engr.orst.edu>
Date: Sun, 28 Aug 2005 13:50:01 +0100
Message-Id: <E1E9Mbq-0002WM-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Marineau <marineam@engr.orst.edu> wrote:

> Thses patches resume ATI radeon cards from acpi S3 suspend when using
> radeonfb by reposting the video bios. This is needed to be able to use
> S3 when the framebuffer is enabled.

Please don't make this unconditional. There's no guarantee whatsoever
that the code at c000:0003 does anything useful on a laptop, and it may
actually be harmful in some cases. The sensible approach is to whitelist
it based on DMI entries or provide a sysfs attribute so userspace can
enable/disable it.

How well does this patch deal with multihead? If I have a mixed
radeon/non-radeon system, and the primary head is a non-radeon, won't
this result in the wrong card being POSTed?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
