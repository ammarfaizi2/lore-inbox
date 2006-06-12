Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWFLRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWFLRtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWFLRtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:49:45 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2421 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWFLRtp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:49:45 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=OTKj0gyAjft207JJwle++DYOYwCAs5GvXsIVXa6ls7uOI2A3pSy8mnO0y9Fi5fli6
	/5pj4INmgNFZsPWletR0Q==
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
	physical pages backing it
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-mm@kvack.org, Linux-kernel@vger.kernel.org
In-Reply-To: <20060609194236.4b997b9a.akpm@osdl.org>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
	 <20060609194236.4b997b9a.akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 12 Jun 2006 10:49:23 -0700
Message-Id: <1150134563.9576.25.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 19:42 -0700, Andrew Morton wrote:
> On Fri, 09 Jun 2006 18:33:55 -0700
> Rohit Seth <rohitseth@google.com> wrote:
> 
> > Below is a patch that adds number of physical pages that each vma is
> > using in a process.  Exporting this information to user space
> > using /proc/<pid>/maps interface.
> 
> Ouch, that's an awful lot of open-coded incs and decs.  Isn't there some
> more centralised place we can do this?
> 

I'll look into this.  Possibly combining it with mm counters.

> What locking protects vma.nphys (can we call this nr_present or something?)
> 

I'll need to use the same atomic counters as mm.   And Yes nr_present is
a better name.

> Will this patch do the right thing with weird vmas such as the gate vma and
> mmaps of device memory, etc?
> 

I think so.  (though strictly speaking those special vmas are less
interesting).  But final solution (if we do decide to implement this
counter) will address that.

-rohit

