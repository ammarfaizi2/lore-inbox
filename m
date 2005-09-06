Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVIFHoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVIFHoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVIFHoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:44:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbVIFHoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:44:38 -0400
Date: Tue, 6 Sep 2005 00:44:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sonny Rao <sonny@burdell.org>
cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
In-Reply-To: <20050905195849.GA8683@kevlar.burdell.org>
Message-ID: <Pine.LNX.4.58.0509060038070.4316@evo.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
 <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org> <200508301007.11554@bilbo.math.uni-mannheim.de>
 <200509050949.38842@bilbo.math.uni-mannheim.de> <Pine.LNX.4.58.0509050117310.5316@evo.osdl.org>
 <20050905195849.GA8683@kevlar.burdell.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Sep 2005, Sonny Rao wrote:
> 
> Can this method detect breakages that are spread across more than one
> patch? I suppose it'll just trigger on the last patch commited in the
> set in this case?   

It will trigger on just the commit that introduces the user-visible 
breakage, so yes, it's usually the last in a series (or the first one, for 
that matter).

And it's not perfect. A problem that fades in and out is not something you
can do binary searching on. For example, sometimes a bug gets introduced
and ends up being dependent on things like cache alignment or some
variable layout etc, so you only _see_ the problem occasionally, and it 
ends up happening due to totally unrelated changes - then the bisection 
algorithm ends up being totally useles..

		Linus
