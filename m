Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVKVAh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVKVAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVKVAh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:37:28 -0500
Received: from tim.rpsys.net ([194.106.48.114]:27075 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964803AbVKVAh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:37:27 -0500
Subject: Re: [PATCH] Sharp power management: split into sharpsl-dependend
	and generic parts
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051121224706.GA12906@elf.ucw.cz>
References: <20051121224706.GA12906@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 00:37:02 +0000
Message-Id: <1132619822.7632.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 23:47 +0100, Pavel Machek wrote:
> Hi!
> 
> This splits sharpsl_pm.c into sharpsl_pm.c and
> sharp_pm.c. sharpsl_pm.c contains stuff that is shared between spitz
> and corgi, sharp_pm.c contains more widely usable code. I'd like
> something like this to be eventually merged... [Of course, I'll
> cleanup #ifdef COLLIE's, I did not realize some were still pending.]
> 
> Comments?

The patch makes it very difficult to see what you've changed. The other
ifdef COLLIEs look fairly straight forward to clean up and once that's
done I'm ok with the principle of it.

I don't think the filenames are quite right as collie is still a Sharp
SL series device. How about leaving the common code in sharpsl_pm.c and
adding sharpsl_pm_pxa.c for the corgi/spitz common code? That should
make the diffs easier to read. Eventually, sharpsl_pm.c should probably
end up in arm/common but for now, I'd like to see easy to read diffs.

Thinking further about the structure, I have another idea which might be
worth thinking about. If the common sharpsl_pm code was moved to
arm/common, the files mach-sa1100/sharpsl_pm.c and mach-pxa/sharpsl_pm.c
could provide the mach dependent functions Only one of the two would
ever get compiled into a kernel so the files can provide the same
function namespace and avoid any ugly ifdefs or tables of function
pointers.

Out of interest, does the code work on collie yet?

Richard

