Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286363AbRLJTwq>; Mon, 10 Dec 2001 14:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286365AbRLJTwh>; Mon, 10 Dec 2001 14:52:37 -0500
Received: from hera.cwi.nl ([192.16.191.8]:29876 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S286363AbRLJTwZ>;
	Mon, 10 Dec 2001 14:52:25 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 19:51:39 GMT
Message-Id: <UTC200112101951.TAA270246.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu
Subject: Re: Linux/Pro  -- clusters
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From alan@lxorguk.ukuu.org.uk Mon Dec 10 18:01:03 2001

    And it means we can get proper refcounting. Which as the maintainer of
    two block drivers that support dynamic volume create/destroy is remarkably
    good news.

You say this as if that would be a difference between the two
approaches. I don't think it is.

My goal was: allow large device numbers.
The subgoal: get rid of the arrays since these do not allow large indices.
The approach: make kdev_t a pointer to some random structure.

Now that I have achieved my goal, if you come along and want
refcounting, it seems to me that all I have to do is add a field
refcount to this struct, and have xget() and xput() routines
increase or decrease this number.

Maybe you are confused because usually one has a structure
that keeps track of all references to itself, so that the structure
can be freed when the number drops to zero. I do not need such refcounting
for a kdev_t, but it is very easy to keep track of the number of openers,
the number of inodes, or whatever you would like to count.
After all, anything you do with the device gets called with
a kdev_t argument, so nothing is easier than having open() increase
and close() decrease some field.

Andries
