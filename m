Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311502AbSCNEsl>; Wed, 13 Mar 2002 23:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311503AbSCNEsb>; Wed, 13 Mar 2002 23:48:31 -0500
Received: from [202.135.142.194] ([202.135.142.194]:59920 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311502AbSCNEsN>; Wed, 13 Mar 2002 23:48:13 -0500
Date: Thu, 14 Mar 2002 15:50:49 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: davids@webmaster.com, ak@suse.de, brad@linuxcanada.com,
        linux-kernel@vger.kernel.org
Subject: Re: Multi-threading
Message-Id: <20020314155049.310d9402.rusty@rustcorp.com.au>
In-Reply-To: <20020313092306.A5570@wotan.suse.de>
In-Reply-To: <20020312081002.A14745@wotan.suse.de>
	<20020313075135.AAA25107@shell.webmaster.com@whenever>
	<20020313092306.A5570@wotan.suse.de>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002 09:23:06 +0100
Andi Kleen <ak@suse.de> wrote:

> On Tue, Mar 12, 2002 at 11:51:29PM -0800, David Schwartz wrote:
> > 
> > >Just it might change immediately afterwards if you don't remove the
> > >object from public view first.
> > 
> > 	If it was in public view, whatever held it in public view would be
> > 	using it, and hence its use count could not drop to zero.
> 
> That's not correct at least in the usual linux kernel pattern of using
> reference counts for objects. Hash tables don't hold reference counts,
> only users do. If you think about it a hash table or global list holding
> a reference count doesn't make too much sense.

Depends where you are talking.  In the conntrack code (and I thought the
rest of the networking code), 0 means "free me now, NOONE has a pointer",
ie. the hash table holds 1.

dcache holds zero-count entries because their semantic requirements are
different, hence the "atomic_dec_and_lock()" stuff.

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
