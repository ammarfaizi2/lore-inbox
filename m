Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbTHYQev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbTHYQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:34:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:31168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262020AbTHYQeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:34:50 -0400
Date: Mon, 25 Aug 2003 19:34:45 +0300
From: Dan Aloni <da-x@gmx.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825163445.GA9531@callisto.yi.org>
References: <20030825161435.GB8961@callisto.yi.org> <20030825122532.J10720@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825122532.J10720@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 12:25:32PM -0400, Jakub Jelinek wrote:
> On Mon, Aug 25, 2003 at 07:14:35PM +0300, Dan Aloni wrote:
> > diff -Nru a/lib/string.c b/lib/string.c
> > --- a/lib/string.c	Mon Aug 25 19:03:26 2003
> > +++ b/lib/string.c	Mon Aug 25 19:03:26 2003
> > @@ -582,3 +582,19 @@
> >  }
> >  
> >  #endif
> > +
> > +/**
> > + * strdup - Allocate a copy of a string.
> > + * @s: The string to copy. Must not be NULL.
> > + *
> > + * returns the address of the allocation, or NULL on
> > + * error. 
> > + */
> > +char *strdup(const char *s)
> > +{
> > +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> > +	if (rv)
> > +		strcpy(rv, s);
> > +	return rv;
> > +}
> > +EXPORT_SYMBOL(strdup);
> 
> Better save strlen(s)+1 in a local size_t variable and use memcpy instead
> of strcpy.

Maybe, but no optimizations like this are needed for a function 
such as strdup() which is called relatively rare.

-- 
Dan Aloni
da-x@gmx.net
