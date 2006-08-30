Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWH3Slx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWH3Slx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWH3Slw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:41:52 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:6807 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751215AbWH3Slw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:41:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [S390] cio: kernel stack overflow.
Date: Wed, 30 Aug 2006 18:41:43 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ed4m57$gb0$1@taverner.cs.berkeley.edu>
References: <20060830124047.GA22276@skybase> <ed4gno$d29$1@taverner.cs.berkeley.edu> <18d709710608301052u1307139dpf6e3b2da6e7bfcbe@mail.gmail.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1156963303 16736 128.32.168.222 (30 Aug 2006 18:41:43 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 30 Aug 2006 18:41:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky  wrote:
>-      chp->dev = (struct device) {
>-              .parent  = &css[0]->device,
>-              .release = chp_release,
>-      };
>+      chp->dev.parent = &css[0]->device;
>+      chp->dev.release = chp_release;

>On 8/30/06, David Wagner <daw@cs.berkeley.edu> wrote:
>Unless I'm missing something, it looks to
>me like this diff causes a change in the semantics of the code.

Julio Auto wrote:
>I can't see the semantic change.

Maybe "semantic change" isn't the right term.  I'm not sure how gcc
handles the case where some field (like .bus) is missing from the C99
initializer as the struct device is created -- but it seemed plausible to
me that gcc might guarantee that all missing fields are automatically
initialized to 0 when the struct is constructed.  If this is the
case, then the semantic change is that the original code guarantees
to initialize chp->dev.bus to 0, whereas the proposed replacement code
does not.  I don't know whether gcc actually promises to initialize to
0 all unmentioned fields, or whether the C standard requires that, but
you could imagine some compiler making that promise (it is a reasonable
thing to do).
