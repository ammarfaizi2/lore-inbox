Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262227AbSJATqJ>; Tue, 1 Oct 2002 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262231AbSJATqJ>; Tue, 1 Oct 2002 15:46:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262227AbSJATqI>; Tue, 1 Oct 2002 15:46:08 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Date: Tue, 1 Oct 2002 19:53:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ancug3$iq1$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain> <Pine.LNX.4.33.0210011210030.1878-100000@penguin.transmeta.com>
X-Trace: palladium.transmeta.com 1033501880 24689 127.0.0.1 (1 Oct 2002 19:51:20 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Oct 2002 19:51:20 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0210011210030.1878-100000@penguin.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>
>Pease don't introduce more typedefs. They only hide what the hell the 
>thing is, which is actively _bad_ for structures, since passing a 
>structure by value etc is something that should never be done, for 
>example. 

Btw, just to avoid counter-examples: Linux does use structures and
typedefs occasionally to hide and force compiler typechecking on small
structures on purpose. We have a few places where we do things like

	typedef struct {
		unsigned int value;
	} atomic_t;

(and similar things for the page table entries etc). 

This is done because the things are often really regular scalars, but we
use the structure as a strict type checking mechanism. In this case,
using a typedef is fine, because we don't actually ever want to _access_
it as a structure, and the typedef provices exactly the kind of
information hiding that we need.

But type hiding for a real structure just doesn't make sense, since we
use it as a true structure, and hiding information just makes it harder
to see.

			Linus
