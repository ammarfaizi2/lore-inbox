Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUDHDZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 23:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUDHDZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 23:25:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:46035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbUDHDZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 23:25:02 -0400
Date: Wed, 7 Apr 2004 20:24:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org,
       anton@samba.org, paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-Id: <20040407202443.78078b59.akpm@osdl.org>
In-Reply-To: <20040408030923.GA29551@zax>
References: <20040407074239.GG18264@zax>
	<20040407143447.4d8f08af.ak@suse.de>
	<1081386710.1401.86.camel@gaston>
	<20040407190126.06a9c38f.akpm@osdl.org>
	<20040408030923.GA29551@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> > I don't see much in the COW code which is ppc64-specific.  All the hardware
>  > needs to do is to provide a way to make the big pages readonly.  With a bit
>  > of an abstraction for the TLB manipulation in there it should be pretty
>  > straightforward.
>  > 
>  > Certainly worth the attempt, no?
> 
>  Yes, you have a point.  However doing it in a cross-arch way will
>  require building more of a shared abstraction about hugepage pte
>  entries that exists currently.  And that will mean making significant
>  changes to all the archs to create that abstraction.  I don't know
>  enough about the other archs to be confident of debugging such
>  changes, but I'll see what I can do.

Well the first step is to consolidate the existing duplication in 2.6.5
before thinking about new features.  That's largely a cut-n-paste job which
I've been meaning to get onto but alas have not.  I don't want to dump it
on you just because you want to tend to your COWs so if you have other
things to do, please let me know.

We could use the `weak' attribute in mm/hugetlbpage.c for those cases where
one arch really needs to do something different.

