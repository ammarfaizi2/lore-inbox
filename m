Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265778AbUFDMrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUFDMrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUFDMrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:47:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36037 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265781AbUFDMrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:47:11 -0400
Date: Fri, 4 Jun 2004 14:47:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040604124704.GA1946@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406041357.58813.bzolnier@elka.pw.edu.pl> <20040604120140.GX1946@suse.de> <200406041438.44706.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041438.44706.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> Well, thanks but I still think that your patch suits crappy code perfectly
> (you know all the complains).

I'm not on a crusade to clean up drivers/ide, in fact I could not care
less it if rots away (thank fully it is doing just that, pata is going
away). Most of your complaints are not valid in my opinion (->wrq usage
is fine. it's not pretty, but it's not broken as long as you serialize
access across the hwgroup of course). Like the rest, it's an artifact of
how messy the code paths are in there. That could be cleaned too
naturally, but that's someone elses job and I'm not about to increase my
work load in that area.

That you need to queue pre/post flushes to support barriers is a _driver
implementation detail_ in my opinion. You don't want to even advertise
that to upper layers. I will move a little of that into the block layer,
if only because SATA will need it as well.

As for REQ_DRIVE_TASK and ide_get_error_location(), well hell I do take
patches! If there's something you consider broken, damnit send a patch
to correct it and I'll surely merge it into the base if I agree it makes
sense. That's the way to get changes done if you feel something should
be different, snide remarks with basically zero detail is not.

-- 
Jens Axboe

