Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTHBUzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTHBUzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:55:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60306 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270321AbTHBUzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:55:24 -0400
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland McGrath <roland@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308021908.h72J82x10422@magilla.sf.frob.com>
References: <200308021908.h72J82x10422@magilla.sf.frob.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059857483.20306.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2003 21:51:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-02 at 20:08, Roland McGrath wrote:
> The problem exists with uids/gids as well, in the sense that they are
> changed per-thread but POSIX semantics are that setuid et al affect the
> whole process (i.e. all threads in a thread group).  I emphatically agree
> that this should be changed, and I hope we can get it done in 2.6. 

There are two reasons the uid/gid stuff can't change.

#1 Lots of non posix afflicted intelligent programmers use the per
thread uid stuff in daemons. Its really really useful

#2 Linux fundamentally assumes your security credentials don't change
mid syscall except in the specific calls we intend to.

#2 is not sanely soluble for 2.6, and of questionable value anyway, #1
is a very good reason for making libc fix up this obscure posix
stupidity itself.

Lets face it how many posix pthreads app have -performance critical
setuid/getid calls ?

