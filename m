Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265642AbUFCQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265642AbUFCQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbUFCQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:28:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:31645 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265642AbUFCQ21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:28:27 -0400
Date: Thu, 3 Jun 2004 09:27:13 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-ID: <20040603162712.GA3291@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com> <1086222156.29391.337.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086222156.29391.337.camel@bach>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:22:36AM +1000, Rusty Russell wrote:
> On Thu, 2004-06-03 at 09:11, Paul Jackson wrote:
> > +	/*
> > +	 * Hack alert:
> > +	 * 1) This could overwrite a buffer w/o warning.  Someone should
> > +	 *     pass us a buffer size (count) or use seq_file or something
> > +	 *     to avoid buffer overrun risks.
> 
> Then just use -1UL as the arg to scnprintf, if you don't have a real
> number.  That way the overflow will at least have a chance of detection
> in the sysfs code, which I think it should check in
> file.c:fill_read_buffer().  Greg?

We do check for an error in that function, so returning any negative
error value for a show() sysfs callback will be handled properly.

thanks,

greg k-h
