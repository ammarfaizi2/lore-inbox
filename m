Return-Path: <linux-kernel-owner+w=401wt.eu-S1161366AbXAHT1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161366AbXAHT1t (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbXAHT1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:27:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:44692 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161249AbXAHT1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:27:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Eb7BpLd5Dv1UMr7T/n4Gcu7211FH5V04xX66moeTw/p3tJbugQC1ThDmOPE3yrB4zC486gGuHzTmO1jt4AU4WMlFjBqyfvluvkTb4LBZb+G+wHorog6x9Cdxdbmxt/fiz1uThH2R7peIOeDIWraOUbbYk7ZsBKNsmSYjJlAKBYE=
Date: Mon, 8 Jan 2007 19:25:07 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Greg KH <gregkh@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: kobject.c changes in -mm
Message-ID: <20070108192507.GC15292@slug>
References: <20070108133747.GA19692@infradead.org> <20070108190942.GA23629@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108190942.GA23629@suse.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 11:09:42AM -0800, Greg KH wrote:
> On Mon, Jan 08, 2007 at 01:37:47PM +0000, Christoph Hellwig wrote:
> > --- linux-2.6.20-rc3/lib/kobject.c      2007-01-01 23:04:49.000000000 -0800
> > +++ devel/lib/kobject.c 2007-01-04 21:13:21.000000000 -0800
> > @@ -15,6 +15,8 @@
> >  #include <linux/module.h>
> >  #include <linux/stat.h>
> >  #include <linux/slab.h>
> > +#include <linux/kallsyms.h>
> > +#include <asm-generic/sections.h>
> > 
> > +#ifdef CONFIG_X86_32
> > +static int ptr_in_range(void *ptr, void *start, void *end)
> > +{
> > +       /*
> > +        * This should hopefully get rid of causing warnings
> > +        * if the architecture did not set one of the section
> > +        * variables up.
> > +        */ 
> > +       if (start >= end)
> > +               return 0;
> > +
> > +       if ((ptr >= start) && (ptr < end))
> > +               return 1;
> > +       return 0;
> > +}      
> > 
> > 
> > Can anyone explain WTF is going on here?  Including asm-generic headers
> > in core code definitly is not okay.  As are random CONFIG_X86_32 ifdefs
> > in said code.
> 
> It's a hack for debugging.  See the full patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/warn-when-statically-allocated-kobjects-are-used.patch
> 
> It is never going to go to mainline, due to the arch-specific hacks as
> you have noted.  But is good to have for debugging and getting error
> reports from users of -mm.
> 
Could a CONFIG_{MM,HACK}  option be added for this kind of hacks? It could
help clarify what the aim of the code is.

Regards,
Frederik
