Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285155AbRLFRVF>; Thu, 6 Dec 2001 12:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLFRU4>; Thu, 6 Dec 2001 12:20:56 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:38148 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285155AbRLFRUn>;
	Thu, 6 Dec 2001 12:20:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Ext2 directory index: ALS paper and benchmarks
Date: Thu, 6 Dec 2001 18:22:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16Bppx-0000mN-00@starship.berlin> <3C0F7659.1090701@namesys.com>
In-Reply-To: <3C0F7659.1090701@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16C2EN-0000pz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 02:44 pm, Hans Reiser wrote:
> Daniel Phillips wrote:
> >On December 6, 2001 04:56 am, Hans Reiser wrote:
> >>>On December 6, 2001 04:41 am, you wrote:
> >>>
> >>>>ReiserFS is an Htree by your definition in your paper, yes?
> >>>>
> >>>You've got a hash-keyed b*tree over there.  The htree is fixed depth.
> >>>
> >>B*trees are fixed depth.  B-tree usually means height-balanced.  
> >
> >I was relying on definitions like this:
> >
> >  B*-tree
> >
> >  (data structure)
> >
> >  Definition: A B-tree in which nodes are kept 2/3 full by redistributing
> >  keys to fill two child nodes, then splitting them into three nodes.
> 
> This is the strangest definition I have read.  Where'd you get it?

This came from:

   http://www.nist.gov/dads/HTML/bstartree.html

Here's another, referring to Knuth's original description:

   http://www.cise.ufl.edu/~jhammer/classes/b_star.html

> >To tell the truth, I haven't read your code that closely, sorry, but I got 
> >the impression that you're doing rotations for balancing no?  If not then 
> 
> What are rotations?

Re-rooting a (sub)tree to balance it.  <Pulls Knuth down from shelf>
For a BTree, rotating means shifting keys between siblings rather than 
re-parenting.  (The latter would change the path lengths and the result 
wouldn't be a BTree.)

So getting back to your earlier remark, when examined under a bright light, 
an HTree looks quite a lot like a BTree, the principal difference being the 
hash and consequent collision handling.  An HTree is therefore a BTree with 
wrinkles.

<reads more> But wait, you store references to objects along with keys, I 
don't.  So where does that leave us?

By the way, how do you handle collisions?  I see it has something to do with 
generation numbers, but I haven't fully decoded the algorithm.

Fully understanding your code is going to take some time.  This would 
go faster if I could find the papers mentioned in the comments, can you point 
me at those?

--
Daniel

