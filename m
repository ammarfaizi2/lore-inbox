Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270505AbTGNCDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270506AbTGNCDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:03:51 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:4073 "EHLO fed1mtao04.cox.net")
	by vger.kernel.org with ESMTP id S270505AbTGNCDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:03:49 -0400
Date: Sun, 13 Jul 2003 19:18:36 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Cc: linux-kernel@vger.kernel.org, "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [BUG] 100% reproducible oops on ATAPI CD-ROM I/O error, 2.5.75
Message-ID: <20030714021836.GA25869@ip68-4-255-84.oc.oc.cox.net>
References: <20030711093335.GC2860@ip68-4-255-84.oc.oc.cox.net> <E19bp2m-0006gf-00@regenbogen.informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19bp2m-0006gf-00@regenbogen.informatik.uni-bremen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:10:08AM +0200, Moritz Muehlenhoff wrote:
> Does anyone have an explanation why cdrecord fails to write the last
> sector properly? Is this a kernel issue or a bug in cdrecord?
> I'm using cdrtools 2.01a15.

If you don't specify "-dao" or an equivalent function to cdrecord, it
records in TAO mode by default. IIRC that mode *by definition* will
leave you with an extraneous unreadable sector (or maybe it's several, I
don't remember) after the actual data has ended. (Similarly, TAO gives
you 2 seconds of forced silence between audio tracks.)

So if you believe it's a bug, then you would have to argue that the bug
is in cdrecord's default choice of recording mode. However, if cdrecord
is changed to not do this by default, it could break compatibility with
some older recorders.

The other possible bug is in readcd. (I think) it should be able to
avoid choking on the extraneous sector(s) that result from recording the
CD in TAO mode. If you're running a reasonably recent 2.4 or 2.5 kernel
then dd handles this properly on most drives, however.

-Barry K. Nathan <barryn@pobox.com>
