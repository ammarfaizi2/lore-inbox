Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTETCfC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 22:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTETCfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 22:35:02 -0400
Received: from dp.samba.org ([66.70.73.150]:688 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263493AbTETCfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 22:35:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] fix do_fork() return value
Date: Tue, 20 May 2003 12:46:44 +1000
Message-Id: <20030520024801.535E02C002@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# Noticed by Julie DeWandel <jdewand@redhat.com>.
# 
# do_fork() needs to return the pid (or error), not the pointer to the
# resulting process structure.  The process structure may not even be
# valid any more, since do_fork() has already woken the process up (and as
# a result it might already have done its thing and gone away).
# 
# Besides, doing it this way cleans up the users, which all really just
# wanted the pid or error number _anyway_.

Just FYI: the change was done in the first place to allow spawning a
new init thread as CPUs come up.  But now we have copy_process it can
be done neatly (it should also be done out of keventd so we get a
clean thread, but that's another story).

Note that this version also has a (theoretical) race, except hidden
by the time to wrap PIDs ie. "never happens".

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
