Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268460AbTGLUKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268462AbTGLUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:10:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8084 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S268460AbTGLUKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:10:18 -0400
Date: Sat, 12 Jul 2003 21:23:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Peter Asemann <sipeasem@immd3.informatik.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: struct siginfo member si_fd not properly filled in handler after SIGIO (2.4.x) - offending POSIX specs?
Message-ID: <20030712202317.GA10954@mail.jlokier.co.uk>
References: <200307111426.h6BEQZi1001897@faui31x.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307111426.h6BEQZi1001897@faui31x.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, in addition to:

    if (fcntl(fd,F_SETOWN,getpid()) == -1) {perror("fault");}

you need to write:

    if (fcntl(fd,F_SETSIG,SIGIO) == -1) {perror("fault");}

The fcntl() man page describes F_SETSIG.  You'll also need to #define
_GNU_SOURCE as F_SETSIG isn't defined otherwise.

Enjoy,
-- Jamie
