Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319267AbSH2RSq>; Thu, 29 Aug 2002 13:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319268AbSH2RSq>; Thu, 29 Aug 2002 13:18:46 -0400
Received: from ns.suse.de ([213.95.15.193]:34316 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319267AbSH2RSp>;
	Thu, 29 Aug 2002 13:18:45 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
References: <20020829031008.T7920@devserv.devel.redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.44.0208290955280.2070-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Aug 2002 19:23:07 +0200
In-Reply-To: Linus Torvalds's message of "29 Aug 2002 18:57:01 +0200"
Message-ID: <p737ki9shok.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Thu, 29 Aug 2002, Jakub Jelinek wrote:
> > 
> > Well, IMHO at least for the more recent GCC versions kernel
> > should leave the job to GCC (ie. either just prototype str* functions,
> > or define them to __builtin_str* variants).
> 
> I agree. That x86 strlen() inline is from 1991 with fixes ever after, and 
> pre-dates gcc having any support for inline at all. We're much more likely 
> to be better off just removing it these days. Is somebody willing to 
> compare code quality? I wouldn't be in the least surprised if gcc did a 
> better job these days..

It does a better job for near all the string.h stuff. x86-64 just uses
the builtins. Only exception  is memcpy, where it likes to call out of line 
memcpy when it is not absolutely sure about all the alignments 
(especally lots of casting causes that) 

Still having an empty (or the one from x86-64 ;) string.h should be fine.

-Andi
