Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266434AbUGJVSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUGJVSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUGJVSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:18:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266434AbUGJVSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:18:35 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Jakub Jelinek <jakub@redhat.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au>
	<20040708120719.GS21264@devserv.devel.redhat.com>
	<20040708205225.GI28324@fs.tum.de>
	<20040708210925.GA13908@devserv.devel.redhat.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 18:17:29 -0300
In-Reply-To: <20040708210925.GA13908@devserv.devel.redhat.com>
Message-ID: <or7jtbpno6.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  8, 2004, Arjan van de Ven <arjanv@redhat.com> wrote:

> the problem I've seen is that when gcc doesn't honor normal inline, it will
> often error out if you always inline....

Because the always_inline was designed to mark functions that *must*
be inlined otherwise the program breaks (e.g., early dynamic loader
code where you still can't do function calls), not as an
`I'd-really-like-this-to-be-inlined-dammit' flag.

We could add another attribute/keyword/whatever to give a stronger
inline hint, but that would still leave room for the compiler to
decide it can't inline the function for whatever reason.  So you have
to know what to demand from the compiler:
inline-or-fail-because-there's-no-point-otherwise (attribute
always_inline) or inline-if-it-makes-the-program-faster (inline
keyword).  The latter is obviously based on heuristics, so it
sometimes gets things wrong, especially when inlining would enable a
lot of simplification that the compiler can't foresee without actually
doing the work and somehow backtracking if it turns out to not be
profitable (which would still be a guess).

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
