Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTDDH61 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTDDH61 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:58:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45965 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263459AbTDDH6S (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 02:58:18 -0500
Date: Fri, 4 Apr 2003 10:09:37 +0200
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       arrays@hp.com, steve.cameron@hp.com
Subject: Re: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-ID: <20030404080937.GH2072@suse.de>
References: <20030403120308.620e5a14.rddunlap@osdl.org> <20030404003044.GB16832@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030404003044.GB16832@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04 2003, Jörn Engel wrote:
> > +		error = copy_to_user(io, my_io, sizeof(*my_io)) ? -EFAULT : 0;
> 
> copy_to_user returns the bytes successfully copied.
> error is set to -EFAULT, if there was actually data transferred?
> 
> How about:
> +		error = copy_to_user(io, my_io, sizeof(*my_io)) < sizeof(*my_io) ? -EFAULT : 0;

Pure nonsense! Correct logic, and much nicer to read IMO is:

	if (copy_to_user(io, my_io, sizeof(*my_io))
		error = -EFAULT;

-- 
Jens Axboe

