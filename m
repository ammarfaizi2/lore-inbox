Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSA1WIH>; Mon, 28 Jan 2002 17:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSA1WH5>; Mon, 28 Jan 2002 17:07:57 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:55556 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S286871AbSA1WHo>; Mon, 28 Jan 2002 17:07:44 -0500
Date: Sun, 27 Jan 2002 14:42:13 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Peeling off dcache_lock
Message-Id: <20020127144213.09bded56.rusty@rustcorp.com.au>
In-Reply-To: <20020125114410.Z8289@in.ibm.com>
In-Reply-To: <20020121174039.D8289@in.ibm.com>
	<20020124180241.4d266b3e.rusty@rustcorp.com.au>
	<20020125114410.Z8289@in.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002 11:44:11 +0530
Maneesh Soni <maneesh@in.ibm.com> wrote:

> On Thu, Jan 24, 2002 at 06:02:41PM +1100, Rusty Russell wrote:
> > Hi Maneesh!
> > 
> > 	Fantastic work!  A couple of questions, and a trivial patch:
> 
> Hi Rusty,
> 
> Thanks for code review.

Hey, anything that wins 20% on (32-way) dbench is worth reading 8)

> >  o Am I correct in asserting that you could change all the
> >    "list_empty(dentry->dhash)" tests to
> >    "dentry->d_vfs_flags & DCACHE_DEFERRED_FREE" tests, and hence change the
> >    list_del_init() to list_del() in unhash, and thus remove the d_nexthash
> >    field altogether?
> I agree that d_next_hash is a sort of hack and want to remove it. I think
> we have tried removing it in the way you are suggesting. But we never got a 
> stable code. I will have to look at this some what more.

Hmm... I finally have a dual x86 box here, so I can play with this as well.

> >  o d_lookup looks like it can return an DCACHE_DEFERRED_FREE dentry: this
> >    seems wrong: shouldn't it loop here?
> Actually d_lookup will fail if the found dentry has DCACHE_DEFERRED_FREE set.

ACK.  Sorry, my mistake.

> I will do all these corrections in the next version very soon.

I wouldn't say "corrections": your code is very nice. I'm looking forward
to your next iteration!

> > Any chance of you making it to http://linux.conf.au next month BTW?
> Probably not as I am getting married next month ;-) and lots of shopping is
> still remaining ;-).

Oh, congratulations!  Perhaps I shall have to find a conference in India
then 8)

Thanks!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
