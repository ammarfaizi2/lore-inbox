Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUGTR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUGTR2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUGTR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:28:55 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:25950 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266049AbUGTR22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:28:28 -0400
Date: Tue, 20 Jul 2004 21:28:58 +0200
From: sam@ravnborg.org
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-ID: <20040720192858.GB9147@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net> <20040720164640.GH10921@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720164640.GH10921@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 06:46:40PM +0200, Pavel Machek wrote:
> Hi!
> 
> > In the end, these patches remove pmdisk from the kernel and clean up the
> > swsusp code base. The result is a single code base with greatly improved
> > code, that will hopefully help others underestand it better.
> 
> Followup patch:
> 
> * if machine halt fails, it is very dangerous to continue.
> 
> diff -ur linux.middle/kernel/power/disk.c linux/kernel/power/disk.c
> --- linux.middle/kernel/power/disk.c	2004-07-19 08:58:08.000000000 -0700
> +++ linux/kernel/power/disk.c	2004-07-19 15:00:16.000000000 -0700
> @@ -63,6 +63,9 @@
>  		break;
>  	}
>  	machine_halt();
> +	/* Valid image is on the disk, if we continue we risk serious data corruption
> +	   after resume. */
> +	while(1);

Would be nicer to use:

	while(1)
		/* Loop forever */;

	Sam
