Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKQAer>; Thu, 16 Nov 2000 19:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129380AbQKQAeh>; Thu, 16 Nov 2000 19:34:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37519 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129130AbQKQAec>;
	Thu, 16 Nov 2000 19:34:32 -0500
Date: Thu, 16 Nov 2000 19:04:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Feuer <David_Feuer@brown.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <4.3.2.7.2.20001116184203.00b45100@postoffice.brown.edu>
Message-ID: <Pine.GSO.4.21.0011161843430.13047-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, David Feuer wrote:

> At 06:10 PM 11/16/2000 -0500, you wrote:
> >Here's one more: you can't rename across the binding boundary. They _are_
> >mounts, so they avoid all that crap with loop creation on rename, etc.
> >Take a generic DAG and try to implement rename() analog on it. Have fun
> >catching the cases that would make the graph disconnected.
> 
> How could the graph become disconnected?  What does connectedness have to 
> do with naming?

If every way from foo to target goes through the source rename(source,target)
_will_ make the graph disconnected. Checking that for generic DAG is a hell.
Moreover, if there is an oriented path from source to target rename(source,
target) will create a loop. Again, good luck checking whether there is
such a path. If you think that loops are not a problem - fine, their presense
will make checking the first condition (for every node foo there exists a
path foo,p1,...,pn,target such that source doesn't belong to {p1,...,pn})
_much_ funnier.

For trees both conditions turn into (source is not an ancestor of target)
and that's easy to check. Try to do that for generic DAG. Solutions that
cost O(graph size) are _not_ acceptable - graph is the whole directory
structure.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
