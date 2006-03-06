Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWCFVcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWCFVcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWCFVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:32:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:4011 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932359AbWCFVcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:32:07 -0500
Date: Mon, 6 Mar 2006 21:32:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060306213203.GJ27946@ftp.linux.org.uk>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com> <200603061301.37923.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603061301.37923.dsp@llnl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 01:01:37PM -0800, Dave Peterson wrote:
> Regarding the above problem with the kobject reference count, this
> was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
> in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
> complete() in edac_memctrl_master_release() and then have the module
> cleanup code wait for the completion.  I think there were a few other
> instances of this type of problem that I also fixed in the
> above-mentioned patch.

This is not a fix, this is a goddamn deadlock.
	rmmod your_turd </sys/spew/from/your_turd
and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
