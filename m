Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284529AbRLJW4L>; Mon, 10 Dec 2001 17:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284736AbRLJWzw>; Mon, 10 Dec 2001 17:55:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54213 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284529AbRLJWzf>;
	Mon, 10 Dec 2001 17:55:35 -0500
Date: Mon, 10 Dec 2001 17:55:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <UTC200112101936.TAA283032.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0112101739580.14238-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001 Andries.Brouwer@cwi.nl wrote:

>     From viro@math.psu.edu Mon Dec 10 17:50:02 2001
> 
>     Basically you propose to take the current system, replace it with
>     something without clear memory management ("let it leak") and then
>     try to fix the resulting mess.
> 
> Al - you are using debating tricks instead of logic, using
> negative words ("unclear", "leak", "mess") instead of arguments.
> Maybe you are unable to refute the soundness of the system I propose?

<blink>
 
> It is quite possible that I overlook some detail.
> On the other hand, I have been running these systems.
> You are not able to convince me that something is wrong
> just by handwaving. Real arguments are required.

> What I do is go from the present situation, in a series of steps,
> to a new situation where the source looks different but the
> system behaves provably the same. Consequently, no "fixing"
> is required. "Mess" is a matter of taste, I'll not discuss that
> except by saying that I vastly prefer the situation without arrays.
> "Leak" is false. "Dangling pointers" is false.

What???  You've just said that on the first stage you are not going to
free these objects and then add freeing them and audit the whole thing 
at that point.

The first is commonly known as leak (objects are allocated but not freed).
Dangling pointers is what you will have to fight during that audit -
places where something retains kdev_t after your object had been freed.

Let me rephrase it: with your plan we will have much more complex audit
needed at the moment when you introduce freeing your objects.  Reason:
it will have to involve all subsystems using kdev_t at once.  That's
my problem with your plan.  Sigh...

