Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWBXIeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWBXIeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWBXIeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:34:31 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:11679 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932088AbWBXIea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:34:30 -0500
Date: Fri, 24 Feb 2006 10:34:26 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060224083426.GA3385@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Maneesh Soni <maneesh@in.ibm.com>, Greg KH <greg@kroah.com>,
	Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219210757.GB3682@linux-sh.org> <20060223105934.GA6884@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223105934.GA6884@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 04:29:35PM +0530, Maneesh Soni wrote:
> On Sun, Feb 19, 2006 at 11:07:57PM +0200, Paul Mundt wrote:
> > +	dentry = lookup_one_len(filename, parent, strlen(filename));
> 
> lookup_one_len() needs parent's i_mutex.
> 
Good catch, thanks.

> > +	if (IS_ERR(dentry))
> > +		sysfs_hash_and_remove(parent, filename);
> 
> Also wondering if you have considered the case of -EEXIST?
> 
How is that going to happen? The line before we do sysfs_add_file(), and
if that errors out, then we never make it to lookup_one_len().

The IS_ERR() check is pretty superfluous anyways, perhaps it makes more
sense just to remove it and the sysfs_hash_and_remove() reference
entirely.
