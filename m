Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281738AbRLGOvZ>; Fri, 7 Dec 2001 09:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLGOvF>; Fri, 7 Dec 2001 09:51:05 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:48392 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281738AbRLGOuy>;
	Fri, 7 Dec 2001 09:50:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>, cs@zip.com.au
Subject: Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 15:53:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <20011207141913.A26225@zapff.research.canon.com.au> <3C109FE3.5070107@namesys.com>
In-Reply-To: <3C109FE3.5070107@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CMN6-0000t8-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 11:54 am, Hans Reiser wrote:
> Cameron Simpson wrote:
> 
> >On Thu, Dec 06, 2001 at 06:41:17AM +0300, Hans Reiser <reiser@namesys.com> 
wrote:
> >| Have you ever seen an application that creates millions of files create 
> >| them in random order?
> >
> >I can readily imagine one. An app which stashes things sent by random
> >other things (usenet/email attachment trollers? security cameras taking
> >thouands of still photos a day?). Mail services like hotmail. with a
> >zillion mail spools, being made and deleted and accessed at random...
> 
> Ok, they exist, but they are the 20% not the 80% case, and for that 
> reason preserving order in hashing is a legitimate optimization.

At least, I think you ought to make a random hash the default.  You're 
suffering badly on the 'random name' case, which I don't think is all that 
rare.  I'll run that test again with some of your hashes and see what happens.

> If names are truly random ordered, then the only optimization that can 
> help is compression so as to cause the working set to still fit into RAM.

You appear to be mixing up the idea of random characters in the names with 
random processing order.  IMHO, the exact characters in a file name should 
not affect processing efficiency at all, and I went out of my way to make 
that true with HTree.

On the other hand, the processing order of names does and will always matter 
a great deal in terms of cache footprint.

I should have done random stat benchmarks too, since we'll really see the 
effects of processing order there.  I'll put that on my to-do list.

--
Daniel
