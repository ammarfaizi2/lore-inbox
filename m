Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263024AbSJBJyK>; Wed, 2 Oct 2002 05:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbSJBJyK>; Wed, 2 Oct 2002 05:54:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62729 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263024AbSJBJyJ>; Wed, 2 Oct 2002 05:54:09 -0400
Date: Wed, 2 Oct 2002 10:59:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Sigh, any ideas for a "dump_stack" name?
Message-ID: <20021002105933.A24770@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

Still not got 2.5.40 to build...

ARM has, since the year dot, used "dump_stack()" to display any threads
stack, and has the following prototype:

static void dump_stack(struct task_struct *tsk, unsigned long sp)

However, somewhere in the 2.5.34 -> 2.5.40 development, "dump_stack" got
used as a way to call "show_stack" with a value of zero on x86 (which is
another externally visible function.)

Firstly, "dump_stack" is misnamed.  It dumps stack and call trace
information.

Secondly, it creates a small problem - we're running out of names
to describe a function that displays _just_ stack contents without
any call trace information.

So, I propose to change the ARM version to the following, unless someone
else can come up with another name or a fix the poliferation of stack-
displaying functions that the generic kernel seems to require.

dump_random_numbers_from_thread_stack_yes_a_very_long_name_that_wont_clash_with_anything_else()

(Note: it may be a static function, but it is useful on to make it public
for occasional debugging.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

