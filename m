Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315288AbSDWSJ3>; Tue, 23 Apr 2002 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315289AbSDWSJ2>; Tue, 23 Apr 2002 14:09:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26505 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315288AbSDWSJ2>;
	Tue, 23 Apr 2002 14:09:28 -0400
Date: Tue, 23 Apr 2002 14:09:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module() 
In-Reply-To: <10796.1019533533@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0204231407280.8087-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Apr 2002, Keith Owens wrote:

>   open /dev/foo
>     request_module(foo)
>       load foo, mark !MOD_USED_ONCE.

Another process:
	open /dev/foo
		MOD_INC_USE_COUNT
		mark MOD_USED_ONCE
	close /dev/foo
		MOD_DEC_USE_COUNT
rmmod -a
	kills module

>     continue with open, MOD_INC_USE_COUNT(foo), mark MOD_USED_ONCE.
			  module not loaded

