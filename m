Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284736AbRLJXeh>; Mon, 10 Dec 2001 18:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLJXe1>; Mon, 10 Dec 2001 18:34:27 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8143 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284736AbRLJXeS>;
	Mon, 10 Dec 2001 18:34:18 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 23:33:41 GMT
Message-Id: <UTC200112102333.XAA283832.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: Linux/Pro  -- clusters
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alexander Viro <viro@math.psu.edu>

    What???  You've just said that on the first stage you are not going to
    free these objects and then add freeing them and audit the whole thing 
    at that point.

    The first is commonly known as leak (objects are allocated but not freed).

You are mistaken. Allocation without freeing is not a leak.
A leak is the situation where an unbounded amount of memory is lost
over time because of repeated allocs without corresponding frees.

Allocation of a known, bounded amount of memory is no leak.

(But this has very little relevance except in a shouting match.
Your next remarks are more interesting.)

    Dangling pointers is what you will have to fight during that audit -
    places where something retains kdev_t after your object had been freed.

    Let me rephrase it: with your plan we will have much more complex audit
    needed at the moment when you introduce freeing your objects.  Reason:
    it will have to involve all subsystems using kdev_t at once.  That's
    my problem with your plan.  Sigh...

I am not as afraid as you are.
Something retains kdev_t after the module has been unloaded?
That would be a bug, sure, both in the present and in the future kernel.
I listed the places where a kdev_t is stored (inode, sb, ..) and for
each of those it is true that these structs should be released before
or at module unload time, so that after module unload time no instances
of corresponding kdev_t are left.

Moreover, the audit happens fully automatically during the boring,
mechanical work. Indeed, already the separation of kdev_t into
kbdev_t and kcdev_t will touch all places where kdev_t occurs,
so that as a side effect one has a list of all places where one
of these is stored.

Andries
