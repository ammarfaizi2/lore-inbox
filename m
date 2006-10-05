Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWJEOgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWJEOgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWJEOgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:36:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:63983 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932098AbWJEOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:36:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=p4bfkHsytPn3IM66AW6hgMYF2xGMlcvu2vjzgs2/Wzqab1HrDLKUztW2Ch0aOPIw5m2W9ugFkMo2garHK9i1c9KwN88lmDqJeDmMKvyHmxESe3J7yOgThMTJ6QVZls2/Cu6h4vO03d6ZU5ssMgX6U6HBCGEdOdqdTtC+geeIbV8=
Date: Thu, 5 Oct 2006 14:36:07 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061005143607.GH352@slug>
References: <20061004193229.GA352@slug> <4524106C.8010807@garzik.org> <20061004202938.GF352@slug> <20061004203311.GI28596@parisc-linux.org> <20061004212633.GG352@slug> <20061005135924.GB5335@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005135924.GB5335@martell.zuzino.mipt.ru>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 05:59:24PM +0400, Alexey Dobriyan wrote:
> On Wed, Oct 04, 2006 at 09:26:33PM +0000, Frederik Deweerdt wrote:
> > On Wed, Oct 04, 2006 at 02:33:11PM -0600, Matthew Wilcox wrote:
> > > On Wed, Oct 04, 2006 at 08:29:38PM +0000, Frederik Deweerdt wrote:
> > > > I see. Just to be sure that I got the matter right, does the issue boils
> > > > down to a choice between:
> > >
> > > woah, woah, woah, you're getting yourself confused here.
> > yep :), I clearly missed the point you made there:
> > http://lkml.org/lkml/2006/10/3/404
> > I've re-read it, hope I've got it right this time.
> > >
> > > You're looking at what the architectures do here.  We're not concerned
> > > with that, we're concerned with what the device drivers do with whatever
> > > value the architecture has stuck in pdev->irq.
> > Not sure I get it still though. Is the issue more than just the location
> > of the irq validation code? If yes, could you explain what are the
> > differences between your proposal and Jeff's ?
> >
> > Anyway, let me have another try at summing up the issue:
> >
> > #1
> > - generic irq validation code in include/linux/pci.h
> > - arch specific irq validation code in include/asm/pci.h
> > - is_irq_valid() called by pci_request_irq()
> 
> s/is_irq_valid/valid_irq/g methinks.
The point of the is_ prefix is to make it clear that we're returning 1
if it's true and 0 if it's false. 
<checks thread on return values>
err... you said[1]:
> There are at least 3 idioms:
> [...]
> 2) return 1 on YES, 0 on NO.
> [...]
> #2 should only be used if condition in question is spelled nice:
Which I thought made sense, and that's why the is_ prefix is there now.
Am I missing something?

Regards,
Frederik
[1] http://lkml.org/lkml/2006/8/18/399
