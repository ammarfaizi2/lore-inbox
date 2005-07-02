Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVGBQny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVGBQny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVGBQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:43:53 -0400
Received: from mta1.prod1.dngr.net ([216.220.209.220]:9327 "EHLO
	mfe1.prod.danger.com") by vger.kernel.org with ESMTP
	id S261222AbVGBQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:43:50 -0400
Date: Sat, 2 Jul 2005 12:43:46 -0400
Subject: Re: FUSE merging?
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
X-Mailer: Danger Service
Content-Transfer-Encoding: 7bit
In-Reply-To: <m1acl5frw6.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
Mime-Version: 1.0
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <m1acl5frw6.fsf@ebiederm.dsl.xmission.com>
From: Eric Van Hensbergen <ericvh@gmail.com>
Message-Id: <1120322629.381A13EE@dl11.dngr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jul 2005 6:15 am, Eric W. Biederman wrote:
>
> Taking a quick glance at v9fs and fuse I fail to see how either
> plays nicely with the page cache.
>

True, in fact it actively avoids using it.  The previous version used 
both the page cache and the dcache with undesirable effects on synthetic 
file systems so we removed cache support.  Our intention is to design a 
cache layer (similar to cfs on Plan 9) which handles cache semantics 
which can be parameterized with the appropriate cache policy depending 
on the underlying file server.

> v9fs according to my reading of the protocol specification does
> not have any concept of a lease.  So you can't tell if you are
> talking about a virtual filesystem where all calls should be passed
> straight to the server or a real filesystem where you can perform
> caching.

While 9P contains no explicit support for leases and cacheing there is 
an informal mechanism which is used (at least for plan 9 file servers).  
If the qid.vers is 0 the file can be assumed to be a synthetic file and 
so it is not cached.

>
> Neither implementation seems to forward user space locks to the
> filesystem server.
>

Yup.  We have exclusive open semantics but not locks in the Posix 
sense.  Lock support is on our 2.1 roadmap.

    -eric
