Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSKGPl0>; Thu, 7 Nov 2002 10:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSKGPl0>; Thu, 7 Nov 2002 10:41:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56845 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261299AbSKGPlW>; Thu, 7 Nov 2002 10:41:22 -0500
Date: Thu, 7 Nov 2002 07:48:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <m14ratepbf.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0211070745120.5567-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Nov 2002, Eric W. Biederman wrote:
> 
> In staging the image we allocate a whole pile of pages, and keep them
> locked in place.  Waiting for years potentially until the machine
> reboots or panics.   This memory is not accounted for anywhere so no
> one can see that we have it allocated, which makes debugging hard.

So how about facing the fact that my "vmalloc()" approach actually solves
all these issues. The memory is visible to the rest of the system (few
things care about it right now, but it _is_ accounted for and things like
/dev/kmem will actually see it etc).

And the vmalloc() approach is even portable, so one of the two phases is 
something that is totally generic (and the second phase is almost totally 
architecture-dependent anyway). 

		Linus

