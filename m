Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbTGFQcA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbTGFQcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:32:00 -0400
Received: from granite.he.net ([216.218.226.66]:65286 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S266684AbTGFQb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:31:59 -0400
Date: Sun, 6 Jul 2003 09:46:26 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kobjects, sysfs and the driver model make my head hurt
Message-ID: <20030706164626.GA17596@kroah.com>
References: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 05:33:53PM +0100, Matthew Wilcox wrote:
> 
> struct kobject * kobject_get(struct kobject * kobj)
> {
> 	if (kobj) {
> 		WARN_ON(!atomic_read(&kobj->refcount));
> 		atomic_inc(&kobj->refcount);
> 	}
> 	return kobj;
> }

That's nice.  Remember, we used to have a lock in there, that's why the
code doesn't look that clean after it was removed.

> But why return anything?  Which looks clearer?
> 
> (a)	kobj = kobject_get(kobj);

This is the way to call kobject_get(), as the object we get after the
function returns is the one we can then safely use.

> The first one makes me think that kobject_get might return a different
> kobject than the one I passed in.  That doesn't make much sense.

Think of it as, "now we can use this kobject, not the one before calling
kobject_get()".

thanks,

greg k-h
