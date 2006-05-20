Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWETPRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWETPRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWETPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:17:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17366 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964863AbWETPRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:17:08 -0400
Subject: Re: [PATCH] 2-ptrace_multi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Daniel Jacobowitz <dan@debian.org>, Renzo Davoli <renzo@cs.unibo.it>,
       Ulrich Drepper <drepper@gmail.com>, osd@cs.unibo.it,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605192217.30518.ak@suse.de>
References: <20060518155337.GA17498@cs.unibo.it>
	 <20060519174534.GA22346@cs.unibo.it>
	 <20060519201509.GA13477@nevyn.them.org>  <200605192217.30518.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 20 May 2006 15:37:05 +0100
Message-Id: <1148135825.2085.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-05-19 at 22:17 +0200, Andi Kleen wrote:
> > I believe the conclusion, when this was last discussed, was that this
> > is not true and could be fixed.
> 
> iirc the main problem was mmap of /proc/*/mem. write can be probably 
> enabled after some auditing.
> 
> Alan hacked on this iirc so he might comment.

The stuff I hacked on was to solve the problem that "/proc/xxx/mem"
changed meaning while open. That is if you did opens on proc/self/mem
and passed the fd to someone they got *their own* /proc/self/mem. 

That can cause mayhem if you do

	fd = open /proc/self/mem
	dup(fd, 2);
	dup(fd, 1);
	seek to right spot
	exec setuid binary in a way it prints and self patches.

I think the general cases of write and mmap can probably be enabled with
care. Clearly you can do it via ptrace so therefore ptrace equivalent
permissions is a beginning point. Someone needs to audit the mm
implications carefully because the old DOSemu mmap of /proc/self trick
did break stuff and the write case might have similar problems.

Alan

