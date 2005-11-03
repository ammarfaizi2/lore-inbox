Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVKCPJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVKCPJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVKCPJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:09:29 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:60688 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030273AbVKCPJ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:09:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cpbLB54a9ZjYAcJY2wrfj70UXD4AUsAgUNrC7xDZkiJokiqv0p14Z9JlBJ0Ln4/5m9Qfczb2jlVKwp0yGZsHPh7qIAo4tp3pkLhEDQV5VnmCteuPUBsuR3bNJ1QDXInpB/BP5prTHHMjV7ESEBMyy4wP+/0UdQ639EpsSxQ5Vbw=
Message-ID: <afcef88a0511030709v1589ffe7s9052cd636d61c956@mail.gmail.com>
Date: Thu, 3 Nov 2005 09:09:24 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <20051103060236.GB5044@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103034929.GD3005@sshock.rn.byu.edu>
	 <20051103060236.GB5044@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 02, 2005 at 08:49:29PM -0700, Phillip Hellewell wrote:
> > +#include <net/sock.h>
> > +#include <linux/file.h>
>
> net/ after linux/ please.  Why do you need sock.h anyway?
We don't, thanks for pointing that out. It will be removed.

> > +/**
> > + * Module parameter that defines the ecryptfs_verbosity level.
> > + */
> > +#define VERBOSE_DUMP 9
> > +#ifdef DEBUG
> > +int ecryptfs_verbosity = VERBOSE_DUMP;
> > +#else
> > +int ecryptfs_verbosity = 1;
> > +#endif
> > +module_param(ecryptfs_verbosity, int, 1);
>
> I don't think you want a "1" here, do you?  Hint, it's not doing what
> you think it is doing...
Would you care to explain, providing its short, what it does? I don't
mind admitting I don't know everything, especially when it comes to
kernel code. If I am to RTFM, please point me to the right M. :)

> > +void __ecryptfs_kfree(void *ptr, const char *fun, int line)
> > +{
> > +     if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
> > +             ecryptfs_printk_release(ptr, fun, line);
> > +     kfree(ptr);
> > +}
> > +
> > +void *__ecryptfs_kmalloc(size_t size, unsigned int flags, const char *fun,
> > +                      int line)
>
> <snip>
>
> Don't have wrappers for all of the common kernel functions, just call
> them directly.
We do call them directly as long as DEBUG is not defined. This code
exists for development purposes (or debug, if you will) so that we can
track memory allocations and other various things in the logs. All
wrappers for the common kernel functions are #defined in
ecryptfs_kernel.h so via preprocessing, it all becomes pretty.

Of course, these can be removed, assuming that this is not an
acceptable approach.

Mike
