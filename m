Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVCBVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVCBVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCBVa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:30:57 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:49670 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S262547AbVCBVaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:30:15 -0500
Message-Id: <200503022130.j22LU6H02463@blake.inputplus.co.uk>
To: Corey Minyard <cminyard@mvista.com>
cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for krefs 
In-Reply-To: <422617F1.2080404@mvista.com> 
Date: Wed, 02 Mar 2005 21:30:06 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Corey,

> Here is the documentation for krefs, with the kref_checked stuff
> removed and a few other things cleaned up.

Great, more documentation.  :-)  A few minor points...

> +To use a kref, add a one to your data structures like:

s/a one/one/

> +You must initialize the kref after you allocate it.  To do this, call
> +kref init as so:

s/kref init/kref_init/

> +Once you have a refcount, you must follow the following rules:

s/refcount/initialised kref/

> +	if (task == ERR_PTR(-ENOMEM)) {
> +		rv = -ENOMEM;
> +	        kref_put(&data->refcount);

s/)/, data_release)/

> +		goto out;
> +	}
> +
> +	.
> +	. do stuff with data here
> +	.
> + out:
> +	kref_put(data, data_release);

s/data/\&data->refcount/ ?

> +	return rv;
> +}
> +
> +This way, it doesn't matter what order the two threads handle the
> +data, the put handles knowing when the data is free and releasing it.

s/put/kref_put()/

> +The kref_get() does not require a lock, since we already have a valid
> +pointer that we own a refcount for.  The put needs no lock because
> +nothing tries to get the data without already holding a pointer.

Cheers,


Ralph.

