Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSH3X3W>; Fri, 30 Aug 2002 19:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSH3X3W>; Fri, 30 Aug 2002 19:29:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19729 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313190AbSH3X3U>; Fri, 30 Aug 2002 19:29:20 -0400
Date: Fri, 30 Aug 2002 16:40:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
In-Reply-To: <15727.64653.78081.277222@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0208301634580.5430-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm..
 your <linux/cred.h> file exposes "struct ucred" to user space (or at
least has a #ifdef __KERNEL__ that does not protect it). Why?

Also, I don't see how this is going to solve the credential clone problem,
which basically says that sometimes you do _not_ want to do COW on the
credentials (when changing them when they are shared with other threads)  
and sometimes you do (when changing them when they are shared with a
background filesystem lookup).

Any ideas on that?

(And I _really_ don't like those trivial inline functions in [1/3] - I
think it's much better to just show that we're doing a pointer dereference
than trying to hide it behind some silly "current_fsuid()" inline
function).

		Linus

