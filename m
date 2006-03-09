Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWCIDUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWCIDUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWCIDUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:20:16 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:4318 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1161006AbWCIDUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:20:14 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Wed, 8 Mar 2006 19:19:59 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061301.37923.dsp@llnl.gov> <1141679261.5568.13.camel@laptopd505.fenrus.org>
In-Reply-To: <1141679261.5568.13.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081919.59763.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 13:07, Arjan van de Ven wrote:
> > Is it more desirable to dynamically allocate kobjects than to declare
> > them statically?
>
> Yes
>
> >  If so, I'd be curious to know why dynamic
> > allocation is preferred over static allocation.
>
> because the lifetime of the kobject is independent of the lifetime of
> the memory of your static allocation.
> Separate lifetimes -> separate memory is a very good design principle.

I'm not familiar with the internals of the module unloading code.
However, my understanding of the discussion so far is that the kernel
will refuse to unload a module while any of its kobjects still have
nonzero reference counts (either by waiting for the reference counts
to hit 0 or returning -EBUSY).

If this is the case, then I don't see any harm in declaring kobjects
statically.  Declaring a kobject statically is simpler than
dynamically allocating and freeing it.  Am I still missing something?
