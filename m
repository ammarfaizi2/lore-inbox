Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbTFRXQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265605AbTFRXQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:16:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9719 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265603AbTFRXQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:16:50 -0400
Date: Wed, 18 Jun 2003 15:59:14 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Robert Love <rml@tech9.net>, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030618225913.GB2413@kroah.com>
References: <3EE8D038.7090600@mvista.com> <1055459762.662.336.camel@localhost> <20030612232523.GA1917@kroah.com> <200306132201.47346.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306132201.47346.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 10:01:47PM +0200, Oliver Neukum wrote:
> 
> > +
> > +	spin_lock(&sequence_lock);
> > +	envp [i++] = scratch;
> > +	scratch += sprintf(scratch, "SEQNUM=%ld", sequence_num) + 1;
> > +	++sequence_num;
> > +	spin_unlock(&sequence_lock);
> >
> >  	kobj_path_length = get_kobj_path_length (kset, kobj);
> >  	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
> 
> If this kmalloc fails, you'll have a hole in the numbers and
> user space will be very confused. You need to report dropped
> events if you do this.

Yes, we should add the sequence number last.

Good catch.

greg k-h
