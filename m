Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTEIJ2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTEIJ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:28:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:14148 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262413AbTEIJ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:28:19 -0400
Date: Fri, 9 May 2003 02:40:51 -0700
Message-Id: <200305090940.h499ep513112@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@digeo.com>
X-Fcc: ~/Mail/linus
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
In-Reply-To: Andrew Morton's message of  Friday, 9 May 2003 02:19:21 -0700 <20030509021921.166f82fc.akpm@digeo.com>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nasty.  Maybe the best approach is to mostly uninline the access_ok()
> check.  Do the check for constant-sized small copies first, so those guys
> still do the access_ok() check inline; uninline the rest.

That was the only thing I could think of too.  I haven't made any attempt
to figure out how much of the code size comes from the various inlined
user-memory copying functions that call access_ok, and could be reworked
not to inline any of the uncommon paths, vs direct uses of access_ok in
miscellaneous code.
