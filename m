Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRDSR7T>; Thu, 19 Apr 2001 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRDSR7J>; Thu, 19 Apr 2001 13:59:09 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:49166 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131630AbRDSR7B>; Thu, 19 Apr 2001 13:59:01 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Children first in fork
Date: 19 Apr 2001 10:58:45 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9bn90l$anp$1@penguin.transmeta.com>
In-Reply-To: <20010419133538.A28654@quatramaran.ens.fr> <NCBBLIEPOCNJOAEKBEAKAEEJOHAA.davids@webmaster.com> <200104191256.OAA31141@quatramaran.ens.fr> <9bn3sr$fer$1@picard.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9bn3sr$fer$1@picard.cistron.nl>,
Wichert Akkerman <wichert@cistron.nl> wrote:
>
>What you can do is what strace does: insert a loop instruction after
>the fork or clone call and remove that when the call returns.

You're probably even better off just intercepting the fork, turning it
into a clone, and setting the CLONE_PTRACE option. Which (together with
tracing the parent, which you will obviously be doing already in order
to do all this in the first place) will nicely cause the child to get an
automatic SIGSTOP _and_ be already traced.

Not that I've tested it myself.

		Linus
