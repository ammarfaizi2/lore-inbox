Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbTEEQtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEEQtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:49:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65421 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id S263663AbTEEQsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:48:55 -0400
Date: Mon, 5 May 2003 10:01:18 -0700
From: Bob Miller <rem@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.68] Convert elan-104nc to remove check_region().
Message-ID: <20030505170118.GA17276@doc.pdx.osdl.net>
References: <20030502204207.GB25713@doc.pdx.osdl.net> <20030505044653.D296B2C255@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505044653.D296B2C255@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the request_region() calls in this driver (plus all the now removed
check_region()) calls are commented out because of conflicts with the PIC.

The release_region() call below was NOT commented out.  If the driver
isn't really requsting the region it shouldn't be release it.  So, I
commented it out.

On Mon, May 05, 2003 at 02:38:02PM +1000, Rusty Russell wrote:
> In message <20030502204207.GB25713@doc.pdx.osdl.net> you write:
> > Moved the request_region() call to replace check_region() and adds
> > release_region()'s in the error paths that occure before the old
> > call to request_region().
> 
> >  NOTE: This patch just updates comments.
> 
> Actually. It doesn't.
> 
> And why this:
> 
> > @@ -227,14 +227,14 @@
> >  	}
> >  
> >  	iounmap((void *)iomapadr);
> > -	release_region(PAGE_IO,PAGE_IO_SIZE);
> > +	/* release_region(PAGE_IO,PAGE_IO_SIZE); */
> >  }
> 
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
