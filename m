Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284461AbRLJQtz>; Mon, 10 Dec 2001 11:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284460AbRLJQtq>; Mon, 10 Dec 2001 11:49:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55959 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284461AbRLJQtj>;
	Mon, 10 Dec 2001 11:49:39 -0500
Date: Mon, 10 Dec 2001 11:49:36 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <UTC200112090859.IAA242651.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0112101136490.14238-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001 Andries.Brouwer@cwi.nl wrote:

> [There is more to say, but I have to go, and maybe you and Linus
> can start telling me why this mechanical approach is silly.

Basically you propose to take the current system, replace it with
something without clear memory management ("let it leak") and then
try to fix the resulting mess.

I would rather switch code that uses kdev_t to use of dynamically
allocated structures.  Subsystem-by-subsystem.  Keeping decent
memory management on every step.

It's _way_ easier than trying to fix leaks and dangling pointers in
the fuzzy code we'd get with your approach.  Just look at the fun
Richard has with devfs right now.

It's easier to convert nth piece when you have n-1 done right and nothing
else using the objects in question.  Putting the whole thing together
first and the trying to fix it will be a living horror compared to that.

