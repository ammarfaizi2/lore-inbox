Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUEGO1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUEGO1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUEGO0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:26:11 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:13440 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263607AbUEGOZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:25:12 -0400
Date: Thu, 6 May 2004 12:02:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Matthew Wilcox <willy@debian.org>, John Belmonte <john@neggie.net>,
       acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs namespace
Message-ID: <20040506100210.GA194@elf.ucw.cz>
References: <1081453741.3398.77.camel@patsy.fc.hp.com> <1081549317.2694.25.camel@patsy.fc.hp.com> <4077535D.6020403@neggie.net> <1081566768.2562.8.camel@wilson.home.net> <407786C6.7030706@neggie.net> <1081629776.2562.40.camel@wilson.home.net> <1081653618.2562.52.camel@wilson.home.net> <20040411222940.GJ18329@parcelfarce.linux.theplanet.co.uk> <1081740686.1715.20.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081740686.1715.20.camel@debian>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It seems unintuitive that you have to read the file for the method to
> > take effect.  How about having the write function invoke the method and
> > (if there is a result) store it for later read-back via the read function?
> > It should be discarded on close, of course.  A read() on a file with
> > no stored result should invoke the ACPI method (on the assumption this
> > is a parameter-less method) and return the result directly.  Closing a
> > file should discard any result from the method.
> 
>    How's this?  It behaves the way you described, but might be doing
> some questionable things with the buffer to get there.  Is there a
> better place to store the return data than back into the buf passed to
> write() (aka file->private_data)?  Without adding callbacks to
> open/close, I'm not sure how else we can dispose of the results on
> close.  Thanks,


> +	/*
> +	 * For convenience, handle cases where the last argument
> +	 * is too small.
> +	 */
> +	count = length / sizeof(union acpi_object);
> +	if (length % sizeof(union acpi_object))
> +		count++;
> +
> +	if (count) {
> +		size = sizeof(struct acpi_object_list) +
> +		       ((count - 1) * sizeof(union acpi_object *));

This probably makes it *way* too implementation dependand.
								Pavel
-- 
When do you have heart between your knees?
