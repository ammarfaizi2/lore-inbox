Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbRAKOSz>; Thu, 11 Jan 2001 09:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAKOSh>; Thu, 11 Jan 2001 09:18:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:54738 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130306AbRAKOSZ>;
	Thu, 11 Jan 2001 09:18:25 -0500
Date: Thu, 11 Jan 2001 14:13:30 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010111141330.H25375@redhat.com>
In-Reply-To: <E14GQyR-0000mh-00@the-village.bc.nu> <Pine.LNX.4.10.10101101210080.4572-100000@penguin.transmeta.com> <20010111125604.A17177@redhat.com> <14941.45349.131276.684932@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <14941.45349.131276.684932@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Jan 11, 2001 at 02:12:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 11, 2001 at 02:12:05PM +0100, Trond Myklebust wrote:
> 
>  What's wrong with copy-on-write style semantics? IOW, anyone who
> wants to change the credentials needs to make a private copy of the
> existing structure first.

Because COW only solves the problem if each task is only changing its
own, local, private copy of the credentials.  Posix threads demand
that one thread changing credentials also affects all the other
threads immediately, and making your own local private copy won't help
you to change the other tasks' credentials safely.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
