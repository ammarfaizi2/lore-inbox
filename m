Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTDQCKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 22:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTDQCKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 22:10:41 -0400
Received: from fmr01.intel.com ([192.55.52.18]:57812 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262482AbTDQCKk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 22:10:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [BK+PATCH] remove __constant_memcpy
Date: Wed, 16 Apr 2003 19:22:33 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401A45522@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK+PATCH] remove __constant_memcpy
Thread-Index: AcMEhhozhBTbGgesTyOBOjitMlP2AwAAGyew
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Jeff Garzik" <jgarzik@pobox.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Apr 2003 02:22:33.0430 (UTC) FILETIME=[34329760:01C30488]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the fear is valid. Intel compiler, for example, uses FP if it's required to optimize the code with a particular option. And the option is not necessary obvious when telling if it uses FP or not (and it does not matter for most users). This could happen with gcc.

I think we can do it better than the compiler does, because we know the usage better, e.g. alignment, typical size, etc.

Thanks,
Jun

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> Sent: Wednesday, April 16, 2003 7:06 PM
> To: Jeff Garzik
> Cc: LKML
> Subject: Re: [BK+PATCH] remove __constant_memcpy
> 
> 
> On Wed, 16 Apr 2003, Jeff Garzik wrote:
> >
> > gcc's __builtin_memcpy performs the same function (and more) as the
> > kernel's __constant_memcpy.  So, let's remove __constant_memcpy, and let
> > the compiler do it.
> 
> Please don't.
> 
> There's no way gcc will EVER get the SSE2 cases right. It just cannot do
> it. In fact, I live in fear that we will have to turn off the compiler
> intrisics entirely some day just because there is always the worry that
> gcc will start using FP.
> 
> So the advantage of doing our own memcpy() is not that it's necessarily
> faster than the gcc built-in, but simply because I do not believe that the
> gcc people care enough about the kernel to let them make the choice.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
