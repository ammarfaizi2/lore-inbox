Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSAUOLB>; Mon, 21 Jan 2002 09:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbSAUOKv>; Mon, 21 Jan 2002 09:10:51 -0500
Received: from jabberwock.ucw.cz ([212.71.128.53]:35849 "EHLO
	jabberwock.ucw.cz") by vger.kernel.org with ESMTP
	id <S286647AbSAUOKj>; Mon, 21 Jan 2002 09:10:39 -0500
Date: Mon, 21 Jan 2002 15:10:37 +0100
From: bulb@ucw.cz
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 OOPS in tty code.
Message-ID: <20020121151037.A21622@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Tty device code causes oopses when closing /dev/console and devfs is used.
The bug is reproducible on 2.4.17 UML port. The uml arch code however does
not seem involved. The problem is, that the tty flip buffer flushing task
somehow remains in the tq_timer task queue when the tty struct is freed.
When the device is subsequently reopened (or the memory allocated for other
purpose), run_task_queue OOPSes when it comes acros the entry, that has
it's pointers overwriten.

The bug is regularly triggered in shutdown process (init seems to
close and reopen /dev/console).

As it's the user-mode port, I don't have standart OOPS message, but I am
willing to provide any backtraces and logs you request.

------------------------------------------------------------------------
					    - Jan Hudec <bulb@ucw.cz>
