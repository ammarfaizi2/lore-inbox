Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSF1TE2>; Fri, 28 Jun 2002 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSF1TE0>; Fri, 28 Jun 2002 15:04:26 -0400
Received: from mailhost.cs.clemson.edu ([130.127.48.6]:53651 "EHLO
	cs.clemson.edu") by vger.kernel.org with ESMTP id <S317114AbSF1TEY>;
	Fri, 28 Jun 2002 15:04:24 -0400
Date: Fri, 28 Jun 2002 15:06:42 -0400 (EDT)
From: Bendi Vinaya Kumar <vbendi@cs.clemson.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Skbuff Trimming
In-Reply-To: <p73k7okm7d1.fsf@oldwotan.suse.de>
Message-ID: <Pine.GSO.4.44.0206281432170.8345-100000@noisy.cs.clemson.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Jun 2002, Andi Kleen wrote:

> Bendi Vinaya Kumar <vbendi@cs.clemson.edu> writes:
>
> > But, it does not do the same on
> > "frag_list". Why?
>
> frag_list is not a general purpose skbuff facility and is not used by
> most protocols and not directly supported by most of skbuff.c It is just
> supported by some specific paths to enable lazy defragmenting. It is not
> an attempt to turn skbuffs into mbufs.
>
> -Andi

I agree with you. I couldn't find a
case when it (frag_list) is used.

Function

ip_rcv
(http://lxr.linux.no/source/net/ipv4/ip_input.c#L383)

uses two functions, namely,

1) pskb_may_pull, which might
   result in a call to __pskb_pull_tail

and 2) __pskb_trim, which might
       result in a call to ___pskb_trim.

Function __pskb_pull_tail
operates on data in both frags
array and frag_list. As mentioned
earlier, ___pskb_trim doesn't operate
on frag_list. Since these two functions
are called from ip_rcv, they must be
operating on the same sk buff. One function
handles frag_list, the other doesn't.

Isn't there an inconsistency in treatment here,
even though frag_list is not commonly used
in practice?

Thank you.

Regards,
Vinaya Kumar Bendi
P.S.: Kindly CC any answers/comments
      to vbendi@cs.clemson.edu.

