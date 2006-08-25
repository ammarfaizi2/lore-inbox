Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWHYLGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWHYLGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWHYLGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:06:09 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:34361 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964880AbWHYLGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:06:08 -0400
Date: Fri, 25 Aug 2006 13:06:06 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: linux-kernel@vger.kernel.org
Subject: Fastfail: Device flag?
Message-ID: <20060825110606.GA20146@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The "md" and "multpath" drivers set a flag called "fastfail". I would
like this to become a flag that could also be set/cleared on a
per-device basis. 

I'd rather not spend the time doing the retries, and get an error
immediately. This is an application issue, and I would like to make
that choice myself.....

If there is a chance I won't have to patch kernels until eternity,
I'll write the patch to make this settable from userspace.

The current situation is that the IDE driver thinks it knows which
errors stand a chance of retrying (sectoridnotfound), and which don't
(datacrcerror). This was probably true of some disk in some distant
past. 

I'd rather not spend the time doing the retries, and get an error
immediately. This is an application issue.... 


I was thinking about adding a flag to genhd->flags, and then centrally
in "make_request" set the flag on the specific request if that flag is
set. But if I'm not mistaken, make_request has disappeared (possibly
changed into generic_make_request), and thus this change would have to
be in all "make_request" functions. I'd rather have a single line. So if
anbody has a hint as to where to put it, feel free to point me in the
right direction... ;-)

Comments?

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
