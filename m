Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWHCROo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWHCROo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWHCROo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:14:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57801 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932583AbWHCROn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:14:43 -0400
Date: Thu, 3 Aug 2006 21:13:40 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take3 2/4] kevent: AIO, aio_sendfile() implementation.
Message-ID: <20060803171340.GA10698@2ka.mipt.ru>
References: <11545983603452@2ka.mipt.ru> <44D22CA4.5090405@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44D22CA4.5090405@us.ibm.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 21:13:41 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 10:04:36AM -0700, Badari Pulavarty (pbadari@us.ibm.com) wrote:
> Evgeniy Polyakov wrote:
> >AIO, aio_sendfile() implementation.
> >
> >This patch includes asynchronous propagation of file's data into VFS
> >cache and aio_sendfile() implementation.
> >Network aio_sendfile() works lazily - it asynchronously populates pages
> >into the VFS cache (which can be used for various tricks with adaptive
> >readahead) and then uses usual ->sendfile() callback.
> >
> >...
> >--- /dev/null
> >+++ b/kernel/kevent/kevent_aio.c
> >@@ -0,0 +1,584 @@
> >+/*
> >+ * 	kevent_aio.c
> >+ * 
> >  
> Since this is *almost* same as mpage.c code, wondering if its possible 
> to make common
> generic/helper routines in mpage.c and use it here ?

Yes, as I mentioned in mail to Christoph, I did it just to separate
kevent as much as possible (so I introduced ->get_block() based
approach). It can be safely moved into mpage code and used from more
clear callback like ->readpage().
Since this AIO code was decided to be postponed for a while, I'm not
updating it (just make sure that it compiles with new changes), since
overall design of AIO changes (if any) is not 100% completed.

> Thanks,
> Badari

-- 
	Evgeniy Polyakov
