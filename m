Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263176AbTCLNd3>; Wed, 12 Mar 2003 08:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbTCLNd3>; Wed, 12 Mar 2003 08:33:29 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:48514 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S263176AbTCLNd2>;
	Wed, 12 Mar 2003 08:33:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Zack Brown <zbrown@tumblerings.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Wed, 12 Mar 2003 14:48:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200303120544.h2C5ibMY008372@eeyore.valparaiso.cl>
In-Reply-To: <200303120544.h2C5ibMY008372@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030312134412.4232B40CE0@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Mar 03 06:44, Horst von Brand wrote:
> There is no universal "before" and "after", even within one repository;

Sure there is, e.g., by incrementing master transaction number on the 
repository database.

> there might be changes that can't be ordered. I.e., changes to files foo
> and bar are independent, and might have happened in any order for the same
> result. Same for all non-overlapping changes.

I think what you're saying is that the repository may be ordered in more than 
one way at the same time.  Transaction serial number is just one way.  
Whatever else is recorded in the repository, at least there ought to be a 
serial number on every transaction, a simple unstructured counter.  With just 
this serial number you already have a way to roll back the entire repository 
to any point in the past, provided all repository transactions are reversible.

For dependencies between changes, rather than any fixed ordering, it's better 
to record the actual precedence information, i.e., "a before b", where a and 
b are id numbers of changes (I think everybody agrees changes are first class 
objects).  These precedence relations can be determined automatically: if two 
changes do not occur in the same file, there is no certainly no precedence 
relation.  If two changes overlap the same text, then there is a precedence 
relation.  If two changes do not overlap, there may or may not be a 
precedence relation, depending on whether the changes are exact deltas or 
deltas-with-context, and if the latter, whether the context is unambiguous.

Once you have the precedence relations, there are all kinds of useful things 
you can do with them.

Regards,

Daniel
