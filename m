Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbTC0U5y>; Thu, 27 Mar 2003 15:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbTC0U5x>; Thu, 27 Mar 2003 15:57:53 -0500
Received: from cs.columbia.edu ([128.59.16.20]:52668 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S261372AbTC0U5w>;
	Thu, 27 Mar 2003 15:57:52 -0500
Subject: process creation/deletions hooks
From: Shaya Potter <spotter@yucs.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048799290.31010.62.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Mar 2003 16:08:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to write a module that does it's own accounting of
processes as they are created and deleted.  We have an extremely ugly
hack of taking care of process creation (wrap fork() and clone() in a
syscall wrapper, as that's the only way processes can be created).  

However, doing the same for exit() doesn't work, because processes don't
have to call exit() to die, but can be killed any of number of ways, and
go straight to the do_exit() code.

I would imagine one would hook a void * function that takes some sort of
defined argument, perhaps a pointer to the task_struct (as it will be
called in do_exit, it would seem locking shouldn't be an issue) and what
the function is allowed to do would be defined.

Would people be for/against an interface that allows for modules to
register functions that can be called on process creation/deletion.  It
would help us avoid the hacks, such as I described, and I imagine could
have benefit others.

thanks,

shaya

