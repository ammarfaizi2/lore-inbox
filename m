Return-Path: <linux-kernel-owner+w=401wt.eu-S932244AbXALQnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXALQnu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 11:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXALQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 11:43:50 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:37556 "EHLO
	noname.neutralserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbXALQnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 11:43:50 -0500
Date: Fri, 12 Jan 2007 18:43:40 +0200
From: Dan Aloni <da-x@monatomic.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: kexec + ACPI in 2.6.19 (was: Re: kexec + USB storage in 2.6.19)
Message-ID: <20070112164339.GA24291@localdomain>
References: <20070112122444.GA28597@localdomain> <m1mz4oe3xm.fsf@ebiederm.dsl.xmission.com> <20070112145710.GA29884@localdomain> <m1irfce06s.fsf@ebiederm.dsl.xmission.com> <20070112160243.GA13980@localdomain> <20070112162800.GA23791@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112162800.GA23791@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-PopBeforeSMTPSenders: da-x@monatomic.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 06:28:00PM +0200, Dan Aloni wrote:
> On Fri, Jan 12, 2007 at 06:02:43PM +0200, Dan Aloni wrote:
> > On Fri, Jan 12, 2007 at 08:26:03AM -0700, Eric W. Biederman wrote:
> > > Dan Aloni <da-x@monatomic.org> writes:
> > > 
> > > > I'm attaching the full logs.
> > > 
> > > Thanks.
> > > 
> > > > [ 8656.272980] ACPI Error (tbxfroot-0512): Could not map memory at 0000040E for length 2 [20060707]
> > > 
> > > Ok. This looks like the first sign of trouble.
> > > Normally I would suspect a memory map issue but your e820 memory map looks fine,
> > > although a little different between the two kernels.
> > > 
> > > Is this enough of a hint for you to dig more deeply?
> > 
> > Reverting just the ACPI code (everything under drivers/acpi/*) 
> > back to the version of 2.6.18.3 doesn't fix the problem, so it 
> > must be something else.
> 
> Just occured to me that I didn't revert the relevant code under 
> arch/x86_64 so it might still be related somehow..

After adding a few prints inside __ioremap() it appears the function
exits for phys_addr==0x40e because (!PageReserved(page)).

Isn't page 0 supposed to be reserved? I clearly see that it is
being reserved under setup_arch(). 

Odd, I must say...

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il
