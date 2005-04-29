Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVD2O1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVD2O1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVD2O1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:27:10 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:50225 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262716AbVD2O0o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:26:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OOJVJhNPC2S76JnJ/Qd/N6QlwJD5r9H6BmSIy4ZqAoQkoUvIWmUFeyTAM+7hyF1MsWpR/63ebRymulWWj0GMAVKuPIYf4GyjvBcgjy0ADDryhtwZmjc1FybL9ttmHF7YGT9Eu4jL7oGr9mYZQLhXW/nmG7/2LVJGVGS65k5aA3Y=
Message-ID: <5ebee0d105042907265ff58a73@mail.gmail.com>
Date: Fri, 29 Apr 2005 10:26:41 -0400
From: Bill Jordan <woodennickel@gmail.com>
Reply-To: bjordan@infinicon.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Timur Tabi <timur.tabi@ammasso.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20050426133752.37d74805.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050425135401.65376ce0.akpm@osdl.org>
	 <52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
	 <52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com>
	 <52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org>
	 <5264y9s3bs.fsf@topspin.com> <426EA220.6010007@ammasso.com>
	 <20050426133752.37d74805.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Andrew Morton <akpm@osdl.org> wrote:

> Our point is that contemporary microprocessors cannot electrically do what
> you want them to do!
> 
> Now, conceeeeeeiveably the kernel could keep track of the state of the
> pages down to the byte level, and could keep track of all COWed pages and
> could look at faulting addresses at the byte level and could copy sub-page
> ranges by hand from one process's address space into another process's
> after I/O completion.  I don't think we want to do that.
> 
> Methinks your specification is busted.

I agree in principal. However, I expect this issue will come up with
more and more new specifications, and if it isn't addressed once in
the linux kernel, it will be kludged and broken many times in many
drivers.

I believe we need an kernel level interface that will pin user pages,
and lock the user vma in a single step. The interface should be used
by drivers when the hardware mappings are done. If the process is
split into a user operation to lock the memory, and a driver operation
to map the hardware, there will always be opportunity for abuse.

Reference counting needs to be done by this interface to allow
different hardware to interoperate.

The interface can't overload the VM_LOCKED flag, or rely on any other
attributes that the user can tinker with via any other interface.

And as much as I hate to admit it, I think on a fork, we will need to
copy parts of pages at the beginning or end of user I/O buffers.

-- 
Bill Jordan
InfiniCon Systems
