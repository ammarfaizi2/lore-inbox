Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272365AbRHYAxI>; Fri, 24 Aug 2001 20:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272370AbRHYAws>; Fri, 24 Aug 2001 20:52:48 -0400
Received: from web10901.mail.yahoo.com ([216.136.131.37]:2576 "HELO
	web10901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272365AbRHYAwq>; Fri, 24 Aug 2001 20:52:46 -0400
Message-ID: <20010825005302.34876.qmail@web10901.mail.yahoo.com>
Date: Fri, 24 Aug 2001 17:53:02 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108242028270.19796-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alexander Viro <viro@math.psu.edu> wrote:
> On Fri, 24 Aug 2001, Brad Chapman wrote:
> > > > 	What do you think, sir?
> > > 
> > > 	Use different inline functions for signed and unsigned.
> > > Explicitly.
> > 
> > 	OK. That sounds reasonable, but do we want to do another forced
> > change, or do we want to hide it? That seems to be the root of the problem:
> > keeping the same API but making it work _right_.
> 
> Existing API is wrong.  "Hiding" is precisely what's wrong here - we
> use the same name for two subtly different functions.

Mr. Viro,

	OK. The existing API is wrong and the new min()/max() macros are the
right way to properly compare values. However, we could always add a config 
option to enable a compatibility macro, which would use typeof() on one of the 
two variables and then call the real min()/max(). Something like this (just an
example):

#ifdef CONFIG_ALLOW_COMPAT_MINMAX
#define proper_min(t, a, b)	((t)(a) < (t)(b) ? (a) : (b))
#define proper_max(t, a, b)	((t)(a) > (t)(b) ? (a) : (b))
#define min(a, b)		proper_min(typeof(a), a, b)
#define max(a, b)		proper_max(typeof(a), a, b)
#else
#define min(t, a, b)		((t)(a) < (t)(b) ? (a) : (b))
#define max(t, a, b)		((t)(a) < (t)(b) ? (a) : (b))
#endif

	Unfortunately, this would violate your idea that "hiding" the real
code behind compatibility stuff is C++esque, and, IYO, an Evil Thing(tm). That
just leaves me with one question to everybody: 	

	<rant type="question" intensity="30%">
	Why did Linus change this out of /dev/null and suddenly run off!?
	</rant>

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
