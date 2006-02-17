Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWBQLYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWBQLYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWBQLYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:24:06 -0500
Received: from verein.lst.de ([213.95.11.210]:58602 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751202AbWBQLYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:24:05 -0500
Date: Fri, 17 Feb 2006 12:23:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
Message-ID: <20060217112355.GE28448@lst.de>
References: <20060215130734.GA5590@lst.de> <20060215214833.GA5066@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215214833.GA5066@stusta.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 10:48:33PM +0100, Adrian Bunk wrote:
> On Wed, Feb 15, 2006 at 02:07:34PM +0100, Christoph Hellwig wrote:
> > Drivers have no business looking at the task list and thus using this
> > lock.  The only possibly modular users left are:
> > 
> >  arch/ia64/kernel/mca.c
> >...
> >  fs/binfmt_elf.c
> > 
> > which I'll send out fixes for soon.
> >...
> 
> These two can't be built modular.

s390 and sparc64 allows a modular BINFMT_ELF32, which #includes
fs/binfmt_elf.c after redefining various things.  But I suspect the
right fix for this is to disallow building it modular..

For arch/ia64/kernel/mca.c you're right.  Other mca files can be built
modular and need odd symbols aswell, but mca.c is always built in.

